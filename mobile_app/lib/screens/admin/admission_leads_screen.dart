import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/school_provider.dart';
import '../../models/admission_inquiry_model.dart';
import '../../theme/app_theme.dart';

class AdmissionLeadsScreen extends StatelessWidget {
  const AdmissionLeadsScreen({super.key});

  void _showStatusUpdateDialog(
      BuildContext context, SchoolProvider school, AdmissionInquiry inquiry) {
    final statuses = [
      'New Enquiry',
      'Contacted',
      'Campus Visit Scheduled',
      'Enrolled',
    ];

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  'Update Lead Status',
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
                  'Applicant: ${inquiry.studentName} (${inquiry.grade})',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(
                  'Parent: ${inquiry.parentName} • ${inquiry.mobile}',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: AppTheme.textMuted),
                ),
                const SizedBox(height: 16),
                ...statuses.map((status) {
                  final isCurrent = inquiry.status == status;
                  return ListTile(
                    title: Text(
                      status,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight:
                            isCurrent ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    trailing: isCurrent
                        ? const Icon(Icons.check, color: AppTheme.forestPrimary)
                        : null,
                    onTap: () {
                      school.updateInquiryStatus(inquiry.id, status);
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Status updated to "$status" for ${inquiry.studentName}',
                            style: GoogleFonts.inter(),
                          ),
                          backgroundColor: AppTheme.forestPrimary,
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final school = Provider.of<SchoolProvider>(context);
    final inquiries = school.inquiries;

    return Scaffold(
      body: Column(
        children: [
          // Header summary
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
                        '${inquiries.length} Inbound Applications',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.forestDeep,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Academic Admissions 2026-27 Leads',
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.forestTint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Active Desk',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.forestDeep,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Inquiries list
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: inquiries.length,
              itemBuilder: (context, index) {
                final inq = inquiries[index];
                Color statusColor;

                switch (inq.status) {
                  case 'New Enquiry':
                    statusColor = AppTheme.goldDark;
                    break;
                  case 'Contacted':
                    statusColor = Colors.blue;
                    break;
                  case 'Campus Visit Scheduled':
                    statusColor = Colors.purple;
                    break;
                  case 'Enrolled':
                    statusColor = AppTheme.forestPrimary;
                    break;
                  default:
                    statusColor = AppTheme.textMuted;
                }

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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                inq.referenceId,
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => _showStatusUpdateDialog(
                                  context, school, inq),
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:
                                        statusColor.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      inq.status,
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: statusColor,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(Icons.arrow_drop_down,
                                        size: 16, color: statusColor),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${inq.studentName} — ${inq.grade}',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.forestDeep,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Parent: ${inq.parentName} • Contact: ${inq.mobile}',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppTheme.textDark,
                          ),
                        ),
                        if (inq.message.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '"${inq.message}"',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        const Divider(height: 1),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Submitted: ${inq.submissionDate}',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: AppTheme.textMuted,
                              ),
                            ),
                            Row(
                              children: [
                                OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Connecting call to parent ${inq.parentName} (${inq.mobile})...',
                                          style: GoogleFonts.inter(),
                                        ),
                                        backgroundColor:
                                            AppTheme.forestPrimary,
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.call, size: 14),
                                  label: const Text('Call Parent'),
                                ),
                              ],
                            ),
                          ],
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
