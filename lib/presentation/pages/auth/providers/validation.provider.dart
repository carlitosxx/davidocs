import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<String>((ref) {
  return '';
});

final visibilityValidationUser = StateProvider<bool>((ref) {
  return false;
});

final passwordProvider = StateProvider<String>((ref) {
  return '';
});

final visibilityValidationPassword = StateProvider<bool>((ref) {
  return false;
});
