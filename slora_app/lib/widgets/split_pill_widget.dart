import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SplitPillWidget extends StatelessWidget {
  final String incomeText;
  final String spendingText;

  const SplitPillWidget({
    super.key,
    required this.incomeText,
    required this.spendingText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.vibrantYellow,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          // Income / Allowance Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Allowance',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkSlate.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  incomeText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.darkSlate,
                  ),
                ),
              ],
            ),
          ),

          // Vertical Divider
          Container(
            height: 36,
            width: 1.5,
            color: AppColors.darkSlate.withValues(alpha: 0.15),
          ),

          // Spendings Column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Spendings',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkSlate.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    spendingText,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkSlate,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
