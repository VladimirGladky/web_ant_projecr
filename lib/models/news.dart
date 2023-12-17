class News {
  final String title;
  final String description;
  final String? imageUrl;
  final String sourceUrl;
  final DateTime? published_at;

  News({
    required this.title,
    required this.description,
    this.imageUrl,
    required this.sourceUrl,
    required this.published_at,
  });
}
