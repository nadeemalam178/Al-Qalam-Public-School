class HomeworkItem {
  final String id;
  final String subject;
  final String title;
  final String description;
  final String grade;
  final String assignedDate;
  final String dueDate;
  final String teacherName;
  final bool isCompleted;

  const HomeworkItem({
    required this.id,
    required this.subject,
    required this.title,
    required this.description,
    required this.grade,
    required this.assignedDate,
    required this.dueDate,
    required this.teacherName,
    this.isCompleted = false,
  });

  HomeworkItem copyWith({bool? isCompleted}) {
    return HomeworkItem(
      id: id,
      subject: subject,
      title: title,
      description: description,
      grade: grade,
      assignedDate: assignedDate,
      dueDate: dueDate,
      teacherName: teacherName,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
