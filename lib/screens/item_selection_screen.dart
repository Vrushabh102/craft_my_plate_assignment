import 'dart:developer';

import 'package:assignment_craft_my_plate/providers/food_items_notifier_provider.dart';
import 'package:assignment_craft_my_plate/providers/providers.dart';
import 'package:assignment_craft_my_plate/screens/fill_details_screen.dart';
import 'package:assignment_craft_my_plate/widgets/custom_page_route.dart';
import 'package:assignment_craft_my_plate/widgets/item_selection_add_ons_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemSelectionScreen extends ConsumerStatefulWidget {
  const ItemSelectionScreen({super.key});

  @override
  ConsumerState<ItemSelectionScreen> createState() => _ItemSelectionScreenState();
}

class _ItemSelectionScreenState extends ConsumerState<ItemSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // add ons button
      floatingActionButton: AddOnsButton(height: height, width: width),
      backgroundColor: const Color(0xffF5F6FB),

      // appbar
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              SizedBox(width: width * 0.05),
              const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              SizedBox(width: width * 0.05),
              const Text(
                "South Indian Breakfast",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
              ),
              SizedBox(width: width * 0.025),
              Image.asset('assets/icons/pencil-square.png'),
            ],
          ),
        ),
      ),
      body: Hero(
        tag: 'customize-button',
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  // Left Categories
                  _buildLeftCategoryList(),
                  // Food Grid
                  Expanded(
                    child: _buildFoodGrid(ref),
                  ),
                ],
              ),
            ),
            // Bottom Price Bar
            _buildBottomPriceBar(),
          ],
        ),
      ),
    );
  }

  // Widget for Veg/Non-Veg Toggle
  Widget _buildVegNonVegToggle(
      String label, Color color, bool isSelected, ImageProvider icon, bool isVeg) {
    return Row(
      children: [
        ImageIcon(icon, color: color, size: 12),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(width: 10),
        isVeg ? Image.asset('assets/icons/veg_toggle.png') : const SizedBox(),
      ],
    );
  }

  // Widget for Left Categories
  Widget _buildLeftCategoryList() {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          _buildCategoryItem(
            "Starters",
            "2/2",
            'assets/starters.png',
            const Color(0xff00B85C),
            Colors.black,
            const Color(0xffECFDF3),
          ),
          _buildCategoryItem(
            "Mains",
            "2/2",
            'assets/mains.png',
            const Color(0xff6318AF),
            Colors.white,
            const Color(0xff6318AF),
          ),
          _buildCategoryItem(
            "Sweets",
            "0/1",
            'assets/sweets.png',
            Colors.grey.shade300,
            Colors.black,
            Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
    String title,
    String count,
    String imagePath,
    Color borderColor,
    Color textColor,
    Color backgroundColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(8),
              color: backgroundColor,
            ),
            child: Text(
              count,
              style: TextStyle(
                fontSize: 10,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for Food Grid
  Widget _buildFoodGrid(WidgetRef ref) {
    return Column(
      children: [
        // Veg/Non-Veg Toggle
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildVegNonVegToggle(
                  "Pure Veg", Colors.green, true, const AssetImage('assets/icons/leaf.png'), true),
              const SizedBox(width: 16),
              _buildVegNonVegToggle(
                "Non Veg",
                Colors.red,
                false,
                const AssetImage('assets/icons/non_veg_icon.png'),
                false,
              ),
            ],
          ),
        ),
        // const SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.66,
              crossAxisSpacing: 1,
              mainAxisSpacing: 20,
            ),
            itemCount: ref.read(foodItemAddedOrNotProvider).length,
            itemBuilder: (context, index) {
              var item = ref.watch(foodItemAddedOrNotProvider)[index];
              return Card(
                color: Colors.white,
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Food Image
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        item['image'],
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Food Name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        item["name"],
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    // const SizedBox(height: 8),

                    const Spacer(),

                    // Add/Added Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: item["added"] ? Colors.pink : Colors.white,
                          side: const BorderSide(color: Colors.pink),
                          minimumSize: const Size(double.infinity, 30),
                        ),
                        onPressed: () {
                          // method to change the state of the item, add <--> added
                          changeItemState(ref, index);
                        },
                        child: Text(
                          item["added"] ? "Added" : "Add",
                          style: TextStyle(
                            color: item["added"] ? Colors.white : Colors.pink,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // changing the breakfast item state from added/removed
  void changeItemState(WidgetRef ref, int index) {
    ref.watch(foodItemAddedOrNotProvider.notifier).update(
      (state) {
        state[index]['added'] = !state[index]['added']; // changing the state here

        bool isAdded = state[index]['added'];

        changeAddedItemCount(isAdded: isAdded);

        return [...state];
      },
    );
  }

  // to change the count of total breakfast items added/removed
  void changeAddedItemCount({required bool isAdded}) {
    if (isAdded) {
      // increasing the count by 1, as 1 item is added
      ref.read(breakFastPlateCountProvider.notifier).state++;
    } else {
      // decreasing the count by 1, as 1 item is removed
      ref.read(breakFastPlateCountProvider.notifier).state--;
    }
  }

  // Widget for Bottom Price Bar
  Widget _buildBottomPriceBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price per plate',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  Text(
                    '₹299',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '/Plate',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
          InkWell(
            onTap: () {
              log(ref.read(breakFastPlateCountProvider).toString());
              if (ref.read(breakFastPlateCountProvider) == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Please select altest one plate'),
                    behavior: SnackBarBehavior.fixed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                );

                return;
              }

              Navigator.push(
                context,
                CustomPageRoute(direction: AxisDirection.up, child: const FillDetailsScreen()),
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 45,
                vertical: 14,
              ),
              child: const Text(
                "Fill Details",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
