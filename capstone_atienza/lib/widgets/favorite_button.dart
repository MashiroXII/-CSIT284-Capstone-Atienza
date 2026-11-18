import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorites_provider.dart';

class FavoriteButton extends StatelessWidget {
  final String announcementId;

  const FavoriteButton({super.key, required this.announcementId});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    final saved = favorites.isFavorite(announcementId);

    return IconButton(
      tooltip: saved ? 'Remove from saved' : 'Save',
      icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border),
      onPressed: () => context.read<FavoritesProvider>().toggle(announcementId),
    );
  }
}
