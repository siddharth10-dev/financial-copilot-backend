import 'package:flutter/material.dart';
import '../../models/mock_data.dart';
import '../../theme/app_colors.dart';
import '../../widgets/goal_card.dart';
import '../../widgets/split_pill_widget.dart';
import '../../widgets/transaction_tile.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkSlate,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top White Section (Curved Bottom) - Matching middle phone in reference image
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 28),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Bar (Avatar + Name + Menu Icon)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: AppColors.purple.withValues(alpha: 0.15),
                              child: const Text(
                                'EH',
                                style: TextStyle(
                                  color: AppColors.purple,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Esther Howard',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkSlate,
                                  ),
                                ),
                                Text(
                                  'Welcome Back',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMuted.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.lightGray,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.grid_view_rounded,
                            color: AppColors.darkSlate,
                            size: 20,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Safe to Spend Hero Amount
                    const Text(
                      'Safe to Spend Today',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '₹46,200',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        color: AppColors.darkSlate,
                        letterSpacing: -1,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Yellow Split-Pill Component (Matching exact image component)
                    const SplitPillWidget(
                      incomeText: '+₹50,000',
                      spendingText: '-₹3,800',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Bottom Dark Section - Saving Goals & Transactions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Saving Goals Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Saving Goals',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz_rounded,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Horizontal Scrolling Goals List (Add Goal + Goal Cards)
                    SizedBox(
                      height: 165,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          AddGoalCard(onTap: () {}),
                          ...MockData.goals.map((g) => GoalCard(goal: g)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Recent Transactions Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Transactions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz_rounded,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Vertical Transaction List
                    ...MockData.transactions
                        .take(4)
                        .map((t) => TransactionTile(transaction: t)),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
