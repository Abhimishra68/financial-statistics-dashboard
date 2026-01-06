import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({Key? key}) : super(key: key);

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          height: 220,
          child: CustomPaint(
            painter: BarChartPainter(
              animationValue: _controller.value,
            ),
            child: Container(),
          ),
        );
      },
    );
  }
}

class BarChartPainter extends CustomPainter {
  final double animationValue;

  static const List<Color> barColors = [
    Color(0xFFFF8C42), // Orange
    Color(0xFF6495ED), // Light Blue
    Color(0xFFFFFFFF), // White
    Color(0xFFD4A574), // Brown
    Color(0xFFFF69B4), // Pink
    Color(0xFFFFD700), // Yellow
    Color(0xFF8A2BE2), // Blue Violet
  ];

  static const List<double> barHeights = [
    35,
    42,
    28,
    38,
    45,
    32,
    40,
  ];

  BarChartPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final padding = 20.0;
    final chartWidth = size.width - padding * 2;
    final chartHeight = size.height - padding * 2;

    _drawGridLines(canvas, size, padding, chartWidth, chartHeight);

    final numberOfBars = barColors.length;
    final totalBarWidth = chartWidth * 0.8;
    final barWidth = (totalBarWidth / numberOfBars) * 0.65;
    final spacing = (chartWidth - totalBarWidth) / 2 + (totalBarWidth / numberOfBars) * 0.175;

    for (int i = 0; i < numberOfBars; i++) {
      final xPosition = spacing + (i * (barWidth + (totalBarWidth / numberOfBars) * 0.35));

      _drawBar(
        canvas,
        padding,
        padding,
        chartHeight,
        xPosition,
        barHeights[i],
        barWidth,
        barColors[i],
        i,
        numberOfBars,
      );
    }
  }

  void _drawGridLines(
    Canvas canvas,
    Size size,
    double padding,
    double chartWidth,
    double chartHeight,
  ) {
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 0.5;

    // Horizontal grid lines
    for (int i = 0; i <= 4; i++) {
      final y = padding + (chartHeight / 4) * i;
      canvas.drawLine(
        Offset(padding, y),
        Offset(padding + chartWidth, y),
        gridPaint,
      );
    }

    // Vertical grid lines
    for (int i = 0; i <= numberOfBars; i++) {
      final x = padding + (chartWidth / numberOfBars) * i;
      canvas.drawLine(
        Offset(x, padding),
        Offset(x, padding + chartHeight),
        gridPaint,
      );
    }
  }

  int get numberOfBars => barColors.length;

  void _drawBar(
    Canvas canvas,
    double leftPadding,
    double topPadding,
    double chartHeight,
    double xPosition,
    double heightPercent,
    double barWidth,
    Color color,
    int index,
    int totalBars,
  ) {
    final staggerDelay = (index / totalBars) * 0.3;
    final animProgress =
        (animationValue - staggerDelay).clamp(0.0, 1.0) == 0.0
            ? 0.0
            : ((animationValue - staggerDelay) / (1.0 - staggerDelay))
                .clamp(0.0, 1.0);

    final barHeight = (heightPercent / 50) * chartHeight * animProgress;
    final yPosition = topPadding + chartHeight - barHeight;

    // Shadow effect
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          xPosition,
          yPosition + barHeight * 0.95,
          barWidth,
          barHeight * 0.05,
        ),
        const Radius.circular(2),
      ),
      shadowPaint,
    );

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        color.withOpacity(0.9),
        color.withOpacity(0.7),
      ],
    );

    final rect = Rect.fromLTWH(xPosition, yPosition, barWidth, barHeight);
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    // Main bar with rounded top corners
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(xPosition, yPosition, barWidth, barHeight),
        topLeft: const Radius.circular(5),
        topRight: const Radius.circular(5),
        bottomLeft: const Radius.circular(0),
        bottomRight: const Radius.circular(0),
      ),
      paint,
    );

    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          xPosition,
          yPosition,
          barWidth,
          barHeight * 0.1,
        ),
        const Radius.circular(4),
      ),
      highlightPaint,
    );

    final borderPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(xPosition, yPosition, barWidth, barHeight),
        topLeft: const Radius.circular(5),
        topRight: const Radius.circular(5),
      ),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(BarChartPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}
