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
  String _selectedCategory = 'General';
  String _targetAudience = 'all'; // 'all', 'teacher', or specific class
  String _selectedClass = 'Class 1';
  bool _isImportant = false;

  final List<String> _categories = [
    'General',
    'Admissions',
    'Academic',
    'Safety',
    'Holiday',
  ];

  final List<String> _classes = [
    'Pre-School / Nursery',
    'LKG',
    'UKG',
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5',
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

      String effectiveAudience = _targetAudience;
      if (_targetAudience == 'class') {
        effectiveAudience = _selectedClass;
      }

      final dateNow = DateTime.now();
      final dateStr =
          '${dateNow.day.toString().padLeft(2, '0')}-${_getMonth(dateNow.month)}-${dateNow.year}';

      final newNotice = SchoolNotice(
        id: 'NTC-${dateNow.millisecondsSinceEpoch}',
        title: _titleController.text.trim(),
        category: _selectedCategory,
        date: dateStr,
        summary: _summaryController.text.trim().isNotEmpty
            ? _summaryController.text.trim()
            : _detailsController.text.trim(),
        details: _detailsController.text.trim(),
        isImportant: _isImportant,
        targetAudience: effectiveAudience,
      );

      school.broadcastNotice(newNotice);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Notice broadcasted successfully across website & app!',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppTheme.forestPrimary,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context);
    }
  }

  String _getMonth(int m) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[m - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F6),
      appBar: AppBar(
        title: const Text('Broadcast Notice & Circular'),
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
                            'Unified Notice Broadcast',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppTheme.forestDeep,
                            ),
                          ),
                          Text(
                            'Published notices sync directly to the public website and mobile app portal.',
                            style: GoogleFonts.inter(
                              fontSize: 11,
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

              // Target Audience Selector
              Text(
                'Target Audience *',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _targetAudience = 'all'),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _targetAudience == 'all'
                              ? AppTheme.forestPrimary
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _targetAudience == 'all'
                                ? AppTheme.forestPrimary
                                : Colors.grey.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Whole School\n(Web & All)',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _targetAudience == 'all'
                                  ? Colors.white
                                  : AppTheme.textDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _targetAudience = 'class'),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _targetAudience == 'class'
                              ? AppTheme.goldDark
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _targetAudience == 'class'
                                ? AppTheme.goldDark
                                : Colors.grey.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Class-Wise\nNotice',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _targetAudience == 'class'
                                  ? Colors.white
                                  : AppTheme.textDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _targetAudience = 'teacher'),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _targetAudience == 'teacher'
                              ? Colors.indigo
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _targetAudience == 'teacher'
                                ? Colors.indigo
                                : Colors.grey.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Teachers\nOnly',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _targetAudience == 'teacher'
                                  ? Colors.white
                                  : AppTheme.textDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_targetAudience == 'class') ...[
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _selectedClass,
                  decoration: const InputDecoration(
                    labelText: 'Select Class for Notice *',
                    prefixIcon: Icon(Icons.class_outlined, size: 18),
                  ),
                  items: _classes
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedClass = v);
                  },
                ),
              ],
              const SizedBox(height: 16),

              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Notice Title *',
                  hintText: 'e.g. Annual Sports Meet Schedule',
                  prefixIcon: Icon(Icons.title, size: 18),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Category Selector
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category *',
                  prefixIcon: Icon(Icons.category, size: 18),
                ),
                items: _categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedCategory = val);
                  }
                },
              ),
              const SizedBox(height: 16),

              // Brief Summary
              TextFormField(
                controller: _summaryController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Summary (Optional)',
                  hintText: '1-2 sentence preview shown on lists...',
                ),
              ),
              const SizedBox(height: 16),

              // Detailed Content
              TextFormField(
                controller: _detailsController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Notice Full Content *',
                  hintText:
                      'Provide comprehensive guidelines, dates, instructions, or schedules...',
                  alignLabelWithHint: true,
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Notice details cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // High Priority Checkbox
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: _isImportant,
                activeColor: AppTheme.forestPrimary,
                title: Text(
                  'Mark as Important / Urgent Alert',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                subtitle: Text(
                  'Pins this notice to the top with a priority badge',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppTheme.textMuted,
                  ),
                ),
                onChanged: (val) {
                  setState(() => _isImportant = val ?? false);
                },
              ),
              const SizedBox(height: 24),

              // Publish Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _publishNotice,
                  icon: const Icon(Icons.send_rounded, size: 18),
                  label: const Text('Broadcast Notice Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.forestPrimary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
