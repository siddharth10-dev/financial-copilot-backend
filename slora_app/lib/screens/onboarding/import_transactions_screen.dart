import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';

class ImportTransactionsScreen extends StatefulWidget {
  const ImportTransactionsScreen({super.key});

  @override
  State<ImportTransactionsScreen> createState() => _ImportTransactionsScreenState();
}

class _ImportTransactionsScreenState extends State<ImportTransactionsScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/onboarding/user-profile-setup');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkSlate,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.purple.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const CircularProgressIndicator(
                  color: AppColors.vibrantYellow,
                  strokeWidth: 3,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Syncing Bank Data...',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Fetching 6 months of transaction history via Account Aggregator encrypted payload.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 40),

              // Skeleton Tiles
              _buildSkeletonTile(),
              const SizedBox(height: 12),
              _buildSkeletonTile(),
              const SizedBox(height: 12),
              _buildSkeletonTile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.darkSlate,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 120, height: 12, color: AppColors.darkSlate),
                const SizedBox(height: 6),
                Container(width: 60, height: 10, color: AppColors.darkSlate),
              ],
            ),
          ),
          Container(width: 50, height: 14, color: AppColors.darkSlate),
        ],
      ),
    );
  }
}
