import 'package:flutter/material.dart';
import '../models/mock_data.dart';
import '../theme/app_colors.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardDark.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // White Square Icon Box (matching reference image)
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: transaction.categoryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              transaction.icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),

          // Title & Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.date,
                  style: TextStyle(
                    color: AppColors.textMuted.withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            '${transaction.isExpense ? '-' : '+'}₹${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: transaction.isExpense
                  ? AppColors.pinkOrange
                  : AppColors.successGreen,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
