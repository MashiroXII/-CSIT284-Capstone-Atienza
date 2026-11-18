import 'package:flutter/foundation.dart';

/// Saved (bookmarked) announcements. Kept in memory for now.
class FavoritesProvider extends ChangeNotifier {
  final Set<String> _ids = {};

  Set<String> get ids => Set.unmodifiable(_ids);

  bool isFavorite(String announcementId) => _ids.contains(announcementId);

  void toggle(String announcementId) {
    if (!_ids.remove(announcementId)) _ids.add(announcementId);
    notifyListeners();
  }
}
