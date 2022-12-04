import 'package:calculator/components/unfocus.dart';
import 'package:calculator/pages/home_page.dart';
import 'package:calculator/providers/toast_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      builder: (context, child) {
        return HookConsumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            ref.listen<Toast?>(toastProvider, (prev, state) {
              if (state != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: state.color,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      state.message,
                    ),
                  ),
                );
              }
            });
            return child ?? Container();
          },
          child: Unfocus(
            child: child!,
          ),
        );
      },
      home: HomePage(),
    );
  }
}
