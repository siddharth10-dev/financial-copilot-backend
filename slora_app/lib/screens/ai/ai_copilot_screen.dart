import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class AiCopilotScreen extends StatefulWidget {
  const AiCopilotScreen({super.key});

  @override
  State<AiCopilotScreen> createState() => _AiCopilotScreenState();
}

class _AiCopilotScreenState extends State<AiCopilotScreen> {
  final TextEditingController _itemController = TextEditingController(text: 'Sony Noise-Cancelling Headphones');
  final TextEditingController _costController = TextEditingController(text: '3500');

  bool _hasResult = true;
  String _verdict = 'YES';
  double _safeAfterPence = 42700.0;
  double _impactPercentage = 7.5;
  String _reasoning = 'Well within your healthy daily spending limits. Your housing goal remains on schedule.';

  void _calculateAffordability() {
    final cost = double.tryParse(_costController.text) ?? 0;
    setState(() {
      _hasResult = true;
      if (cost > 46200) {
        _verdict = 'NO';
        _impactPercentage = 100.0;
        _safeAfterPence = 46200 - cost;
        _reasoning = 'This purchase exceeds your current safe-to-spend limit. Buying this would push your account into deficit.';
      } else if (cost > 12000) {
        _verdict = 'WARNING';
        _impactPercentage = ((cost / 46200) * 100);
        _safeAfterPence = 46200 - cost;
        _reasoning = 'Affordable, but consumes more than a week\'s worth of your remaining monthly allowance (18 days left).';
      } else {
        _verdict = 'YES';
        _impactPercentage = ((cost / 46200) * 100);
        _safeAfterPence = 46200 - cost;
        _reasoning = 'Well within your healthy daily spending limits. Your monthly savings target is safe.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkSlate,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.purple.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.auto_awesome_rounded,
                              color: AppColors.vibrantYellow,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Slora AI Copilot',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Instant, high-confidence spending advice.',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Quick Action Chips
              const Text(
                'Quick Prompts',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildPromptChip('Can I afford this?'),
                    _buildPromptChip('Safe to spend today?'),
                    _buildPromptChip('How should I split allowance?'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Input Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Single-Purchase Affordability Check',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Item Name Input
                    TextField(
                      controller: _itemController,
                      style: const TextStyle(color: AppColors.white),
                      decoration: InputDecoration(
                        labelText: 'Item Name',
                        labelStyle: const TextStyle(color: AppColors.textMuted),
                        prefixIcon: const Icon(Icons.shopping_bag_outlined, color: AppColors.purple),
                        filled: true,
                        fillColor: AppColors.darkSlate,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Cost Input
                    TextField(
                      controller: _costController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: AppColors.white),
                      decoration: InputDecoration(
                        labelText: 'Cost (₹)',
                        labelStyle: const TextStyle(color: AppColors.textMuted),
                        prefixIcon: const Icon(Icons.currency_rupee_rounded, color: AppColors.vibrantYellow),
                        filled: true,
                        fillColor: AppColors.darkSlate,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Vibrant Yellow CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton.icon(
                        onPressed: _calculateAffordability,
                        icon: const Icon(Icons.auto_awesome_rounded, color: AppColors.darkSlate),
                        label: const Text(
                          'Ask Slora AI',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.darkSlate,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.vibrantYellow,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // AI Result Card (White Card with Dark Text)
              if (_hasResult)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'AI Verdict',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textMuted,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: _verdict == 'YES'
                                  ? AppColors.successGreen
                                  : (_verdict == 'WARNING'
                                      ? AppColors.warningOrange
                                      : AppColors.errorRed),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _verdict,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'Safe to Spend After Purchase',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted.withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '₹${_safeAfterPence.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: AppColors.darkSlate,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Impact Bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Allowance Impact',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkSlate,
                            ),
                          ),
                          Text(
                            '${_impactPercentage.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.purple,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: (_impactPercentage / 100).clamp(0.0, 1.0),
                          backgroundColor: AppColors.lightGray,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.purple),
                          minHeight: 8,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Reasoning Box
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.softWhite,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.info_outline_rounded,
                              color: AppColors.purple,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _reasoning,
                                style: const TextStyle(
                                  fontSize: 13,
                                  height: 1.4,
                                  color: AppColors.darkSlate,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromptChip(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
