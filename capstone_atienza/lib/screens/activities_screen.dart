import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/announcement_category.dart';
import '../providers/announcements_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/activity_card.dart';
import 'activity_detail_screen.dart';

/// List of announcements inside one category.
class ActivitiesScreen extends StatelessWidget {
  final AnnouncementCategory category;

  const ActivitiesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<AnnouncementsProvider>().byCategory(category.id);

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: items.isEmpty
          ? const Center(
              child: Text('No announcements yet',
                  style: TextStyle(color: AppColors.muted)),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, i) => ActivityCard(
                announcement: items[i],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ActivityDetailScreen(announcement: items[i]),
                  ),
                ),
              ),
            ),
    );
  }
}
