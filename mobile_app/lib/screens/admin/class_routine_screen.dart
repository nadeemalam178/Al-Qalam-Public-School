import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/timetable_model.dart';
import '../../theme/app_theme.dart';

class ClassRoutineScreen extends StatefulWidget {
  const ClassRoutineScreen({super.key});

  @override
  State<ClassRoutineScreen> createState() => _ClassRoutineScreenState();
}

class _ClassRoutineScreenState extends State<ClassRoutineScreen> {
  static const _storage = FlutterSecureStorage();

  final List<String> _classes = [
    'Pre-School',
    'LKG',
    'UKG',
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5',
  ];

  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  late String _selectedClass;
  late String _selectedDay;
  Map<String, List<TimetableSlot>> _routineCache = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedClass = _classes[3]; // Default Class 1
    _selectedDay = _days.first; // Default Monday
    _loadSavedRoutines();
  }

  String _cacheKey(String grade, String day) => 'routine_${grade}_$day';

  Future<void> _loadSavedRoutines() async {
    setState(() => _isLoading = true);
    try {
      final key = _cacheKey(_selectedClass, _selectedDay);
      final raw = await _storage.read(key: key);
      if (raw != null) {
        final List decoded = jsonDecode(raw);
        _routineCache[key] = decoded.map((e) {
          return TimetableSlot(
            period: (e['period'] as num? ?? 1).toInt(),
            time: (e['time'] ?? '08:00 AM - 08:45 AM') as String,
            subject: (e['subject'] ?? 'General') as String,
            teacher: (e['teacher'] ?? 'Faculty') as String,
            room: (e['room'] ?? 'Room 101') as String,
          );
        }).toList();
      } else {
        _routineCache[key] = [];
      }
    } catch (_) {
      _routineCache[_cacheKey(_selectedClass, _selectedDay)] = [];
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveRoutineForCurrent() async {
    final key = _cacheKey(_selectedClass, _selectedDay);
    final slots = _routineCache[key] ?? [];
    final jsonList = jsonEncode(slots
        .map((s) => {
              'period': s.period,
              'time': s.time,
              'subject': s.subject,
              'teacher': s.teacher,
              'room': s.room,
            })
        .toList());
    await _storage.write(key: key, value: jsonList);
  }

  void _showAddOrEditSlotDialog([TimetableSlot? existing]) {
    final isEditing = existing != null;
    final periodCtrl = TextEditingController(
        text: existing != null ? existing.period.toString() : '');
    final timeCtrl = TextEditingController(
        text: existing?.time ?? '08:00 AM - 08:45 AM');
    final subjectCtrl = TextEditingController(text: existing?.subject ?? '');
    final teacherCtrl = TextEditingController(text: existing?.teacher ?? '');
    final roomCtrl =
        TextEditingController(text: existing?.room ?? 'Room 101');
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.forestTint,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.schedule, color: AppTheme.forestPrimary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                isEditing ? 'Edit Period Slot' : 'Add Period Slot',
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
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: periodCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Period # *',
                          hintText: '1',
                        ),
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: timeCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Time Range *',
                          hintText: '08:00 AM - 08:45 AM',
                        ),
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: subjectCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Subject Name *',
                    hintText: 'e.g. Mathematics, Urdu, English',
                    prefixIcon: Icon(Icons.menu_book, size: 18),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Subject is required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: teacherCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Teacher Name *',
                    hintText: 'e.g. Farzana Begum',
                    prefixIcon: Icon(Icons.person, size: 18),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Teacher is required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: roomCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Classroom / Hall',
                    hintText: 'e.g. Room 102, Junior Wing',
                    prefixIcon: Icon(Icons.meeting_room, size: 18),
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
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final key = _cacheKey(_selectedClass, _selectedDay);
                final slots = _routineCache[key] ?? [];

                final newSlot = TimetableSlot(
                  period: int.tryParse(periodCtrl.text.trim()) ?? 1,
                  time: timeCtrl.text.trim(),
                  subject: subjectCtrl.text.trim(),
                  teacher: teacherCtrl.text.trim(),
                  room: roomCtrl.text.trim(),
                );

                if (isEditing) {
                  final idx = slots.indexWhere((s) => s.period == existing.period);
                  if (idx != -1) {
                    slots[idx] = newSlot;
                  } else {
                    slots.add(newSlot);
                  }
                } else {
                  slots.add(newSlot);
                }

                slots.sort((a, b) => a.period.compareTo(b.period));
                _routineCache[key] = slots;

                await _saveRoutineForCurrent();
                setState(() {});
                Navigator.pop(ctx);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.forestPrimary,
            ),
            child: Text(
              isEditing ? 'Save Slot' : 'Add Slot',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteSlot(TimetableSlot slot) async {
    final key = _cacheKey(_selectedClass, _selectedDay);
    final slots = _routineCache[key] ?? [];
    slots.removeWhere((s) => s.period == slot.period);
    _routineCache[key] = slots;
    await _saveRoutineForCurrent();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop ?? false;
    final currentSlots =
        _routineCache[_cacheKey(_selectedClass, _selectedDay)] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F6),
      appBar: canPop
          ? AppBar(
              title: const Text('Class Routine & Schedule'),
              backgroundColor: AppTheme.forestDeep,
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _showAddOrEditSlotDialog(),
                ),
              ],
            )
          : null,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddOrEditSlotDialog(),
        backgroundColor: AppTheme.forestPrimary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add Period',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
        top: !canPop,
        bottom: true,
        child: Column(
          children: [
            // Class Selector Tabs
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: _classes.map((cls) {
                    final isSel = _selectedClass == cls;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(cls),
                        selected: isSel,
                        selectedColor: AppTheme.forestPrimary,
                        backgroundColor: const Color(0xFFF3F4F6),
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSel ? Colors.white : AppTheme.textDark,
                        ),
                        onSelected: (val) {
                          if (val) {
                            setState(() => _selectedClass = cls);
                            _loadSavedRoutines();
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Day Selector Tabs
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _days.map((day) {
                    final isSel = _selectedDay == day;
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: InkWell(
                        onTap: () {
                          setState(() => _selectedDay = day);
                          _loadSavedRoutines();
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSel
                                ? AppTheme.goldDark
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSel
                                  ? AppTheme.goldDark
                                  : Colors.grey.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            day,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isSel ? Colors.white : AppTheme.textMuted,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const Divider(height: 1),

            // Routine Slots List
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: AppTheme.forestPrimary))
                  : currentSlots.isEmpty
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
                                    Icons.calendar_today_rounded,
                                    size: 44,
                                    color: AppTheme.forestPrimary,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No Routine Configured for $_selectedClass ($_selectedDay)',
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.forestDeep,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Tap "+ Add Period" to set up subjects, timings, and faculty periods.',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppTheme.textMuted,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton.icon(
                                  onPressed: () => _showAddOrEditSlotDialog(),
                                  icon: const Icon(Icons.add, size: 18),
                                  label: const Text('Add Period 1'),
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
                          itemCount: currentSlots.length,
                          itemBuilder: (context, index) {
                            final slot = currentSlots[index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: Colors.grey.withValues(alpha: 0.15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.02),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 6),
                                leading: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: AppTheme.forestTint,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'P${slot.period}',
                                      style: GoogleFonts.outfit(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.forestDeep,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  slot.subject,
                                  style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: AppTheme.forestDeep,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 3),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time,
                                            size: 12, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Text(
                                          slot.time,
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            color: AppTheme.textMuted,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        const Icon(Icons.person_outline,
                                            size: 12, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${slot.teacher} • ${slot.room}',
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            color: AppTheme.forestPrimary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          size: 18, color: Colors.blueGrey),
                                      onPressed: () =>
                                          _showAddOrEditSlotDialog(slot),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline,
                                          size: 18, color: Colors.redAccent),
                                      onPressed: () => _deleteSlot(slot),
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
