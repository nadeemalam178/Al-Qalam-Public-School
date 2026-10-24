class SchoolGalleryItem {
  final String id;
  final String title;
  final String category; // 'Achievements', 'Activities', 'Classroom', 'Events', 'Campus', 'Facilities'
  final String src;
  final String tag;
  final String description;
  final String? createdAt;

  const SchoolGalleryItem({
    required this.id,
    required this.title,
    required this.category,
    required this.src,
    this.tag = 'Campus Life',
    this.description = '',
    this.createdAt,
  });

  factory SchoolGalleryItem.fromJson(Map<String, dynamic> json) {
    return SchoolGalleryItem(
      id: json['id'] as String? ?? 'GAL-${DateTime.now().millisecondsSinceEpoch}',
      title: json['title'] as String? ?? 'Campus Photograph',
      category: json['category'] as String? ?? 'Campus',
      src: json['src'] as String? ?? '',
      tag: json['tag'] as String? ?? 'Campus Life',
      description: json['description'] as String? ?? '',
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'src': src,
      'tag': tag,
      'description': description,
    };
  }
}
