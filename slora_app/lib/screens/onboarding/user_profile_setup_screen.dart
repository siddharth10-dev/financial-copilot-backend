import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../widgets/tactile_button.dart';

class UserProfileSetupScreen extends StatefulWidget {
  const UserProfileSetupScreen({super.key});

  @override
  State<UserProfileSetupScreen> createState() => _UserProfileSetupScreenState();
}

class _UserProfileSetupScreenState extends State<UserProfileSetupScreen> {
  final TextEditingController _allowanceController = TextEditingController(text: '50000');
  String _payFrequency = 'Monthly';

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
              // Progress Bar (Step 2 of 5)
              Row(
                children: [
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.vibrantYellow, borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(width: 6),
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.vibrantYellow, borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(width: 6),
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.cardDark, borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(width: 6),
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.cardDark, borderRadius: BorderRadius.circular(2)))),
                ],
              ),
              const SizedBox(height: 32),

              const Text(
                'Tell us about yourself',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your monthly allowance or family stipend amount to calculate your daily safe spending limit.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 32),

              // Monthly Allowance Input
              TextField(
                controller: _allowanceController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'Monthly Allowance (₹)',
                  labelStyle: const TextStyle(color: AppColors.textMuted),
                  prefixIcon: const Icon(Icons.currency_rupee_rounded, color: AppColors.vibrantYellow),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Payday Frequency',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: ['Monthly', 'Biweekly', 'Weekly'].map((freq) {
                  final isSelected = _payFrequency == freq;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _payFrequency = freq),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.purple : AppColors.cardDark,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            freq,
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const Spacer(),

              TactileButton(
                onTap: () => context.go('/onboarding/ai-budget-generation'),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.vibrantYellow,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(
                    child: Text(
                      'Generate AI Budget',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkSlate,
                      ),
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
}
