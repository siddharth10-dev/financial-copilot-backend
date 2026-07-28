import 'package:flutter/material.dart';
import 'core/app_router.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SloraApp());
}

class SloraApp extends StatelessWidget {
  const SloraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Slora AI Financial Copilot',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerConfig: AppRouter.router,
    );
  }
}
