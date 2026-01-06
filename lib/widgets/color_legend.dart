import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ColorLegend extends StatelessWidget {
  final double padding;

  const ColorLegend({
    Key? key,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final colors = [
      AppTheme.accentRed,
      AppTheme.accentWhite,
      AppTheme.accentRed,
      AppTheme.accentLightOrange,
      AppTheme.accentPink,
      AppTheme.accentRed,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        children: [
          for (int i = 0; i < 2; i++)
            Padding(
              padding: EdgeInsets.only(bottom: isMobile ? 16 : 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  3,
                  (index) {
                    final colorIndex = i * 3 + index;
                    return Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: colors[colorIndex],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(width: isMobile ? 8 : 12),
                        Text(
                          '50%',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: isMobile ? 12 : 14,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
