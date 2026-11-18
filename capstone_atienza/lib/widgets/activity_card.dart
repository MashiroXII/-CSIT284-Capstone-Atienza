import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/announcement.dart';
import '../providers/announcements_provider.dart';
import '../theme/app_theme.dart';
import 'favorite_button.dart';

/// Announcement list tile (kept as activity_card.dart to match the planned structure).
class ActivityCard extends StatelessWidget {
  final Announcement announcement;
  final VoidCallback onTap;

  const ActivityCard({
    super.key,
    required this.announcement,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final category =
        context.read<AnnouncementsProvider>().categoryOf(announcement.categoryId);
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 4, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.accent,
                child: Icon(category.icon, color: AppColors.navy),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (announcement.isUrgent)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          'URGENT',
                          style: textTheme.labelSmall?.copyWith(
                            color: AppColors.urgent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    Text(
                      announcement.title,
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      announcement.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColors.muted),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${announcement.author} · '
                      '${DateFormat('MMM d, y').format(announcement.date)}',
                      style: textTheme.bodySmall
                          ?.copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              FavoriteButton(announcementId: announcement.id),
            ],
          ),
        ),
      ),
    );
  }
}
