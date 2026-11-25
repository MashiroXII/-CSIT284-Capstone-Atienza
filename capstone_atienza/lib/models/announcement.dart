import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  final String id;
  final String title;
  final String body;
  final String categoryId;
  final String author;
  final DateTime date;
  final bool isUrgent;

  const Announcement({
    required this.id,
    required this.title,
    required this.body,
    required this.categoryId,
    required this.author,
    required this.date,
    this.isUrgent = false,
  });

  factory Announcement.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? {};
    return Announcement(
      id: doc.id,
      title: d['title'] ?? '',
      body: d['body'] ?? '',
      categoryId: d['categoryId'] ?? 'general',
      author: d['author'] ?? 'Admin',
      date: (d['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isUrgent: d['isUrgent'] ?? false,
    );
  }

  /// Write to Firestore (the id is the document id, so it is not stored).
  Map<String, dynamic> toMap() => {
        'title': title,
        'body': body,
        'categoryId': categoryId,
        'author': author,
        'date': Timestamp.fromDate(date),
        'isUrgent': isUrgent,
      };
}