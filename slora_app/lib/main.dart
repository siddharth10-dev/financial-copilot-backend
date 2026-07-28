import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/auth/welcome_screen.dart';

void main() {
  runApp(const SloraApp());
}

class SloraApp extends StatelessWidget {
  const SloraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slora AI Financial Copilot',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const WelcomeScreen(),
    );
  }
}
