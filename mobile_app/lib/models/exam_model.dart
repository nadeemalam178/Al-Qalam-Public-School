class SubjectScore {
  final String subject;
  final double marksObtained;
  final double maxMarks;
  final String gradeLetter;
  final String remarks;

  const SubjectScore({
    required this.subject,
    required this.marksObtained,
    required this.maxMarks,
    required this.gradeLetter,
    required this.remarks,
  });

  double get percentage => (marksObtained / maxMarks) * 100;
}

class ExamReportCard {
  final String id;
  final String examTitle;
  final String studentId;
  final String studentName;
  final String grade;
  final String term;
  final String issueDate;
  final List<SubjectScore> scores;
  final String teacherRemarks;
  final String directorRemarks;
  final int rankInClass;

  const ExamReportCard({
    required this.id,
    required this.examTitle,
    required this.studentId,
    required this.studentName,
    required this.grade,
    required this.term,
    required this.issueDate,
    required this.scores,
    required this.teacherRemarks,
    required this.directorRemarks,
    required this.rankInClass,
  });

  double get totalObtained =>
      scores.fold(0, (sum, item) => sum + item.marksObtained);

  double get totalMax =>
      scores.fold(0, (sum, item) => sum + item.maxMarks);

  double get overallPercentage => (totalObtained / totalMax) * 100;

  String get overallGrade {
    final pct = overallPercentage;
    if (pct >= 90) return 'A+ (Outstanding)';
    if (pct >= 80) return 'A (Excellent)';
    if (pct >= 70) return 'B+ (Very Good)';
    if (pct >= 60) return 'B (Good)';
    if (pct >= 50) return 'C (Average)';
    return 'D (Needs Improvement)';
  }
}
