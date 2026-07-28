import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SpendingDonutChart extends StatelessWidget {
  const SpendingDonutChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          // Donut Chart Left
          Expanded(
            flex: 6,
            child: SizedBox(
              height: 160,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 4,
                  centerSpaceRadius: 40,
                  startDegreeOffset: 270,
                  sections: [
                    PieChartSectionData(
                      color: AppColors.purple,
                      value: 40,
                      radius: 20,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      color: AppColors.vibrantYellow,
                      value: 31,
                      radius: 20,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      color: AppColors.pinkOrange,
                      value: 30,
                      radius: 20,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      color: AppColors.cyan,
                      value: 11,
                      radius: 20,
                      showTitle: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Legend Right (matching reference image)
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('Personal Need', '40%', AppColors.purple),
                const SizedBox(height: 8),
                _buildLegendItem('Groceries', '31%', AppColors.vibrantYellow),
                const SizedBox(height: 8),
                _buildLegendItem('Subscription', '30%', AppColors.pinkOrange),
                const SizedBox(height: 8),
                _buildLegendItem('Other', '11%', AppColors.cyan),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String title, String percent, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          percent,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
