import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/school_provider.dart';
import '../../models/homework_model.dart';
import '../../theme/app_theme.dart';

class ParentHomeworkScreen extends StatefulWidget {
  const ParentHomeworkScreen({super.key});

  @override
  State<ParentHomeworkScreen> createState() => _ParentHomeworkScreenState();
}

class _ParentHomeworkScreenState extends State<ParentHomeworkScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final school = Provider.of<SchoolProvider>(context);
    final student = school.getStudentById('STU-001');
    final allHomework = school.getHomeworkForGrade(student.grade);

    final pendingList = allHomework.where((h) => !h.isCompleted).toList();
    final completedList = allHomework.where((h) => h.isCompleted).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            indicatorColor: AppTheme.forestPrimary,
            indicatorWeight: 3,
            labelColor: AppTheme.forestPrimary,
            unselectedLabelColor: AppTheme.textMuted,
            labelStyle: GoogleFonts.inter(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Pending (${pendingList.length})'),
              Tab(text: 'Completed (${completedList.length})'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHomeworkListView(school, pendingList, isPending: true),
          _buildHomeworkListView(school, completedList, isPending: false),
        ],
      ),
    );
  }

  Widget _buildHomeworkListView(
      SchoolProvider school, List<HomeworkItem> items,
      {required bool isPending}) {
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isPending
                    ? Icons.sentiment_satisfied_alt_rounded
                    : Icons.menu_book_outlined,
                size: 56,
                color: AppTheme.forestLight,
              ),
              const SizedBox(height: 16),
              Text(
                isPending
                    ? 'All Caught Up!'
                    : 'No completed assignments yet',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.forestDeep,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isPending
                    ? 'No outstanding homework assignments for Class 3-A today.'
                    : 'Tasks you mark as completed will appear here.',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppTheme.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final hw = items[index];
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
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.forestTint,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        hw.subject,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.forestDeep,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined,
                            size: 14, color: AppTheme.goldDark),
                        const SizedBox(width: 4),
                        Text(
                          'Due: ${hw.dueDate}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.goldDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  hw.title,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  hw.description,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppTheme.textDark,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                const Divider(height: 1),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.person_outline,
                              size: 14, color: AppTheme.textMuted),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Teacher: ${hw.teacherName}',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: AppTheme.textMuted,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        school.toggleHomeworkCompletion(hw.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              hw.isCompleted
                                  ? 'Marked as pending'
                                  : 'Marked as completed! Well done.',
                              style: GoogleFonts.inter(),
                            ),
                            backgroundColor: AppTheme.forestPrimary,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        child: Row(
                          children: [
                            Checkbox(
                              value: hw.isCompleted,
                              activeColor: AppTheme.forestPrimary,
                              onChanged: (_) {
                                school.toggleHomeworkCompletion(hw.id);
                              },
                            ),
                            Text(
                              hw.isCompleted ? 'Completed' : 'Mark Done',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: hw.isCompleted
                                    ? AppTheme.forestPrimary
                                    : AppTheme.textDark,
                              ),
                            ),
                          ],
                        ),
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
}
