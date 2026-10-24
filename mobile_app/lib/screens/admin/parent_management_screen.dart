import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/parent_account_model.dart';
import '../../services/account_management_service.dart';
import '../../theme/app_theme.dart';

class ParentManagementScreen extends StatefulWidget {
  const ParentManagementScreen({super.key});

  @override
  State<ParentManagementScreen> createState() => _ParentManagementScreenState();
}

class _ParentManagementScreenState extends State<ParentManagementScreen> {
  List<ParentAccountModel> _parents = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String _selectedGrade = 'All';

  final List<String> _grades = [
    'All',
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
  void initState() {
    super.initState();
    _loadParents();
  }

  Future<void> _loadParents() async {
    setState(() => _isLoading = true);
    final list = await AccountManagementService.getParents();
    if (mounted) {
      setState(() {
        _parents = list;
        _isLoading = false;
      });
    }
  }

  Future<void> _shareOnWhatsApp(ParentAccountModel parent) async {
    final digits = parent.phone.replaceAll(RegExp(r'\D'), '');
    final cleanPhone = digits.length == 10 ? '91$digits' : digits;

    final msg = Uri.encodeComponent(
      'Assalamu Alaikum ${parent.parentName} Ji,\n\n'
      'Here are your login credentials for Al-Qalam Public School Mobile Management Portal:\n\n'
      '🎓 Student: ${parent.studentName} (${parent.grade}, Roll No: ${parent.rollNo})\n'
      '📱 Portal Role: Parent / Guardian\n'
      '👤 Login ID / Mobile: ${parent.loginId}\n'
      '🔑 Password: ${parent.password}\n\n'
      '📲 Download Official App: https://alqalampublicschool.vercel.app\n\n'
      'For any help, please contact the School Office (+91 93084 62418).\n'
      '— Al-Qalam Public School Administration',
    );

    final url = Uri.parse('https://wa.me/$cleanPhone?text=$msg');
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

  Future<void> _callParent(String phone) async {
    final cleanDigits = phone.replaceAll(RegExp(r'\D'), '');
    final url = Uri.parse('tel:$cleanDigits');
    try {
      await launchUrl(url);
    } catch (_) {}
  }

  void _showAddOrEditParentDialog([ParentAccountModel? existing]) {
    final isEditing = existing != null;
    final studentNameCtrl =
        TextEditingController(text: existing?.studentName ?? '');
    final parentNameCtrl =
        TextEditingController(text: existing?.parentName ?? '');
    final rollCtrl = TextEditingController(text: existing?.rollNo ?? '1');
    final phoneCtrl = TextEditingController(text: existing?.phone ?? '');
    final loginIdCtrl = TextEditingController(
        text: existing?.loginId ?? '');
    final passwordCtrl =
        TextEditingController(text: existing?.password ?? 'alqalam2026');
    bool obscurePass = false;
    final formKey = GlobalKey<FormState>();

    String selectedGrade = existing?.grade ?? 'Class 1';
    if (!_grades.contains(selectedGrade) || selectedGrade == 'All') {
      selectedGrade = 'Class 1';
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
                  isEditing ? Icons.edit : Icons.person_add_alt_1_rounded,
                  color: AppTheme.forestPrimary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  isEditing
                      ? 'Edit Parent Account'
                      : 'Create Parent Login ID',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create dedicated login credentials for parents to check attendance, fee receipts, and homework.',
                    style:
                        GoogleFonts.inter(fontSize: 12, color: AppTheme.textMuted),
                  ),
                  const SizedBox(height: 16),

                  // Student Name
                  TextFormField(
                    controller: studentNameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Student Full Name *',
                      prefixIcon: Icon(Icons.school_outlined, size: 18),
                    ),
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Student name is required'
                        : null,
                  ),
                  const SizedBox(height: 12),

                  // Parent Name
                  TextFormField(
                    controller: parentNameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Parent / Guardian Name *',
                      prefixIcon: Icon(Icons.person_outline, size: 18),
                    ),
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Guardian name is required'
                        : null,
                  ),
                  const SizedBox(height: 12),

                  // Class Selector & Roll No
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField<String>(
                          initialValue: selectedGrade,
                          decoration: const InputDecoration(
                            labelText: 'Class *',
                            prefixIcon: Icon(Icons.class_outlined, size: 18),
                          ),
                          items: _grades
                              .where((g) => g != 'All')
                              .map((g) => DropdownMenuItem(
                                  value: g, child: Text(g, style: GoogleFonts.inter(fontSize: 13))))
                              .toList(),
                          onChanged: (v) {
                            if (v != null) {
                              setDialogState(() => selectedGrade = v);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: rollCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Roll No',
                            prefixIcon: Icon(Icons.pin, size: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Phone
                  TextFormField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Registered Mobile Number *',
                      prefixIcon: Icon(Icons.phone_outlined, size: 18),
                    ),
                    onChanged: (v) {
                      if (!isEditing && loginIdCtrl.text.isEmpty) {
                        setDialogState(() {
                          loginIdCtrl.text = v.trim();
                        });
                      }
                    },
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Mobile number is required';
                      }
                      if (v.trim().replaceAll(RegExp(r'\D'), '').length < 10) {
                        return 'Enter a valid 10-digit number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Credentials Sub-box
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.forestTint,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: AppTheme.forestPrimary.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.vpn_key_rounded,
                                size: 16, color: AppTheme.forestPrimary),
                            const SizedBox(width: 6),
                            Text(
                              'Login Credentials for Guardian',
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
                            hintText: 'e.g. 9835012450 or roll number',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon:
                                const Icon(Icons.badge_outlined, size: 18),
                            helperText:
                                'Guardian will enter this ID on the app login screen',
                            helperStyle: GoogleFonts.inter(fontSize: 10),
                          ),
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Login ID is required'
                              : null,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: passwordCtrl,
                          obscureText: obscurePass,
                          decoration: InputDecoration(
                            labelText: 'Login Password *',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon:
                                const Icon(Icons.lock_outline, size: 18),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePass
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 18,
                              ),
                              onPressed: () => setDialogState(
                                  () => obscurePass = !obscurePass),
                            ),
                          ),
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Password is required'
                              : null,
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
              child:
                  Text('Cancel', style: GoogleFonts.inter(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final phone = phoneCtrl.text.trim();
                  final loginId = loginIdCtrl.text.trim().isNotEmpty
                      ? loginIdCtrl.text.trim()
                      : phone;
                  final password = passwordCtrl.text.trim().isNotEmpty
                      ? passwordCtrl.text.trim()
                      : 'alqalam2026';

                  final parent = ParentAccountModel(
                    id: isEditing
                        ? existing.id
                        : 'PAR-${DateTime.now().millisecondsSinceEpoch}',
                    studentName: studentNameCtrl.text.trim(),
                    parentName: parentNameCtrl.text.trim(),
                    grade: selectedGrade,
                    rollNo: rollCtrl.text.trim().isNotEmpty
                        ? rollCtrl.text.trim()
                        : '1',
                    phone: phone,
                    loginId: loginId,
                    password: password,
                    isActive: true,
                  );

                  await AccountManagementService.saveParent(parent);
                  Navigator.pop(ctx);
                  _loadParents();

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isEditing
                              ? 'Parent account updated!'
                              : 'Parent login created! You can now share it via WhatsApp.',
                          style: GoogleFonts.inter(),
                        ),
                        backgroundColor: AppTheme.forestPrimary,
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.forestPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                isEditing ? 'Save Changes' : 'Create Login',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(ParentAccountModel parent) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.red),
            const SizedBox(width: 8),
            Text('Remove Parent Login',
                style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          'Are you sure you want to remove the login account for ${parent.parentName} (${parent.studentName})?\n\nThey will no longer be able to log in to the school portal.',
          style: GoogleFonts.inter(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await AccountManagementService.deleteParent(parent.id);
              _loadParents();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _parents.where((p) {
      final matchesGrade =
          _selectedGrade == 'All' || p.grade == _selectedGrade;
      final query = _searchQuery.toLowerCase();
      final matchesSearch = query.isEmpty ||
          p.studentName.toLowerCase().contains(query) ||
          p.parentName.toLowerCase().contains(query) ||
          p.phone.contains(query) ||
          p.loginId.toLowerCase().contains(query);
      return matchesGrade && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F6),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Parent & Guardian Logins',
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Create & manage guardian credentials for portal access',
              style: GoogleFonts.inter(fontSize: 11, color: Colors.white70),
            ),
          ],
        ),
        backgroundColor: AppTheme.forestPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddOrEditParentDialog(),
        backgroundColor: AppTheme.forestPrimary,
        icon: const Icon(Icons.person_add_alt_1_rounded, color: Colors.white),
        label: Text(
          '+ Create Parent Login',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // Search & Filter Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by student, guardian name or mobile...',
                hintStyle: GoogleFonts.inter(fontSize: 13, color: Colors.grey),
                prefixIcon: const Icon(Icons.search, size: 20),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                fillColor: const Color(0xFFF9FAFB),
                filled: true,
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),

          // Grade Filter Tabs
          Container(
            color: Colors.white,
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              itemCount: _grades.length,
              itemBuilder: (ctx, i) {
                final g = _grades[i];
                final isSelected = _selectedGrade == g;
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ChoiceChip(
                    label: Text(g, style: GoogleFonts.inter(fontSize: 12)),
                    selected: isSelected,
                    selectedColor: AppTheme.forestPrimary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppTheme.textDark,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (val) {
                      if (val) setState(() => _selectedGrade = g);
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),

          // Content List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : filtered.isEmpty
                    ? Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  color: AppTheme.forestTint,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.family_restroom_rounded,
                                  size: 48,
                                  color: AppTheme.forestPrimary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _searchQuery.isNotEmpty
                                    ? 'No Parent Accounts Found'
                                    : 'No Parent Logins Created Yet',
                                style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.forestDeep,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _searchQuery.isNotEmpty
                                    ? 'Try adjusting your search criteria.'
                                    : 'Tap the button below to create student & parent credentials.',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: AppTheme.textMuted,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton.icon(
                                onPressed: () => _showAddOrEditParentDialog(),
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text('Create First Parent Account'),
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
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                        itemCount: filtered.length,
                        itemBuilder: (ctx, i) {
                          final parent = filtered[i];
                          return _buildParentCard(parent);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildParentCard(ParentAccountModel parent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student & Grade Row
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppTheme.forestTint,
                  child: Text(
                    parent.studentName.isNotEmpty
                        ? parent.studentName[0].toUpperCase()
                        : 'S',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.forestPrimary,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        parent.studentName,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.forestDeep,
                        ),
                      ),
                      Text(
                        'Parent: ${parent.parentName} • ${parent.grade} (Roll: ${parent.rollNo})',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (val) {
                    if (val == 'edit') _showAddOrEditParentDialog(parent);
                    if (val == 'delete') _confirmDelete(parent);
                  },
                  itemBuilder: (ctx) => [
                    const PopupMenuItem(
                        value: 'edit', child: Text('Edit Account')),
                    const PopupMenuItem(
                        value: 'delete',
                        child:
                            Text('Delete', style: TextStyle(color: Colors.red))),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Credentials Box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.vpn_key_rounded,
                      size: 14, color: AppTheme.forestPrimary),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'ID: ${parent.loginId}   •   Pass: ${parent.password}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.forestDeep,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _callParent(parent.phone),
                    icon: const Icon(Icons.phone, size: 15),
                    label: const Text('Call'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.forestPrimary,
                      side: const BorderSide(color: AppTheme.forestPrimary),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: () => _shareOnWhatsApp(parent),
                    icon: const Icon(Icons.share, size: 15),
                    label: const Text('WhatsApp Login ID'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
