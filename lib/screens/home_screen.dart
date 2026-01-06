import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/header_section.dart';
import '../widgets/tab_navigation.dart';
import '../widgets/donut_chart_section.dart';
import '../widgets/line_chart_section.dart';
import '../widgets/bar_chart_section.dart';
import '../widgets/color_legend.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 1;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final padding = isMobile ? 16.0 : 24.0;

    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with profile
              HeaderSection(padding: padding),
              SizedBox(height: isMobile ? 20 : 28),

              // Tab Navigation
              TabNavigation(
                selectedTab: selectedTab,
                onTabChanged: (index) {
                  setState(() => selectedTab = index);
                },
                padding: padding,
              ),
              SizedBox(height: isMobile ? 24 : 32),

              // Donut Chart Section
              DonutChartSection(padding: padding),
              SizedBox(height: isMobile ? 28 : 36),

              // Color Legend
              ColorLegend(padding: padding),
              SizedBox(height: isMobile ? 28 : 36),

              // Line Chart Section
              LineChartSection(padding: padding),
              SizedBox(height: isMobile ? 28 : 36),

              // Bar Chart Section
              BarChartSection(padding: padding),
              SizedBox(height: padding),
            ],
          ),
        ),
      ),
    );
  }
}
