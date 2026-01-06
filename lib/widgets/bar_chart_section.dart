import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'bar_chart.dart';

class BarChartSection extends StatelessWidget {
  final double padding;

  const BarChartSection({
    Key? key,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistic Graph',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'All mentions:',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),
          const SizedBox(
            height: 200,
            child: BarChartWidget(),
          ),
        ],
      ),
    );
  }
}
