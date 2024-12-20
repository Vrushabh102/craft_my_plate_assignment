import 'package:assignment_craft_my_plate/widgets/food_item_card.dart';
import 'package:flutter/material.dart';

class PlattersBody extends StatelessWidget {
  const PlattersBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: 3, // Number of items (mock data)
      itemBuilder: (context, index) {
        return FoodItemCard();
      },
    );
  }
}