import 'package:flutter/material.dart';
import 'package:melapay/app/router.dart';
import 'package:melapay/shared/themes/app_theme.dart';

class MelaPayApp extends StatelessWidget {
  const MelaPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MelaPay Wallet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: goRouter,
    );
  }
}
