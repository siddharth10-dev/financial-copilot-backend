import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final String transactionId;

  const TransactionDetailsScreen({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkSlate,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Transaction Details', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: AppColors.purple,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.restaurant_rounded, color: AppColors.white, size: 32),
                    ),
                    const SizedBox(height: 16),
                    const Text('Zomato Gourmet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.white)),
                    const SizedBox(height: 4),
                    const Text('-₹240.00', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.pinkOrange)),
                    const SizedBox(height: 24),
                    const Divider(color: AppColors.darkSlate),
                    const SizedBox(height: 16),
                    _buildRow('Merchant', 'Zomato India'),
                    _buildRow('Category', 'Food & Dining'),
                    _buildRow('Date & Time', 'Jan 10, 2026 at 20:15'),
                    _buildRow('Payment Method', 'HDFC UPI'),
                    _buildRow('Status', 'Completed'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
          Text(value, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w700, fontSize: 14)),
        ],
      ),
    );
  }
}
