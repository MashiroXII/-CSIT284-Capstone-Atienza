import 'package:flutter/material.dart';

import '../models/announcement_category.dart';
import '../theme/app_theme.dart';

class CategoryGridItem extends StatelessWidget {
  final AnnouncementCategory category;
  final int count;
  final VoidCallback onTap;

  const CategoryGridItem({
    super.key,
    required this.category,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.accent,
                child: Icon(category.icon, size: 28, color: AppColors.navy),
              ),
              const SizedBox(height: 10),
              Text(
                category.name,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                '$count posts',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
