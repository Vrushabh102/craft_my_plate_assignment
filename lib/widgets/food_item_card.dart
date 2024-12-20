import 'dart:math';
import 'package:assignment_craft_my_plate/screens/item_selection_screen.dart';
import 'package:assignment_craft_my_plate/widgets/custom_page_route.dart';
import 'package:flutter/material.dart';

// FOOD ITEM CARD for showing food card in Platters screen

class FoodItemCard extends StatelessWidget {
  FoodItemCard({super.key});

  final List<String> foodItemNames = [
    '2 Starter',
    '1 Mains',
    '3 Drinks',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.asset(
                  'assets/food_platters.png',
                  fit: BoxFit.cover,
                  height: height * 0.24,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Best for 🍛 Pooja",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Image.asset('assets/icons/frame.png'),
              ),
            ],
          ),

          // details side
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Indian Soiree",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                const Text(
                  "7 Categories & 12 Items",
                  style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _itemTag("2 Starter"),
                    _itemTag("1 Mains"),
                    _itemTag("3 Drinks"),
                    _itemTag("2 Starter"),
                  ],
                ),
                SizedBox(
                  height: height * 0.07,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/food_item.png',
                              height: 40,
                              width: 50,
                            ),
                            Text(
                              foodItemNames[Random().nextInt(2)],
                              style: const TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "₹299",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "/guest",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4), // Add some spacing between the two texts if needed
                        Row(
                          children: [
                            Text(
                              "Add guest count to see ✨ ",
                              style: TextStyle(
                                color: Colors.grey,
                                letterSpacing: -0.4,
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              "Dynamic Price",
                              style: TextStyle(
                                color: Colors.purple,
                                letterSpacing: -0.4,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(child: const ItemSelectionScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              'Customize',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Image(
                              image: AssetImage('assets/icons/right_arrow.png'),
                              color: Colors.white,
                              fit: BoxFit.contain,
                              // height: 40,
                              // width: 40,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _itemTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
      ),
    );
  }
}
