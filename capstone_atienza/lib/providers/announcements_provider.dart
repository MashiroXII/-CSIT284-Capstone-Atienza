import 'package:flutter/foundation.dart';

import '../data/dummy_data.dart';
import '../models/announcement.dart';
import '../models/announcement_category.dart';

/// Holds the list of announcements. Swap the dummy list for Firestore later;
/// the screens only talk to this provider, so they won't need to change.
class AnnouncementsProvider extends ChangeNotifier {
  final List<Announcement> _items = List.of(dummyAnnouncements);

  List<AnnouncementCategory> get categories => dummyCategories;

  List<Announcement> get all {
    final list = List<Announcement>.of(_items);
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  List<Announcement> get urgent => all.where((a) => a.isUrgent).toList();

  List<Announcement> byCategory(String categoryId) =>
      all.where((a) => a.categoryId == categoryId).toList();

  int countFor(String categoryId) =>
      _items.where((a) => a.categoryId == categoryId).length;

  AnnouncementCategory categoryOf(String id) =>
      dummyCategories.firstWhere((c) => c.id == id);

  void add({
    required String title,
    required String body,
    required String categoryId,
    required bool isUrgent,
  }) {
    _items.add(Announcement(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      body: body,
      categoryId: categoryId,
      author: 'Admin',
      date: DateTime.now(),
      isUrgent: isUrgent,
    ));
    notifyListeners();
  }
}
