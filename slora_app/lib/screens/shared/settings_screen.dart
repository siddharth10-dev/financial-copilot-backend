import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkSlate,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _buildTile('App Theme', 'Dark Slate Mode', Icons.dark_mode_rounded),
            _buildTile('Default Currency', 'INR (₹)', Icons.currency_rupee_rounded),
            _buildTile('Notifications', 'Overspend & Low Balance Alerts', Icons.notifications_active_rounded),
            _buildTile('Connected Banks', 'HDFC Bank (Account Aggregator)', Icons.account_balance_rounded),
            _buildTile('Security & Biometrics', 'Face ID / Passcode', Icons.fingerprint_rounded),
            _buildTile('Manage Subscription', 'Slora Free Student Plan', Icons.star_rounded),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => context.go('/welcome'),
              child: const Text('Log Out', style: TextStyle(color: AppColors.errorRed, fontWeight: FontWeight.w700, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.vibrantYellow, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
