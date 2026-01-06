import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';

class DonutChart extends StatefulWidget {
  const DonutChart({Key? key}) : super(key: key);

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final size = isMobile ? 240.0 : 300.0;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Glow background
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.accentBlue.withOpacity(0.4),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
            // Donut chart
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: DonutChartPainter(
                  animationValue: _controller.value,
                ),
              ),
            ),
            // Center content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '4900',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: isMobile ? 48 : 56,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '+3.44',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: isMobile ? 14 : 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '+1.88%',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: isMobile ? 12 : 14,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final double animationValue;

  DonutChartPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 16.0;

    final List<Color> colors = [
      AppTheme.accentRed,
      AppTheme.accentOrange,
      AppTheme.accentLightOrange,
      AppTheme.accentBlue,
      AppTheme.accentDarkBlue,
      AppTheme.accentPurple,
      AppTheme.accentPink,
    ];

    final List<double> percentages = [
      0.18,
      0.12,
      0.10,
      0.15,
      0.18,
      0.14,
      0.13,
    ];

    double currentAngle = -90 * (math.pi / 180);

    for (int i = 0; i < colors.length; i++) {
      final sweepAngle = percentages[i] * 2 * math.pi * animationValue;

      final paint = Paint()
        ..color = colors[i]
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        currentAngle,
        sweepAngle,
        false,
        paint,
      );

      currentAngle += percentages[i] * 2 * math.pi;
    }

    // White inner border
    final innerBorderPaint = Paint()
      ..color = AppTheme.textPrimary.withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      center,
      radius - strokeWidth / 2,
      innerBorderPaint,
    );
  }

  @override
  bool shouldRepaint(DonutChartPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}
