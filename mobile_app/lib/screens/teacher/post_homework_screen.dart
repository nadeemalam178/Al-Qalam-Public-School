import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/school_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/homework_model.dart';
import '../../theme/app_theme.dart';

class PostHomeworkScreen extends StatefulWidget {
  const PostHomeworkScreen({super.key});

  @override
  State<PostHomeworkScreen> createState() => _PostHomeworkScreenState();
}

class _PostHomeworkScreenState extends State<PostHomeworkScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedSubject = 'Mathematics';
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _dueDateController = TextEditingController(text: '02-Oct-2026');

  final List<String> _subjects = [
    'Mathematics',
    'English Grammar',
    'Environmental Studies (EVS)',
    'Urdu & Moral Values',
    'Hindi Literature',
    'Drawing & Art Activity',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  void _submitHomework() {
    if (_formKey.currentState!.validate()) {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      final school = Provider.of<SchoolProvider>(context, listen: false);

      final newItem = HomeworkItem(
        id: 'HW-${DateTime.now().millisecondsSinceEpoch}',
        subject: _selectedSubject,
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        grade: auth.currentUser.classAssigned ?? 'Class 3',
        assignedDate: '30-Sep-2026',
        dueDate: _dueDateController.text.trim(),
        teacherName: auth.currentUser.name,
      );

      school.addHomework(newItem);

      _titleController.clear();
      _descController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Homework published to Class 3-A students & parents!',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppTheme.forestPrimary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
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
                    const Icon(Icons.school,
                        color: AppTheme.forestPrimary, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Assign Class 3-A Homework',
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.forestDeep,
                            ),
                          ),
                          Text(
                            'Assignments appear instantly in parents digital diary',
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

              // Subject Dropdown
              Text(
                'Subject',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _selectedSubject,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.menu_book, size: 18),
                ),
                items: _subjects
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedSubject = val);
                },
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                'Assignment Title',
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
                  hintText: 'e.g. Chapter 4 Multiplication Word Problems',
                  prefixIcon: Icon(Icons.title, size: 18),
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Please enter assignment title'
                    : null,
              ),
              const SizedBox(height: 16),

              // Due Date
              Text(
                'Submission Deadline',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _dueDateController,
                decoration: const InputDecoration(
                  hintText: 'DD-MMM-YYYY',
                  prefixIcon: Icon(Icons.event, size: 18),
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Please enter due date'
                    : null,
              ),
              const SizedBox(height: 16),

              // Instructions
              Text(
                'Detailed Instructions & Book Reference',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _descController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText:
                      'Specify workbook page numbers, exercise questions, and memorization tasks...',
                ),
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Please provide homework instructions'
                    : null,
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitHomework,
                  icon: const Icon(Icons.send_rounded, size: 18),
                  label: const Text('Publish Assignment to Class Diary'),
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
