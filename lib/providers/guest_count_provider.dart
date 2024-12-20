import 'package:flutter_riverpod/flutter_riverpod.dart';

final guestCountProvider = StateProvider<int>((ref) {
  return 10;
});

