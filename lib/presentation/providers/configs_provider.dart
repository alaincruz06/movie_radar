import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDarkModeProvider = StateProvider<bool>((ref) {
  return false;
});

final localeProvider = StateProvider<Locale>((ref) {
  return const Locale('es', 'ES');
});
