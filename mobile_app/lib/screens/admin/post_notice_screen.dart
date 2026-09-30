import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/school_provider.dart';
import '../../models/notice_model.dart';
import '../../theme/app_theme.dart';

class PostNoticeScreen extends StatefulWidget {
  const PostNoticeScreen({super.key});

  @override
  State<PostNoticeScreen> createState() => _PostNoticeScreenState();
}

class _PostNoticeScreenState extends State<PostNoticeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  final _detailsController = TextEditingController();
  String _selectedCategory = 'Academic';
  bool _isImportant = false;

  final List<String> _categories = [
    'Academic',
    'Admissions',
    'Safety',
    'General',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _summaryController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _publishNotice() {
    if (_formKey.currentState!.validate()) {
      final school = Provider.of<SchoolProvider>(context, listen: false);

      final newNotice = SchoolNotice(
        id: 'NTC-${DateTime.now().millisecondsSinceEpoch}',
        title: _titleController.text.trim(),
        category: _selectedCategory,
        date: '30-Sep-2026',
        summary: _summaryController.text.trim(),
        details: _detailsController.text.trim(),
        isImportant: _isImportant,
      );

      school.broadcastNotice(newNotice);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Notice broadcasted across all school portals successfully!',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppTheme.forestPrimary,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Broadcast Notice'),
        backgroundColor: AppTheme.forestDeep,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.forestTint,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: AppTheme.forestPrimary.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.campaign,
                        color: AppTheme.forestPrimary, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Administrative Broadcast',
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.forestDeep,
                            ),
                          ),
                          Text(
                            'Circulars are immediately published to Parents, Teachers, and Public notice board.',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                'Notice Title',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'e.g. Winter Uniform Guidelines & Campus Schedule',
                  prefixIcon: Icon(Icons.title, size: 18),
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Please enter circular title'
                    : null,
              ),
              const SizedBox(height: 16),

              // Category & Priority
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textDark,
                          ),
                        ),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          initialValue: _selectedCategory,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                          ),
                          items: _categories
                              .map((c) => DropdownMenuItem(
                                  value: c, child: Text(c)))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedCategory = val);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Priority Tag',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textDark,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.borderLight),
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _isImportant ? 'URGENT' : 'Standard',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _isImportant
                                      ? AppTheme.danger
                                      : AppTheme.textDark,
                                ),
                              ),
                              Switch(
                                value: _isImportant,
                                activeThumbColor: AppTheme.danger,
                                onChanged: (val) =>
                                    setState(() => _isImportant = val),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Summary
              Text(
                'Short Summary (Displayed in preview cards)',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _summaryController,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: 'Brief 1-2 sentence overview of the circular...',
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Please provide a short summary'
                    : null,
              ),
              const SizedBox(height: 16),

              // Full Details
              Text(
                'Full Circular Text & Instructions',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _detailsController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText:
                      'Provide comprehensive directions, timing, dates, and instructions for parents & faculty...',
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Please provide full circular details'
                    : null,
              ),
              const SizedBox(height: 24),

              // Publish Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _publishNotice,
                  icon: const Icon(Icons.send_rounded, size: 18),
                  label: const Text('Publish & Broadcast Notice'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
