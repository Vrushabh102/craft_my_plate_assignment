import 'package:flutter_riverpod/flutter_riverpod.dart';

// final foodItemStateNotifierProvider = StateNotifierProvider<>(
// (ref) => FoodItemsNotifier(),
// );

// class FoodItemModel {
//   final String name;
//   final String imagePath;
//   final bool isAdded;

//   @immutable
//   FoodItemModel({
//     required this.name,
//     required this.imagePath,
//     required this.isAdded,
//   });
// }


// class FoodItemsNotifier extends StateNotifier {
  
//   FoodItemsNotifier(super.state);




// }



final foodItemAddedOrNotProvider = StateProvider<List<Map<String,dynamic>>>((ref) {
  List<Map<String, dynamic>> foodItems = [
    {
      "name": "Idli Sambar",
      "image": "assets/lili_sambar.png",
      "added": false,
    },
    {
      "name": "Appam",
      "image": "assets/appam.png",
      "added": false,
    },
    {
      "name": "Dosa",
      "image": "assets/dosa.png",
      "added": false,
    },
    {
      "name": "Wada",
      "image": "assets/wada.png",
      "added": false,
    },
    {
      "name": "Pongal",
      "image": "assets/pongal.png",
      "added": false,
    },
    {
      "name": "Puttu",
      "image": "assets/bonda.png",
      "added": false,
    },
  ];
  return foodItems;
});