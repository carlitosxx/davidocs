import 'package:flutter_riverpod/flutter_riverpod.dart';

final isSearchPendingDocumentsProvider = StateProvider<bool>((ref) {
  return false;
});
