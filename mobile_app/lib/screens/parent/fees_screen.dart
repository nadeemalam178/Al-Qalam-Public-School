import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/school_provider.dart';
import '../../models/fee_model.dart';
import '../../theme/app_theme.dart';
import '../../services/school_data_repository.dart';

class ParentFeesScreen extends StatelessWidget {
  const ParentFeesScreen({super.key});

  void _showReceiptDialog(BuildContext context, FeeReceipt receipt) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // School Header
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppTheme.goldPrimary, width: 2),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.school,
                            color: AppTheme.forestPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            SchoolDataRepository.schoolName,
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.forestDeep,
                            ),
                          ),
                          Text(
                            'OFFICIAL FEE RECEIPT',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.goldDark,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 10),
                _buildReceiptRow('Receipt No:', receipt.receiptNo),
                _buildReceiptRow('Student:', receipt.studentName),
                _buildReceiptRow('Class & Sec:', receipt.grade),
                _buildReceiptRow('Term / Period:', receipt.term),
                _buildReceiptRow('Payment Mode:', receipt.paymentMode),
                _buildReceiptRow('Paid Date:', receipt.paidDate ?? 'Pending'),
                const Divider(),
                _buildReceiptRow(
                  'Amount Paid:',
                  '₹${receipt.paidAmount.toInt()}',
                  isBold: true,
                  valueColor: AppTheme.forestPrimary,
                ),
                if (receipt.dueAmount > 0)
                  _buildReceiptRow(
                    'Balance Due:',
                    '₹${receipt.dueAmount.toInt()}',
                    isBold: true,
                    valueColor: AppTheme.danger,
                  ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.forestTint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.verified,
                          color: AppTheme.forestPrimary, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Authorized Digital Receipt • Al-Qalam Accounts Desk',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppTheme.forestDeep,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Close'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Receipt downloaded to documents.'),
                              backgroundColor: AppTheme.forestPrimary,
                            ),
                          );
                        },
                        icon: const Icon(Icons.download, size: 16),
                        label: const Text('Download'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPaymentModal(
      BuildContext context, SchoolProvider school, FeeReceipt fee) {
    String selectedMode = 'UPI / PhonePe / GPay';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                24,
                24,
                24,
                MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fee Payment',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.forestDeep,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.goldLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '₹${fee.dueAmount.toInt()} Due',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.goldDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${fee.term} • Zaid Alam',
                    style: GoogleFonts.inter(
                        fontSize: 13, color: AppTheme.textMuted),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'SELECT PAYMENT METHOD',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textMuted,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildPaymentOption(
                    title: 'UPI (Google Pay / PhonePe / Paytm)',
                    subtitle: 'Instant confirmation via official school QR',
                    icon: Icons.qr_code_2_rounded,
                    isSelected: selectedMode == 'UPI / PhonePe / GPay',
                    onTap: () {
                      setModalState(
                          () => selectedMode = 'UPI / PhonePe / GPay');
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildPaymentOption(
                    title: 'School Accounts Counter (Cash)',
                    subtitle: 'Generate pay-slip for campus accounts desk',
                    icon: Icons.account_balance_wallet_outlined,
                    isSelected:
                        selectedMode == 'School Cash Counter',
                    onTap: () {
                      setModalState(
                          () => selectedMode = 'School Cash Counter');
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildPaymentOption(
                    title: 'Net Banking / NEFT',
                    subtitle: 'Al-Qalam Public School Bank Account',
                    icon: Icons.account_balance_outlined,
                    isSelected: selectedMode == 'Net Banking',
                    onTap: () {
                      setModalState(() => selectedMode = 'Net Banking');
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        school.recordFeePayment(
                          feeId: fee.id,
                          amountPaidNow: fee.dueAmount,
                          paymentMode: selectedMode,
                        );
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Payment of ₹${fee.dueAmount.toInt()} processed successfully! Receipt generated.',
                              style: GoogleFonts.inter(),
                            ),
                            backgroundColor: AppTheme.forestPrimary,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Text(
                        'Confirm Payment of ₹${fee.dueAmount.toInt()}',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.forestTint : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.forestPrimary : AppTheme.borderLight,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: isSelected
                    ? AppTheme.forestPrimary
                    : AppTheme.textMuted),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle,
                  color: AppTheme.forestPrimary, size: 20),
          ],
        ),
      ),
    );
  }

  static Widget _buildReceiptRow(String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppTheme.textMuted,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: valueColor ?? AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final school = Provider.of<SchoolProvider>(context);
    final student = school.getStudentById('STU-001');
    final feeRecords = school.getFeesForStudent(student.id);

    final totalPaid = feeRecords.fold(0.0, (acc, f) => acc + f.paidAmount);
    final pendingFee = feeRecords.firstWhere(
      (f) => f.dueAmount > 0,
      orElse: () => feeRecords.first,
    );

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dues Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: student.pendingFees > 0
                      ? [const Color(0xFF885532), const Color(0xFF6B4226)]
                      : [AppTheme.forestDeep, AppTheme.forestPrimary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Outstanding Dues',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: student.pendingFees > 0
                              ? AppTheme.goldPrimary
                              : Colors.greenAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          student.pendingFees > 0 ? 'DUE PENDING' : 'CLEAR',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.forestDeep,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₹${student.pendingFees.toInt()}',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Total Paid this session: ₹${totalPaid.toInt()}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                  if (student.pendingFees > 0) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.goldPrimary,
                          foregroundColor: AppTheme.forestDeep,
                        ),
                        onPressed: () =>
                            _showPaymentModal(context, school, pendingFee),
                        icon: const Icon(Icons.payment, size: 18),
                        label: const Text('Pay Pending Dues Now'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Receipts List
            Text(
              'Fee Receipts & History',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.forestDeep,
              ),
            ),
            const SizedBox(height: 10),

            ...feeRecords.map((fee) {
              final isPaid = fee.status == FeeStatus.paid;
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              fee.term,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textDark,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isPaid
                                  ? AppTheme.forestTint
                                  : const Color(0xFFFFF7DC),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              fee.statusLabel,
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isPaid
                                    ? AppTheme.forestPrimary
                                    : AppTheme.goldDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: ₹${fee.totalAmount.toInt()}',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppTheme.textMuted,
                            ),
                          ),
                          Text(
                            'Paid: ₹${fee.paidAmount.toInt()}',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.forestPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            fee.paidDate != null
                                ? 'Paid on: ${fee.paidDate}'
                                : 'Due: ${fee.dueDate}',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AppTheme.textMuted,
                            ),
                          ),
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () => _showReceiptDialog(context, fee),
                            icon: const Icon(Icons.receipt_long, size: 14),
                            label: const Text('View Receipt'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
