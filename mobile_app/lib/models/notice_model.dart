class SchoolNotice {
  final String id;
  final String title;
  final String date;
  final String category; // 'Academic' | 'Admissions' | 'Safety' | 'General'
  final String summary;
  final String details;
  final bool isImportant;
  final String targetAudience; // 'all' (whole school), 'teacher', or class e.g. 'Class 1'

  const SchoolNotice({
    required this.id,
    required this.title,
    required this.date,
    required this.category,
    required this.summary,
    required this.details,
    this.isImportant = false,
    this.targetAudience = 'all',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date,
        'category': category,
        'summary': summary,
        'details': details,
        'isImportant': isImportant,
        'targetAudience': targetAudience,
      };

  factory SchoolNotice.fromJson(Map<String, dynamic> json) => SchoolNotice(
        id: json['id'] as String? ?? '',
        title: json['title'] as String? ?? 'Notice',
        date: json['date'] as String? ?? json['publish_date'] as String? ?? '',
        category: json['category'] as String? ?? 'General',
        summary: json['summary'] as String? ?? json['content'] as String? ?? '',
        details: json['details'] as String? ?? json['content'] as String? ?? '',
        isImportant: json['is_important'] as bool? ?? false,
        targetAudience: json['target_role'] as String? ??
            json['targetAudience'] as String? ??
            'all',
      );
}
