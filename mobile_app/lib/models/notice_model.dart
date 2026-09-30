class SchoolNotice {
  final String id;
  final String title;
  final String date;
  final String category; // 'Academic' | 'Admissions' | 'Safety' | 'General'
  final String summary;
  final String details;
  final bool isImportant;

  const SchoolNotice({
    required this.id,
    required this.title,
    required this.date,
    required this.category,
    required this.summary,
    required this.details,
    this.isImportant = false,
  });
}
