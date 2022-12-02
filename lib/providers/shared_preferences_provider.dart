import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedUtilityProvider = Provider<SharedUtility>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(sharedPreferences: sharedPrefs);
});

class SharedUtility {
  SharedUtility({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  bool getDarkModeState() {
    final Brightness brightness =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .platformBrightness;
    return sharedPreferences.getBool('dark') ?? brightness == Brightness.dark;
  }

  Future<bool> setDarkModeState(bool value) async {
    return await sharedPreferences.setBool('dark', value);
  }
}
