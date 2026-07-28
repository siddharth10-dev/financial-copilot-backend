import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../widgets/tactile_button.dart';

class ConnectBankScreen extends StatelessWidget {
  const ConnectBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkSlate,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar (Step 1 of 5)
              Row(
                children: [
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.vibrantYellow, borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(width: 6),
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.cardDark, borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(width: 6),
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.cardDark, borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(width: 6),
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.cardDark, borderRadius: BorderRadius.circular(2)))),
                ],
              ),
              const SizedBox(height: 32),

              const Text(
                'Connect Bank Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Connect your bank via Account Aggregator (Setu / Onemoney) for real-time safe-to-spend tracking.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: AppColors.textMuted.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 32),

              // Supported Banks List Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  children: [
                    _buildBankTile('HDFC Bank', 'Savings Account', Icons.account_balance_rounded),
                    const Divider(color: AppColors.darkSlate, height: 24),
                    _buildBankTile('ICICI Bank', 'Checking Account', Icons.account_balance_rounded),
                    const Divider(color: AppColors.darkSlate, height: 24),
                    _buildBankTile('State Bank of India (SBI)', 'Student Account', Icons.account_balance_rounded),
                  ],
                ),
              ),

              const Spacer(),

              TactileButton(
                onTap: () => context.go('/onboarding/import-transactions'),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.vibrantYellow,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(
                    child: Text(
                      'Connect via Account Aggregator',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkSlate,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Center(
                child: GestureDetector(
                  onTap: () => context.go('/onboarding/user-profile-setup'),
                  child: const Text(
                    'Skip for now (Use manual entry)',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBankTile(String name, String type, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.purple.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.vibrantYellow, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              Text(
                type,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textMuted, size: 16),
      ],
    );
  }
}
