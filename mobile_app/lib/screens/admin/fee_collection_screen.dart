import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/school_provider.dart';
import '../../models/student_model.dart';
import '../../theme/app_theme.dart';

class FeeCollectionScreen extends StatefulWidget {
  const FeeCollectionScreen({super.key});

  @override
  State<FeeCollectionScreen> createState() => _FeeCollectionScreenState();
}

class _FeeCollectionScreenState extends State<FeeCollectionScreen> {
  String _filter = 'Pending'; // 'Pending' | 'All'

  void _showCollectFeeDialog(
      BuildContext context, SchoolProvider school, Student student) {
    final amountController =
        TextEditingController(text: student.pendingFees.toInt().toString());
    String selectedMode = 'Cash at School Counter';

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.forestTint,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.point_of_sale,
                        color: AppTheme.forestPrimary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Record Fee Payment',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.forestDeep,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student: ${student.name} (${student.fullClass})',
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark),
                    ),
                    Text(
                      'Total Dues Pending: ₹${student.pendingFees.toInt()}',
                      style: GoogleFonts.inter(
                          fontSize: 12, color: AppTheme.danger),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Amount to Collect (₹ INR)',
                        prefixIcon:
                            Icon(Icons.currency_rupee_rounded, size: 18),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: selectedMode,
                      decoration: const InputDecoration(
                        labelText: 'Payment Method',
                        prefixIcon: Icon(Icons.payment, size: 18),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Cash at School Counter',
                          child: Text('Cash at School Counter'),
                        ),
                        DropdownMenuItem(
                          value: 'UPI / PhonePe / QR',
                          child: Text('UPI / PhonePe / QR'),
                        ),
                        DropdownMenuItem(
                          value: 'Bank Transfer / NEFT',
                          child: Text('Bank Transfer / NEFT'),
                        ),
                        DropdownMenuItem(
                          value: 'Cheque / DD',
                          child: Text('Cheque / DD'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          setDialogState(() => selectedMode = val);
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final amount =
                        double.tryParse(amountController.text.trim()) ?? 0;
                    if (amount > 0) {
                      // Find fee receipt for student
                      final studentFees =
                          school.getFeesForStudent(student.id);
                      final feeId = studentFees.isNotEmpty
                          ? studentFees.first.id
                          : 'FEE-${DateTime.now().millisecondsSinceEpoch}';

                      school.recordFeePayment(
                        feeId: feeId,
                        amountPaidNow: amount,
                        paymentMode: selectedMode,
                      );

                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Fee payment of ₹${amount.toInt()} recorded for ${student.name}. Receipt generated.',
                            style: GoogleFonts.inter(),
                          ),
                          backgroundColor: AppTheme.forestPrimary,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  child: const Text('Record & Generate Receipt'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final school = Provider.of<SchoolProvider>(context);
    final allStudents = school.students;

    final pendingStudents =
        allStudents.where((s) => s.pendingFees > 0).toList();
    final displayStudents =
        _filter == 'Pending' ? pendingStudents : allStudents;

    return Scaffold(
      body: Column(
        children: [
          // Total Dues Header
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Outstanding: ₹${school.totalOutstandingFees.toInt()}',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.danger,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Collected: ₹${school.totalCollectedFees.toInt()} • 6 Total Students',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ChoiceChip(
                      label: const Text('Pending Dues'),
                      selected: _filter == 'Pending',
                      selectedColor: AppTheme.forestPrimary,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _filter == 'Pending'
                            ? Colors.white
                            : AppTheme.textDark,
                      ),
                      onSelected: (_) => setState(() => _filter = 'Pending'),
                    ),
                    const SizedBox(width: 6),
                    ChoiceChip(
                      label: const Text('All Roster'),
                      selected: _filter == 'All',
                      selectedColor: AppTheme.forestPrimary,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _filter == 'All'
                            ? Colors.white
                            : AppTheme.textDark,
                      ),
                      onSelected: (_) => setState(() => _filter = 'All'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Students list
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: displayStudents.length,
              itemBuilder: (context, index) {
                final student = displayStudents[index];
                final hasDue = student.pendingFees > 0;

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: hasDue
                              ? const Color(0xFFFFF7DC)
                              : AppTheme.forestTint,
                          foregroundColor: hasDue
                              ? AppTheme.goldDark
                              : AppTheme.forestDeep,
                          child: Text(
                            '#${student.rollNo}',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student.name,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${student.fullClass} • Adm: ${student.admissionNo}',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                hasDue
                                    ? 'Pending: ₹${student.pendingFees.toInt()}'
                                    : 'All Dues Paid in Full',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: hasDue
                                      ? AppTheme.danger
                                      : AppTheme.forestPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (hasDue)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            onPressed: () => _showCollectFeeDialog(
                                context, school, student),
                            child: const Text('Collect Fee'),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.forestTint,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Clear',
                              style: TextStyle(
                                color: AppTheme.forestPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
