enum FeeStatus {
  paid,
  pending,
  overdue,
}

class FeeReceipt {
  final String id;
  final String receiptNo;
  final String studentId;
  final String studentName;
  final String grade;
  final String term;
  final double totalAmount;
  final double paidAmount;
  final double dueAmount;
  final String dueDate;
  final String? paidDate;
  final FeeStatus status;
  final String paymentMode;

  const FeeReceipt({
    required this.id,
    required this.receiptNo,
    required this.studentId,
    required this.studentName,
    required this.grade,
    required this.term,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.dueDate,
    this.paidDate,
    required this.status,
    this.paymentMode = 'Cash / School Counter',
  });

  String get statusLabel {
    switch (status) {
      case FeeStatus.paid:
        return 'Paid in Full';
      case FeeStatus.pending:
        return 'Pending';
      case FeeStatus.overdue:
        return 'Overdue';
    }
  }
}
