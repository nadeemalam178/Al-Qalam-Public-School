import '../../services/account_management_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/school_provider.dart';
import '../../models/teacher_model.dart';
import '../../theme/app_theme.dart';

class TeacherManagementScreen extends StatefulWidget {
  const TeacherManagementScreen({super.key});

  @override
  State<TeacherManagementScreen> createState() =>
      _TeacherManagementScreenState();
}

class _TeacherManagementScreenState extends State<TeacherManagementScreen> {
  String _searchQuery = '';

  Future<void> _shareCredentialsWhatsApp(TeacherModel teacher) async {
    final digits = teacher.phone.replaceAll(RegExp(r'\D'), '');
    final cleanPhone = digits.length == 10 ? '91' + digits : digits;

    final msg = Uri.encodeComponent(
      'Assalamu Alaikum ${teacher.name} Ji,\n\n'
      'Here are your faculty login credentials for Al-Qalam Public School Mobile Management Portal:\n\n'
      '📱 Portal Role: Faculty / Teacher\n'
      '📚 Designation: ${teacher.subject} (${teacher.classAssigned})\n'
      '👤 Login ID: ${teacher.loginId}\n'
      '🔑 Password: ${teacher.password}\n\n'
      '📲 Download Official App: https://alqalampublicschool.vercel.app\n\n'
      'For any issues, please contact the School Office (+91 93084 62418).\n'
      '— Al-Qalam Public School Administration',
    );

    final url = Uri.parse('https://wa.me/' + cleanPhone + '?text=' + msg);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open WhatsApp.')),
        );
      }
    }
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddOrEditTeacherDialog([TeacherModel? existing]) {
    final isEditing = existing != null;
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final subjectCtrl = TextEditingController(text: existing?.subject ?? '');
    final classCtrl =
        TextEditingController(text: existing?.classAssigned ?? 'Class 1');
    final phoneCtrl = TextEditingController(text: existing?.phone ?? '');
    final emailCtrl = TextEditingController(text: existing?.email ?? '');
    final qualCtrl = TextEditingController(
        text: existing?.qualification ?? 'B.Ed / Trained Graduate');
    final loginIdCtrl = TextEditingController(
        text: existing?.loginId ?? '');
    final passwordCtrl = TextEditingController(
        text: existing?.password ?? 'alqalam123');
    bool obscurePass = false;
    final formKey = GlobalKey<FormState>();

    final classes = [
      'Pre-School / Nursery',
      'LKG',
      'UKG',
      'Class 1',
      'Class 2',
      'Class 3',
      'Class 4',
      'Class 5',
      'All Primary Classes',
    ];

    String selectedClass = existing?.classAssigned ?? 'Class 1';
    if (!classes.contains(selectedClass)) {
      selectedClass = classes.first;
    }

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.forestTint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isEditing ? Icons.edit : Icons.person_add_rounded,
                  color: AppTheme.forestPrimary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  isEditing ? 'Edit Teacher Details' : 'Add New Teacher',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.forestDeep,
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Teacher Full Name *',
                      prefixIcon: Icon(Icons.person_outline, size: 18),
                    ),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Name is required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: subjectCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Subject / Designation *',
                      hintText: 'e.g. Mathematics, Science, Urdu & Deeniyat',
                      prefixIcon: Icon(Icons.menu_book_outlined, size: 18),
                    ),
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Subject is required'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: selectedClass,
                    decoration: const InputDecoration(
                      labelText: 'Class Assigned *',
                      prefixIcon: Icon(Icons.class_outlined, size: 18),
                    ),
                    items: classes
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        setDialogState(() => selectedClass = v);
                        classCtrl.text = v;
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number *',
                      prefixIcon: Icon(Icons.phone_outlined, size: 18),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Phone number is required';
                      }
                      if (v.trim().replaceAll(RegExp(r'\D'), '').length < 10) {
                        return 'Enter a valid 10-digit number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address (Optional)',
                      prefixIcon: Icon(Icons.email_outlined, size: 18),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: qualCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Qualification',
                      hintText: 'e.g. B.Ed, M.Sc, Fazil',
                      prefixIcon: Icon(Icons.school_outlined, size: 18),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Login Credentials Box
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.forestTint,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.forestPrimary.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.vpn_key_rounded, size: 16, color: AppTheme.forestPrimary),
                            const SizedBox(width: 6),
                            Text(
                              'Teacher Login Credentials',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.forestDeep,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: loginIdCtrl,
                          decoration: InputDecoration(
                            labelText: 'Login ID / Username *',
                            hintText: 'e.g. 9431056782 or teacher_farzana',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.badge_outlined, size: 18),
                            helperText: 'Teacher will enter this ID to log in to Faculty Portal',
                            helperStyle: GoogleFonts.inter(fontSize: 10),
                          ),
                          validator: (v) => v == null || v.trim().isEmpty ? 'Login ID is required' : null,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: passwordCtrl,
                          obscureText: obscurePass,
                          decoration: InputDecoration(
                            labelText: 'Login Password *',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.lock_outline, size: 18),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePass ? Icons.visibility_off : Icons.visibility,
                                size: 18,
                              ),
                              onPressed: () => setDialogState(() => obscurePass = !obscurePass),
                            ),
                          ),
                          validator: (v) => v == null || v.trim().isEmpty ? 'Password is required' : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel', style: GoogleFonts.inter(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final school =
                      Provider.of<SchoolProvider>(context, listen: false);

                  final phone = phoneCtrl.text.trim();
                  final loginId = loginIdCtrl.text.trim().isNotEmpty
                      ? loginIdCtrl.text.trim()
                      : phone;
                  final password = passwordCtrl.text.trim().isNotEmpty
                      ? passwordCtrl.text.trim()
                      : 'alqalam123';

                  final teacher = TeacherModel(
                    id: isEditing
                        ? existing.id
                        : 'TEA-${DateTime.now().millisecondsSinceEpoch}',
                    name: nameCtrl.text.trim(),
                    subject: subjectCtrl.text.trim(),
                    classAssigned: selectedClass,
                    phone: phone,
                    email: emailCtrl.text.trim(),
                    qualification: qualCtrl.text.trim(),
                    loginId: loginId,
                    password: password,
                    isActive: true,
                  );

                  AccountManagementService.saveTeacher(teacher);

                  if (isEditing) {
                    school.updateTeacher(teacher);
                  } else {
                    school.addTeacher(teacher);
                  }

                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isEditing
                            ? 'Teacher profile updated successfully!'
                            : 'New teacher added to school faculty!',
                        style: GoogleFonts.inter(),
                      ),
                      backgroundColor: AppTheme.forestPrimary,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.forestPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                isEditing ? 'Save Changes' : 'Add Teacher',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteTeacher(TeacherModel teacher) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Remove Teacher',
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to remove ${teacher.name} from the active teacher roster?',
          style: GoogleFonts.inter(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: GoogleFonts.inter()),
          ),
          ElevatedButton(
            onPressed: () {
              final school =
                  Provider.of<SchoolProvider>(context, listen: false);
              school.deleteTeacher(teacher.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Teacher ${teacher.name} removed from roster.',
                    style: GoogleFonts.inter(),
                  ),
                  backgroundColor: Colors.redAccent,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: Text('Remove',
                style: GoogleFonts.inter(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
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
    final canPop = ModalRoute.of(context)?.canPop ?? false;

    final filteredTeachers = school.teachers.where((t) {
      if (_searchQuery.isEmpty) return true;
      final q = _searchQuery.toLowerCase();
      return t.name.toLowerCase().contains(q) ||
          t.subject.toLowerCase().contains(q) ||
          t.classAssigned.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F6),
      appBar: canPop
          ? AppBar(
              title: const Text('Faculty & Teacher Management'),
              backgroundColor: AppTheme.forestDeep,
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _showAddOrEditTeacherDialog(),
                ),
              ],
            )
          : null,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddOrEditTeacherDialog(),
        backgroundColor: AppTheme.forestPrimary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add Teacher',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
        top: !canPop,
        bottom: true,
        child: Column(
          children: [
            // Top Summary & Search Header
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${school.teachers.length} Active Faculty Members',
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.forestDeep,
                            ),
                          ),
                          Text(
                            'Al-Qalam Primary Teaching Staff',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.forestTint,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Staff Roster',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.forestDeep,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) => setState(() => _searchQuery = val.trim()),
                      decoration: InputDecoration(
                        hintText: 'Search teacher by name or subject...',
                        hintStyle: GoogleFonts.inter(
                            fontSize: 12, color: Colors.grey[500]),
                        prefixIcon:
                            const Icon(Icons.search, size: 20, color: Colors.grey),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _searchQuery = '');
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Teachers List
            Expanded(
              child: filteredTeachers.isEmpty
                  ? Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppTheme.forestTint,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.people_outline_rounded,
                                size: 48,
                                color: AppTheme.forestPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _searchQuery.isNotEmpty
                                  ? 'No teachers match "$_searchQuery"'
                                  : 'No Faculty Members Registered Yet',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.forestDeep,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _searchQuery.isNotEmpty
                                  ? 'Try checking spelling or clearing the search filter.'
                                  : 'Tap "+ Add Teacher" to register primary and foundational school faculty.',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppTheme.textMuted,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () => _showAddOrEditTeacherDialog(),
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Add First Teacher'),
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
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 96),
                      itemCount: filteredTeachers.length,
                      itemBuilder: (context, index) {
                        final teacher = filteredTeachers[index];
                        final initials = teacher.name.isNotEmpty
                            ? teacher.name
                                .trim()
                                .split(' ')
                                .map((e) => e.isNotEmpty ? e[0] : '')
                                .take(2)
                                .join()
                                .toUpperCase()
                            : 'T';

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 22,
                                      backgroundColor: AppTheme.forestTint,
                                      child: Text(
                                        initials,
                                        style: GoogleFonts.outfit(
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.forestPrimary,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            teacher.name,
                                            style: GoogleFonts.outfit(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: AppTheme.forestDeep,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            teacher.qualification,
                                            style: GoogleFonts.inter(
                                              fontSize: 11,
                                              color: AppTheme.textMuted,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuButton<String>(
                                      icon: const Icon(Icons.more_vert,
                                          color: Colors.grey),
                                      onSelected: (val) {
                                        if (val == 'edit') {
                                          _showAddOrEditTeacherDialog(teacher);
                                        } else if (val == 'delete') {
                                          _confirmDeleteTeacher(teacher);
                                        }
                                      },
                                      itemBuilder: (ctx) => [
                                        const PopupMenuItem(
                                          value: 'edit',
                                          child: Row(
                                            children: [
                                              Icon(Icons.edit,
                                                  size: 16, color: Colors.blue),
                                              SizedBox(width: 8),
                                              Text('Edit Profile'),
                                            ],
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: Row(
                                            children: [
                                              Icon(Icons.delete,
                                                  size: 16, color: Colors.red),
                                              SizedBox(width: 8),
                                              Text('Remove Teacher'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 6,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: AppTheme.forestTint,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        teacher.subject,
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.forestDeep,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.amber.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        teacher.classAssigned,
                                        style: GoogleFonts.inter(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.brown[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const SizedBox(height: 10),
                                // Credentials Pill
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9FAFB),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey.shade200),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.vpn_key_rounded, size: 13, color: AppTheme.forestPrimary),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          'ID: ${teacher.loginId}   •   Pass: ${teacher.password}',
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.forestDeep,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Divider(height: 1),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () => _makeCall(teacher.phone),
                                        icon: const Icon(Icons.phone, size: 14),
                                        label: const Text('Call'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: AppTheme.forestPrimary,
                                          side: const BorderSide(color: AppTheme.forestPrimary),
                                          padding: const EdgeInsets.symmetric(vertical: 6),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      flex: 2,
                                      child: ElevatedButton.icon(
                                        onPressed: () => _shareCredentialsWhatsApp(teacher),
                                        icon: const Icon(Icons.share, size: 14),
                                        label: const Text('WhatsApp Login ID'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF25D366),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(vertical: 6),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
