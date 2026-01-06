import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TabNavigation extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabChanged;
  final double padding;

  const TabNavigation({
    Key? key,
    required this.selectedTab,
    required this.onTabChanged,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final tabLabels = ['TRANSFER', 'STATISTICS', 'CARD', 'DEP'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        children: List.generate(
          tabLabels.length,
          (index) => Padding(
            padding: EdgeInsets.only(right: isMobile ? 12 : 16),
            child: _TabButton(
              label: tabLabels[index],
              isSelected: selectedTab == index,
              onTap: () => onTabChanged(index),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.accentRed : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.transparent : AppTheme.borderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
