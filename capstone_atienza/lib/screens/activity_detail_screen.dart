import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/announcement.dart';
import '../providers/announcements_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/favorite_button.dart';

class ActivityDetailScreen extends StatelessWidget {
  final Announcement announcement;

  const ActivityDetailScreen({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    final category =
        context.read<AnnouncementsProvider>().categoryOf(announcement.categoryId);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        actions: [FavoriteButton(announcementId: announcement.id)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Wrap(
            spacing: 8,
            children: [
              Chip(
                avatar: Icon(category.icon, size: 18, color: AppColors.navy),
                label: Text(category.name),
                backgroundColor: AppColors.accent,
                side: BorderSide.none,
              ),
              if (announcement.isUrgent)
                Chip(
                  label: const Text('Urgent'),
                  labelStyle: const TextStyle(color: Colors.white),
                  backgroundColor: AppColors.urgent,
                  side: BorderSide.none,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(announcement.title,
              style: textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(
            '${announcement.author} · '
            '${DateFormat('MMMM d, y').format(announcement.date)}',
            style: textTheme.bodyMedium?.copyWith(color: AppColors.muted),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(announcement.body,
                style: textTheme.bodyLarge?.copyWith(height: 1.5)),
          ),
        ],
      ),
    );
  }
}
