import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkSlate,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _buildNotificationTile('Safe-to-Spend Alert', 'You have ₹46,200 remaining for the rest of the month.', '10 mins ago', Icons.savings_rounded, AppColors.vibrantYellow),
            _buildNotificationTile('Bank Data Synced', 'HDFC Bank Account Aggregator refreshed transaction history.', '2 hours ago', Icons.sync_rounded, AppColors.cyan),
            _buildNotificationTile('Goal Progress', 'Housing Deposit reached 50% of target amount.', '1 day ago', Icons.stars_rounded, AppColors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationTile(String title, String body, String time, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                    Text(time, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(body, style: const TextStyle(color: AppColors.textMuted, fontSize: 13, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
