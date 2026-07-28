import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GoalModel {
  final String id;
  final String title;
  final double savedAmount;
  final double targetAmount;
  final double progress; // 0.0 to 1.0
  final Color cardColor;
  final IconData icon;

  GoalModel({
    required this.id,
    required this.title,
    required this.savedAmount,
    required this.targetAmount,
    required this.progress,
    required this.cardColor,
    required this.icon,
  });
}

class TransactionModel {
  final String id;
  final String title;
  final String date;
  final double amount;
  final bool isExpense;
  final String category;
  final Color categoryColor;
  final IconData icon;

  TransactionModel({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.isExpense,
    required this.category,
    required this.categoryColor,
    required this.icon,
  });
}

class BudgetCategoryModel {
  final String name;
  final double spent;
  final double limit;
  final double percentage;
  final Color color;
  final IconData icon;

  BudgetCategoryModel({
    required this.name,
    required this.spent,
    required this.limit,
    required this.percentage,
    required this.color,
    required this.icon,
  });
}

class MockData {
  static const double safeToSpendToday = 46200.00;
  static const double monthlyAllowance = 50000.00;
  static const double totalSpentMonth = 3800.00;
  static const double totalBalance = 5560.43;

  static final List<GoalModel> goals = [
    GoalModel(
      id: 'g1',
      title: 'Housing Deposit',
      savedAmount: 453.00,
      targetAmount: 900.00,
      progress: 0.50,
      cardColor: AppColors.purple,
      icon: Icons.home_rounded,
    ),
    GoalModel(
      id: 'g2',
      title: 'Food Reserve',
      savedAmount: 453.00,
      targetAmount: 1500.00,
      progress: 0.30,
      cardColor: AppColors.cyan,
      icon: Icons.shopping_bag_rounded,
    ),
    GoalModel(
      id: 'g3',
      title: 'MacBook M3 Fund',
      savedAmount: 95000.00,
      targetAmount: 140000.00,
      progress: 0.68,
      cardColor: AppColors.pinkOrange,
      icon: Icons.laptop_mac_rounded,
    ),
    GoalModel(
      id: 'g4',
      title: 'Emergency Buffer',
      savedAmount: 25000.00,
      targetAmount: 50000.00,
      progress: 0.50,
      cardColor: AppColors.vibrantYellow,
      icon: Icons.savings_rounded,
    ),
  ];

  static final List<TransactionModel> transactions = [
    TransactionModel(
      id: 't1',
      title: 'Shopping',
      date: 'Jan 11, 12:23',
      amount: 211.00,
      isExpense: true,
      category: 'Shopping',
      categoryColor: AppColors.successGreen,
      icon: Icons.storefront_rounded,
    ),
    TransactionModel(
      id: 't2',
      title: 'Spotify Premium',
      date: 'Jan 11, 12:23',
      amount: 311.00,
      isExpense: true,
      category: 'Subscription',
      categoryColor: AppColors.cyan,
      icon: Icons.music_note_rounded,
    ),
    TransactionModel(
      id: 't3',
      title: 'Figma Subscription',
      date: 'Jan 11, 12:23',
      amount: 111.00,
      isExpense: true,
      category: 'Tools',
      categoryColor: AppColors.purple,
      icon: Icons.design_services_rounded,
    ),
    TransactionModel(
      id: 't4',
      title: 'Zomato Gourmet',
      date: 'Jan 10, 20:15',
      amount: 240.00,
      isExpense: true,
      category: 'Food',
      categoryColor: AppColors.pinkOrange,
      icon: Icons.restaurant_rounded,
    ),
    TransactionModel(
      id: 't5',
      title: 'Zepto Instant Groceries',
      date: 'Jan 09, 14:30',
      amount: 650.00,
      isExpense: true,
      category: 'Groceries',
      categoryColor: AppColors.vibrantYellow,
      icon: Icons.local_grocery_store_rounded,
    ),
    TransactionModel(
      id: 't6',
      title: 'Monthly Allowance (Dad)',
      date: 'Jan 01, 10:00',
      amount: 50000.00,
      isExpense: false,
      category: 'Income',
      categoryColor: AppColors.successGreen,
      icon: Icons.account_balance_wallet_rounded,
    ),
  ];

  static final List<BudgetCategoryModel> budgetCategories = [
    BudgetCategoryModel(
      name: 'Personal Need',
      spent: 4500.0,
      limit: 11250.0,
      percentage: 0.40,
      color: AppColors.purple,
      icon: Icons.person_rounded,
    ),
    BudgetCategoryModel(
      name: 'Groceries & Food',
      spent: 3487.0,
      limit: 11250.0,
      percentage: 0.31,
      color: AppColors.vibrantYellow,
      icon: Icons.shopping_basket_rounded,
    ),
    BudgetCategoryModel(
      name: 'Subscription & Tech',
      spent: 3375.0,
      limit: 11250.0,
      percentage: 0.30,
      color: AppColors.pinkOrange,
      icon: Icons.subscriptions_rounded,
    ),
    BudgetCategoryModel(
      name: 'Other & Buffer',
      spent: 1237.0,
      limit: 11250.0,
      percentage: 0.11,
      color: AppColors.cyan,
      icon: Icons.category_rounded,
    ),
  ];
}
