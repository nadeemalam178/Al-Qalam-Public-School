class AdmissionInquiry {
  final String id;
  final String referenceId;
  final String studentName;
  final String parentName;
  final String mobile;
  final String grade;
  final String message;
  final String submissionDate;
  final String status; // 'New Enquiry' | 'Contacted' | 'Campus Visit Scheduled' | 'Enrolled'

  const AdmissionInquiry({
    required this.id,
    required this.referenceId,
    required this.studentName,
    required this.parentName,
    required this.mobile,
    required this.grade,
    required this.message,
    required this.submissionDate,
    this.status = 'New Enquiry',
  });

  AdmissionInquiry copyWith({String? status}) {
    return AdmissionInquiry(
      id: id,
      referenceId: referenceId,
      studentName: studentName,
      parentName: parentName,
      mobile: mobile,
      grade: grade,
      message: message,
      submissionDate: submissionDate,
      status: status ?? this.status,
    );
  }
}
