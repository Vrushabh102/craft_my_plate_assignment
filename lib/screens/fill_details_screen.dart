import 'dart:developer';

import 'package:assignment_craft_my_plate/constants/colors.dart';
import 'package:assignment_craft_my_plate/constants/price_discount.dart';
import 'package:assignment_craft_my_plate/providers/guest_count_provider.dart';
import 'package:assignment_craft_my_plate/providers/price_per_plate_discount.dart';
import 'package:assignment_craft_my_plate/providers/providers.dart';
import 'package:assignment_craft_my_plate/providers/selected_date_provider.dart';
import 'package:assignment_craft_my_plate/screens/order_review_screen.dart';
import 'package:assignment_craft_my_plate/widgets/custom_page_route.dart';
import 'package:assignment_craft_my_plate/widgets/date_container.dart';
import 'package:assignment_craft_my_plate/widgets/fill_details_header.dart';
import 'package:assignment_craft_my_plate/widgets/time_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FillDetailsScreen extends ConsumerStatefulWidget {
  const FillDetailsScreen({super.key});

  @override
  ConsumerState<FillDetailsScreen> createState() => _FillDetailsScreenState();
}

class _FillDetailsScreenState extends ConsumerState<FillDetailsScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  // total guests
  double pricePerPlate = 299.0;
  double minPrice = 189.0;
  double maxPrice = 299.0;
  double discount = 0.20;
  String formattedDate = DateTime.now().toString().substring(0, 11);

  // to select and parse the date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      // formatting the date
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      formattedDate = formatter.format(picked);
      DateTime parsedDate = formatter.parse(formattedDate);
      setState(() {
        selectedDate = parsedDate;
      });

      ref.read(dateProvider.notifier).update(
        (state) {
          return formattedDate;
        },
      );
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    );
    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
      });
    }
    log('starttime$selectedStartTime');

    ref
        .read(startTimeProvider.notifier)
        .update((state) => selectedStartTime.format(context).substring(0, 5));
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    );
    if (picked != null && picked != selectedEndTime) {
      setState(() {
        selectedEndTime = picked;
      });
    }
    log('endtime$selectedEndTime');

    ref
        .read(endTimeProvider.notifier)
        .update((state) => selectedEndTime.format(context).substring(0, 5));
  }

  // function to calculate all form of prices....

  void calculatePrice(WidgetRef ref) {
    int guestCount = ref.read(guestCountProvider);
    int plateCount = ref.read(breakFastPlateCountProvider);

    // the discount function decides how much discount to give as per guests increases
    int discountPlatePrice = PriceDiscount.findPricePerPlate(guestCount: guestCount);

    // setting the price per plate after discount to provider
    ref.read(pricePerPlateAfterDiscountProvider.notifier).update((state) => discountPlatePrice);

    // finding total price without discount...
    int totalPriceWithoutDiscount = (plateCount * guestCount) * 299;

    // setting totalPriceWithoutDiscount price to the provider
    ref
        .read(totalPriceWithoutDiscountProvider.notifier)
        .update((state) => totalPriceWithoutDiscount);
    log('dis pri$totalPriceWithoutDiscount');

    int totalPriceWithDiscount = (plateCount * guestCount) * discountPlatePrice;

    // setting totalPriceWithDiscount price to the provider
    ref.read(totalPriceWithDiscountProvider.notifier).update((state) => totalPriceWithDiscount);
  }

  @override
  Widget build(BuildContext context) {

    // initially calculating the price
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculatePrice(ref);
    });
    
    int totalGuests = ref.watch(guestCountProvider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FB),

      // AppBar

      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const FillDetailsHeader(),
        centerTitle: true,
      ),

      // BODY
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Heading, service, text, edit button
          SizedBox(height: height * 0.02),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // SizedBox(width: width * 0.05),
                Image.asset('assets/icons/service.png'),
                SizedBox(width: width * 0.02),
                const Text(
                  "South Indian Breakfast",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: width * 0.025),
                Image.asset('assets/icons/pencil-square.png'),
              ],
            ),
          ),

          SizedBox(height: height * 0.02),

          // container for occasion birthday, date and time
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: height * 0.2,
            width: width,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // occasion birthday text and dropdown button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Occasion Birthday'),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                      color: Colors.grey.shade400,
                    )
                  ],
                ),

                Divider(
                  color: Colors.grey.shade400,
                  thickness: 0.5,
                ),

                const Text('Date and Time'),

                // Date container for showing date
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: DateContainer(
                          date: formattedDate,
                          gap: width * 0.02,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          _selectEndTime(context);
                          _selectStartTime(context);
                        },
                        child: TimeContainer(
                          // formatting the time to display in the screen
                          startTime: selectedStartTime.format(context).substring(0, 5),
                          endTime: selectedEndTime.format(context).substring(0, 5),
                          gap: width * 0.02,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: height * 0.02),

          // container for price per plate and total guests
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: height * 0.28,
            width: width,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // price per plate and disconted price row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Price Per Plate: ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '₹${ref.watch(pricePerPlateAfterDiscountProvider)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: ref.watch(pricePerPlateAfterDiscountProvider) < 280
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Row for total guests and increment/decrement button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Guests',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            ref.read(guestCountProvider.notifier).state--;
                            calculatePrice(ref);
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffE1E1E1),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$totalGuests',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            ref.read(guestCountProvider.notifier).state++;
                            calculatePrice(ref);
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                // Slider
                Column(
                  children: [
                    Slider(
                      value: totalGuests.toDouble(),
                      min: 10,
                      max: 1500,
                      divisions: 149,
                      label: '$totalGuests',
                      onChanged: (value) {
                        ref.watch(guestCountProvider.notifier).update((state) => value.toInt());
                        calculatePrice(ref);
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('10(min)'),
                          Text('1500'),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.05),

                // dynamic pricing text
                const Row(
                  children: [
                    Text(
                      '✨ DYNAMIC PRICING',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 12,
                        letterSpacing: 0,
                      ),
                    ),
                    Text(
                      '  more guests, more savings.',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),
          Container(
            color: Colors.white,
            height: height * 0.1,
            width: width,
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      direction: AxisDirection.right,
                      child: const OrderReviewScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.bottomCenter,
                  height: height * 0.07,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CustomColors.themePurple,
                  ),
                  child: const Center(
                    child: Text(
                      'Order Review',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
