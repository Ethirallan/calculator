import 'package:hooks_riverpod/hooks_riverpod.dart';

enum CalcMode { basic, advanced }

final calcModeProvider = StateProvider<CalcMode>((ref) => CalcMode.advanced);
