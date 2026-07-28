import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';

class AiResultScreen extends StatelessWidget {
  const AiResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkSlate,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('AI Purchase Evaluation', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Verdict: YES', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.successGreen)),
                SizedBox(height: 12),
                Text('Safe to Spend After Purchase: ₹42,700.00', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.darkSlate)),
                SizedBox(height: 16),
                Text('Reasoning: Buying this item consumes 7.5% of your available daily buffer. Your Housing savings goal remains completely on track.', style: TextStyle(fontSize: 14, color: AppColors.darkSlate, height: 1.4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
