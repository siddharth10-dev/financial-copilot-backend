import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';

class MonthlyPlanScreen extends StatelessWidget {
  const MonthlyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkSlate,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Monthly Financial Plan', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: const SafeArea(
        child: Center(
          child: Text(
            'Monthly Financial Plan Blueprint',
            style: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
