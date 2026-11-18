/// Text-only announcement (no images, no comments - scope cut).
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
}
