import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../widgets/tactile_button.dart';

class AddGoalScreen extends StatelessWidget {
  const AddGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkSlate,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add Saving Goal', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.white)),
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
              TextField(
                style: const TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  labelText: 'Goal Title (e.g. MacBook M3)',
                  labelStyle: const TextStyle(color: AppColors.textMuted),
                  prefixIcon: const Icon(Icons.stars_rounded, color: AppColors.vibrantYellow),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  labelText: 'Target Amount (₹)',
                  labelStyle: const TextStyle(color: AppColors.textMuted),
                  prefixIcon: const Icon(Icons.currency_rupee_rounded, color: AppColors.purple),
                  filled: true,
                  fillColor: AppColors.cardDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                ),
              ),
              const Spacer(),
              TactileButton(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Goal created!')));
                  context.pop();
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(color: AppColors.vibrantYellow, borderRadius: BorderRadius.circular(24)),
                  child: const Center(child: Text('Create Goal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.darkSlate))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
