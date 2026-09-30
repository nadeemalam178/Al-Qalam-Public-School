import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/school_data_repository.dart';
import '../../theme/app_theme.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  int _selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
    final timetables = SchoolDataRepository.timetableData;
    final currentDay = timetables[_selectedDayIndex % timetables.length];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Timetable (Class 3-A)'),
        backgroundColor: AppTheme.forestDeep,
      ),
      body: Column(
        children: [
          // Day Selector Tabs
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(timetables.length, (index) {
                  final isSelected = _selectedDayIndex == index;
                  final day = timetables[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(day.dayName),
                      selected: isSelected,
                      selectedColor: AppTheme.forestPrimary,
                      backgroundColor: const Color(0xFFF9FAFB),
                      labelStyle: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppTheme.textDark,
                      ),
                      onSelected: (_) {
                        setState(() {
                          _selectedDayIndex = index;
                        });
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
          const Divider(height: 1),

          // Period Slots List
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              itemCount: currentDay.slots.length,
              itemBuilder: (context, index) {
                final slot = currentDay.slots[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Period circle badge
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppTheme.forestTint,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.forestPrimary.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'P${slot.period}',
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.forestDeep,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                slot.subject,
                                style: GoogleFonts.outfit(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.person_outline,
                                      size: 14, color: AppTheme.textMuted),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      slot.teacher,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: AppTheme.textMuted,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.meeting_room_outlined,
                                      size: 14, color: AppTheme.textMuted),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      slot.room,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: AppTheme.textMuted,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            slot.time,
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
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
