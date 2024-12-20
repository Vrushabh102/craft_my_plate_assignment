import 'package:flutter_riverpod/flutter_riverpod.dart';

final pricePerPlateAfterDiscountProvider = StateProvider<int>((ref) {
  return 299;
});


final totalPriceWithoutDiscountProvider = StateProvider<int>((ref) {
  return 0;
});


final totalPriceWithDiscountProvider = StateProvider<int>((ref) {
  return 0;
});