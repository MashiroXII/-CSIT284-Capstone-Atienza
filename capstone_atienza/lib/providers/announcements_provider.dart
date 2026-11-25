import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../data/dummy_data.dart';
import '../models/announcement.dart';
import '../models/announcement_category.dart';

/// Announcements live in the Firestore collection "announcements".
/// The screens still only talk to this provider, so they did not change.
/// Categories stay hardcoded in dummy_data.dart (seeded data, no admin UI).
class AnnouncementsProvider extends ChangeNotifier {
  AnnouncementsProvider() {
    _listen();
  }

  final _col = FirebaseFirestore.instance.collection('announcements');
  StreamSubscription? _sub;
  List<Announcement> _items = [];
  bool _seeding = false;

  bool loading = true;
  String? error;

  void _listen() {
    _sub = _col.snapshots().listen((snap) {
      _items = snap.docs.map(Announcement.fromDoc).toList();
      loading = false;
      error = null;
      notifyListeners();

      if (snap.docs.isEmpty && !snap.metadata.isFromCache) _seed();
    }, onError: (Object e) {
      error = e.toString();
      loading = false;
      notifyListeners();
    });
  }

  Future<void> _seed() async {
    if (_seeding) return;
    _seeding = true;
    final batch = FirebaseFirestore.instance.batch();
    for (final a in dummyAnnouncements) {
      batch.set(_col.doc(a.id), a.toMap());
    }
    await batch.commit();
    _seeding = false;
  }

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

  
  Future<void> add({
    required String title,
    required String body,
    required String categoryId,
    required bool isUrgent,
  }) {
    return _col.add(Announcement(
      id: '',
      title: title,
      body: body,
      categoryId: categoryId,
      author: 'Admin',
      date: DateTime.now(),
      isUrgent: isUrgent,
    ).toMap());
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}