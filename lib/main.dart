import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_task/DI/dependency_injection.dart';
import 'package:test_task/presentation/assets_list_screen/assets_list_screen.dart';

Future<void> main() async {
  await setupLocator();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior()
          .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      home: AssetsListScreenWidget(),
    );
  }
}
