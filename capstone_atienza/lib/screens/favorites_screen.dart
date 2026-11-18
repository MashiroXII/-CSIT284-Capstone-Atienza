import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/announcements_provider.dart';
import '../providers/favorites_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/activity_card.dart';
import 'activity_detail_screen.dart';

/// Saved announcements tab.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ids = context.watch<FavoritesProvider>().ids;
    final saved = context
        .watch<AnnouncementsProvider>()
        .all
        .where((a) => ids.contains(a.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Saved')),
      body: saved.isEmpty
          ? const Center(
              child: Text('Tap the bookmark on a post to save it here',
                  style: TextStyle(color: AppColors.muted)),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: saved.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, i) => ActivityCard(
                announcement: saved[i],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ActivityDetailScreen(announcement: saved[i]),
                  ),
                ),
              ),
            ),
    );
  }
}
