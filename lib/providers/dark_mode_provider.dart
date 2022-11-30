import 'package:calculator/providers/shared_preferences_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>((ref) {
  final isDarkModeEnabled = ref.read(sharedUtilityProvider).getDarkModeState();
  return DarkModeNotifier(isDarkModeEnabled);
});

class DarkModeNotifier extends StateNotifier<bool> {
  DarkModeNotifier(this.enabled) : super(enabled);

  final bool enabled;

  toggleAppTheme(WidgetRef ref) {
    final isDarkModeEnabled =
        ref.read(sharedUtilityProvider).getDarkModeState();
    final toggleValue = !isDarkModeEnabled;

    ref.read(sharedUtilityProvider).setDarkModeState(toggleValue);

    state = toggleValue;
  }
}
