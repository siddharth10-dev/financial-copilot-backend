import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../widgets/tactile_button.dart';

class CreateGoalsScreen extends StatefulWidget {
  const CreateGoalsScreen({super.key});

  @override
  State<CreateGoalsScreen> createState() => _CreateGoalsScreenState();
}

class _CreateGoalsScreenState extends State<CreateGoalsScreen> {
  final List<String> _selectedGoals = ['Housing Deposit', 'Emergency Buffer'];

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
              // Progress Bar (Step 4 of 5)
              Row(
                children: [
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.vibrantYellow, borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(width: 6),
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.vibrantYellow, borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(width: 6),
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.vibrantYellow, borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(width: 6),
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.vibrantYellow, borderRadius: BorderRadius.circular(2)))),
                ],
              ),
              const SizedBox(height: 32),

              const Text(
                'What are you saving for?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select your primary savings goals. Funds allocated here are locked from daily safe-to-spend balance.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 28),

              _buildGoalChip('Housing Deposit', Icons.home_rounded),
              _buildGoalChip('MacBook M3 Fund', Icons.laptop_mac_rounded),
              _buildGoalChip('Emergency Buffer', Icons.savings_rounded),
              _buildGoalChip('Summer Vacation Trip', Icons.flight_takeoff_rounded),
              _buildGoalChip('New Phone Upgrade', Icons.phone_iphone_rounded),

              const Spacer(),

              TactileButton(
                onTap: () => context.go('/onboarding/complete'),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.vibrantYellow,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(
                    child: Text(
                      'Finish Setup',
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

  Widget _buildGoalChip(String title, IconData icon) {
    final isSelected = _selectedGoals.contains(title);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedGoals.remove(title);
          } else {
            _selectedGoals.add(title);
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.purple : AppColors.cardDark,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.white, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle_rounded : Icons.add_circle_outline_rounded,
              color: isSelected ? AppColors.vibrantYellow : AppColors.textMuted,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
