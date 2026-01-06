import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HeaderSection extends StatelessWidget {
  final double padding;

  const HeaderSection({
    Key? key,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.borderColor, width: 2),
            ),
            child: const Icon(
              Icons.person,
              color: AppTheme.textSecondary,
              size: 28,
            ),
          ),
          SizedBox(width: padding),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Robert Ross',
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Software Engineer • Premium',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Top right icons
          Icon(Icons.send, color: AppTheme.textPrimary, size: 20),
          SizedBox(width: padding / 2),
          Icon(Icons.signal_cellular_alt, color: AppTheme.textPrimary, size: 20),
        ],
      ),
    );
  }
}
