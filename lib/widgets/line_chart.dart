import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({Key? key}) : super(key: key);

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
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
          height: 240,
          child: CustomPaint(
            painter: LineChartPainter(
              animationValue: _controller.value,
            ),
            child: Container(),
          ),
        );
      },
    );
  }
}

class LineChartPainter extends CustomPainter {
  final double animationValue;
  static const Color orangeLineColor = Color(0xFFFF8C42);
  static const Color pinkLineColor = Color(0xFFE03B5D);
  static const Color markerGlowColor = Color(0xFFE03B5D);

  LineChartPainter({required this.animationValue});

  List<Offset> _generateSmoothCurve(
    List<double> dataPoints,
    double segmentWidth,
    double maxHeight,
  ) {
    List<Offset> points = [];

    // Generate control points for smooth curves
    for (int i = 0; i < dataPoints.length; i++) {
      final x = segmentWidth * i;
      final y = maxHeight - (dataPoints[i] / 60) * maxHeight;
      points.add(Offset(x, y));
    }

    return points;
  }

  Path _createSmoothPath(List<Offset> points) {
    if (points.isEmpty) return Path();
    if (points.length == 1) {
      return Path()..addOval(Rect.fromCircle(center: points[0], radius: 1));
    }

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];

      // Calculate control points for cubic bezier curve
      final controlX1 = current.dx + (next.dx - current.dx) / 3;
      final controlY1 = current.dy;
      final controlX2 = current.dx + (next.dx - current.dx) * 2 / 3;
      final controlY2 = next.dy;

      path.cubicTo(controlX1, controlY1, controlX2, controlY2, next.dx, next.dy);
    }

    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final padding = 20.0;
    final chartWidth = size.width - padding * 2;
    final chartHeight = size.height - padding * 2;

    _drawGridLines(canvas, size, padding, chartWidth, chartHeight);

    final List<double> dataPoints1 = [15, 32, 28, 42, 38, 48, 35];
    final List<double> dataPoints2 = [28, 22, 38, 32, 52, 42, 45];

    final segmentWidth = chartWidth / (dataPoints1.length - 1);

    _drawSmoothLine(
      canvas,
      padding,
      padding,
      chartWidth,
      chartHeight,
      dataPoints1,
      orangeLineColor,
      segmentWidth,
    );

    _drawSmoothLine(
      canvas,
      padding,
      padding,
      chartWidth,
      chartHeight,
      dataPoints2,
      pinkLineColor,
      segmentWidth,
    );

    _drawGlowingPoints(
      canvas,
      padding,
      padding,
      chartWidth,
      chartHeight,
      dataPoints1,
      markerGlowColor,
      segmentWidth,
    );

    _drawGlowingPoints(
      canvas,
      padding,
      padding,
      chartWidth,
      chartHeight,
      dataPoints2,
      markerGlowColor,
      segmentWidth,
    );
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
    for (int i = 0; i <= 6; i++) {
      final x = padding + (chartWidth / 6) * i;
      canvas.drawLine(
        Offset(x, padding),
        Offset(x, padding + chartHeight),
        gridPaint,
      );
    }
  }

  void _drawSmoothLine(
    Canvas canvas,
    double leftPadding,
    double topPadding,
    double chartWidth,
    double chartHeight,
    List<double> dataPoints,
    Color lineColor,
    double segmentWidth,
  ) {
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final points = _generateSmoothCurve(dataPoints, segmentWidth, chartHeight);
    final offsetPoints = points
        .map((p) => Offset(leftPadding + p.dx, topPadding + p.dy))
        .toList();

    final path = _createSmoothPath(offsetPoints);
    canvas.drawPath(path, linePaint);
  }

  void _drawGlowingPoints(
    Canvas canvas,
    double leftPadding,
    double topPadding,
    double chartWidth,
    double chartHeight,
    List<double> dataPoints,
    Color glowColor,
    double segmentWidth,
  ) {
    for (int i = 0; i < dataPoints.length; i++) {
      final x = leftPadding + segmentWidth * i;
      final y = topPadding + chartHeight - (dataPoints[i] / 60) * chartHeight;
      final progress = (animationValue - (i / dataPoints.length)).clamp(0.0, 1.0);

      if (progress > 0) {
        // Outer glow
        final outerGlowPaint = Paint()
          ..color = glowColor.withOpacity(0.15 * progress)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

        canvas.drawCircle(Offset(x, y), 10, outerGlowPaint);

        // Middle glow
        final middleGlowPaint = Paint()
          ..color = glowColor.withOpacity(0.25 * progress)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

        canvas.drawCircle(Offset(x, y), 6, middleGlowPaint);

        // Inner point
        final pointPaint = Paint()
          ..color = glowColor
          ..style = PaintingStyle.fill;

        canvas.drawCircle(Offset(x, y), 5, pointPaint);

        // Center highlight
        final highlightPaint = Paint()
          ..color = Colors.white.withOpacity(0.6)
          ..style = PaintingStyle.fill;

        canvas.drawCircle(Offset(x, y), 2, highlightPaint);
      }
    }
  }

  @override
  bool shouldRepaint(LineChartPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}
