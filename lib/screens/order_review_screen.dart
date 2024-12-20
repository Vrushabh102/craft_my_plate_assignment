import 'dart:developer';

import 'package:assignment_craft_my_plate/constants/colors.dart';
import 'package:assignment_craft_my_plate/providers/guest_count_provider.dart';
import 'package:assignment_craft_my_plate/providers/price_per_plate_discount.dart';
import 'package:assignment_craft_my_plate/providers/selected_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderReviewScreen extends ConsumerStatefulWidget {
  const OrderReviewScreen({super.key});

  @override
  ConsumerState<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends ConsumerState<OrderReviewScreen> {
  final int guests = 265;
  final DateTime selectedDate = DateTime(2024, 9, 11);
  final TimeOfDay selectedTimeStart = const TimeOfDay(hour: 0, minute: 30);
  final TimeOfDay selectedTimeEnd = const TimeOfDay(hour: 2, minute: 30);
  final double subtotal = 22200.0;
  final double total = 24600.0;
  final double discount = 8000.0;
  final double totalToPay = 41800.0;
  final double originalPrice = 90500.0;
  final double savings = 17130.0;

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return "${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period";
  }

  @override
  void initState() {
    // TODO: implement initState
    log(ref.read(guestCountProvider).toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    String dummyDate = '11/09/2024';
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FB),

      // APPBAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Order Review',
          style: TextStyle(fontSize: 16.5),
        ),
        centerTitle: true,
      ),

      //
      body: Column(
        children: [
          SizedBox(height: height * 0.02),

          // Container for order review
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/service.png',
                          width: 24,
                          height: 24,
                          color: CustomColors.themePurple,
                        ),
                        SizedBox(width: width * 0.02),
                        const Text(
                          "Millet Breakfast",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle edit action
                      },
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            color: Color(0xffED4596),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.person, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '${ref.read(guestCountProvider)}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.calendar_today, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      ref.watch(dateProvider) == '' ? dummyDate : ref.watch(dateProvider),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w100,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.access_time, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      ref.watch(startTimeProvider) == ''
                          ? '12:30 AM - 02:30'
                          : '${ref.watch(startTimeProvider)} - ${ref.watch(endTimeProvider)}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w100,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(
                  color: Colors.grey.shade200,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hide selected items',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Icon(Icons.keyboard_arrow_up),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade200,
                ),

                // Row for subtotal, price, taxes and charges text, and right arrow icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Subtotal',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: width * 0.03),
                            ref.read(guestCountProvider) >= 100
                                ? Text(
                                    '₹${ref.watch(totalPriceWithoutDiscountProvider)}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  )
                                : const SizedBox(),
                            SizedBox(width: width * 0.01),
                            Text(
                              '₹${ref.watch(totalPriceWithDiscountProvider)}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Incl. taxes and charges',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),

                    // right arrow in subtotal
                    const Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 18,
                      color: Color(0xff93999F),
                    )
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: height * 0.02),

          // total amount container
          Container(
            margin: const EdgeInsets.all(16.0),
            // padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: CustomColors.themePurple,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const SizedBox(width: 12),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "🥳 Hurray! You saved ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '₹${ref.read(totalPriceWithoutDiscountProvider) - ref.read(totalPriceWithDiscountProvider)}/-',
                              style: const TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const TextSpan(
                              text: " on total order",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // after the coupon, banner
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
                          ),
                          Text(
                            '₹${ref.read(totalPriceWithoutDiscountProvider)}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Text(
                                'Dynamic pricing discount ',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                            ],
                          ),
                          Text(
                            '- ${ref.read(totalPriceWithoutDiscountProvider) - ref.read(totalPriceWithDiscountProvider)}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'To Pay',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '₹${ref.read(totalPriceWithDiscountProvider)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // place order button
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  blurStyle: BlurStyle.outer,
                )
              ],
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: height * 0.1,
            width: width,
            child: Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'To pay',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '₹${ref.read(totalPriceWithDiscountProvider)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text('Thank you for buying..'),
                        ),
                      );
                    },
                    child: Container(
                      // margin: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.bottomCenter,
                      height: height * 0.07,
                      width: width * 0.5,
                      // width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: CustomColors.themePurple,
                      ),
                      child: const Center(
                        child: Text(
                          'Place order',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
