import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/announcements_provider.dart';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/activity_card.dart';
import '../widgets/category_grid_item.dart';
import 'activities_screen.dart';
import 'activity_detail_screen.dart';
import 'admin_post_screen.dart';

/// Home tab: latest urgent banner, category grid, recent posts.
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<AnnouncementsProvider>();
    final auth = context.watch<AuthProvider>();
    final textTheme = Theme.of(context).textTheme;
    final urgent = data.urgent;
    final recent = data.all.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Today',
                style: textTheme.labelMedium?.copyWith(color: AppColors.muted)),
            Text(DateFormat('MMMM d, y').format(DateTime.now()),
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
      floatingActionButton: auth.isAdmin
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.navy,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: const Text('New post'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdminPostScreen()),
              ),
            )
          : null,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          if (urgent.isNotEmpty)
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ActivityDetailScreen(announcement: urgent.first),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.navy,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.notifications_active_outlined,
                        color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Latest urgent notice',
                              style: textTheme.labelMedium
                                  ?.copyWith(color: Colors.white70)),
                          Text(urgent.first.title,
                              style: textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.white),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 24),
          Text('Categories',
              style:
                  textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.9,
            children: [
              for (final c in data.categories)
                CategoryGridItem(
                  category: c,
                  count: data.countFor(c.id),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ActivitiesScreen(category: c),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Recent',
              style:
                  textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          for (final a in recent) ...[
            ActivityCard(
              announcement: a,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ActivityDetailScreen(announcement: a),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
