import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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
      'Rejected',
    ];

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Update Lead Status',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.forestDeep,
            ),
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
                  final isCurrent = inquiry.status.toLowerCase() ==
                      status.toLowerCase();
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

  Future<void> _makeCall(String phone) async {
    final clean = phone.replaceAll(RegExp(r'\D'), '');
    final uri = Uri.parse('tel:$clean');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _openWhatsApp(String phone) async {
    final clean = phone.replaceAll(RegExp(r'\D'), '');
    final uri = Uri.parse('https://wa.me/91$clean');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final school = Provider.of<SchoolProvider>(context);
    final inquiries = school.inquiries;
    final canPop = ModalRoute.of(context)?.canPop ?? false;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F6),
      appBar: canPop
          ? AppBar(
              title: const Text('Website Admission Enquiries'),
              backgroundColor: AppTheme.forestDeep,
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => school.refreshInquiries(),
                  tooltip: 'Sync Enquiries',
                ),
              ],
            )
          : null,
      body: SafeArea(
        top: !canPop,
        bottom: true,
        child: Column(
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
                          'Website & Online Admission Leads (Session 2026-27)',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppTheme.textMuted,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => school.refreshInquiries(),
                    icon: const Icon(Icons.refresh,
                        color: AppTheme.forestPrimary, size: 20),
                    tooltip: 'Refresh Enquiries',
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.forestTint,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Live Website Desk',
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

            // Inquiries list or Empty State
            Expanded(
              child: inquiries.isEmpty
                  ? Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(22),
                              decoration: BoxDecoration(
                                color: AppTheme.forestTint,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.inbox_outlined,
                                size: 48,
                                color: AppTheme.forestPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No Inbound Enquiries Yet',
                              style: GoogleFonts.outfit(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.forestDeep,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'When parents submit the admission enquiry form on the website (or general enquiry), leads will appear here in real time.',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppTheme.textMuted,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () => school.refreshInquiries(),
                              icon: const Icon(Icons.refresh, size: 18),
                              label: const Text('Check for New Enquiries'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.forestPrimary,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
                      itemCount: inquiries.length,
                      itemBuilder: (context, index) {
                        final inq = inquiries[index];
                        Color statusColor;

                        final stLower = inq.status.toLowerCase();
                        if (stLower.contains('new') || stLower.contains('pending')) {
                          statusColor = AppTheme.goldDark;
                        } else if (stLower.contains('contact')) {
                          statusColor = Colors.blue;
                        } else if (stLower.contains('visit') ||
                            stLower.contains('schedul')) {
                          statusColor = Colors.purple;
                        } else if (stLower.contains('admit') ||
                            stLower.contains('enroll')) {
                          statusColor = AppTheme.forestPrimary;
                        } else {
                          statusColor = AppTheme.textMuted;
                        }

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: statusColor.withValues(alpha: 0.3),
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
                                    width: double.infinity,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          onPressed: () =>
                                              _makeCall(inq.mobile),
                                          icon: const Icon(Icons.call,
                                              size: 14,
                                              color: AppTheme.forestPrimary),
                                          label: const Text('Call'),
                                        ),
                                        const SizedBox(width: 6),
                                        IconButton(
                                          icon: const Icon(Icons.chat_bubble,
                                              size: 18, color: Colors.green),
                                          onPressed: () =>
                                              _openWhatsApp(inq.mobile),
                                          tooltip: 'WhatsApp Parent',
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
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
      ),
    );
  }
}
