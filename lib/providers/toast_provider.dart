import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final toastProvider = StateProvider<Toast?>((ref) {
  return null;
});

class Toast implements Exception {
  final String message;
  final Color color;
  const Toast(this.message, this.color);
}
