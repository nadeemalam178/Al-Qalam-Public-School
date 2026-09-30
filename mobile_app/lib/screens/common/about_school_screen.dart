import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/school_provider.dart';
import '../../models/admission_inquiry_model.dart';
import '../../theme/app_theme.dart';
import '../../services/school_data_repository.dart';

class AboutSchoolScreen extends StatefulWidget {
  const AboutSchoolScreen({super.key});

  @override
  State<AboutSchoolScreen> createState() => _AboutSchoolScreenState();
}

class _AboutSchoolScreenState extends State<AboutSchoolScreen> {
  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedGrade = 'Nursery / Pre-School';

  final List<String> _grades = [
    'Nursery / Pre-School',
    'Lower Kindergarten (LKG)',
    'Upper Kindergarten (UKG)',
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5',
  ];

  @override
  void dispose() {
    _studentNameController.dispose();
    _parentNameController.dispose();
    _mobileController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitInquiry() {
    if (_formKey.currentState!.validate()) {
      final school = Provider.of<SchoolProvider>(context, listen: false);
      final refId = 'AQPS-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

      final inq = AdmissionInquiry(
        id: 'INQ-${DateTime.now().millisecondsSinceEpoch}',
        referenceId: refId,
        studentName: _studentNameController.text.trim(),
        parentName: _parentNameController.text.trim(),
        mobile: _mobileController.text.trim(),
        grade: _selectedGrade,
        message: _messageController.text.trim(),
        submissionDate: '30-Sep-2026',
        status: 'New Enquiry',
      );

      school.submitAdmissionInquiry(inq);

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(Icons.check_circle, color: AppTheme.forestPrimary, size: 28),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Enquiry Registered!',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.forestDeep,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thank you for your interest in Al-Qalam Public School.',
                  style: GoogleFonts.inter(fontSize: 13),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.forestTint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.confirmation_number_outlined,
                          color: AppTheme.forestPrimary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reference Tracking ID:',
                                style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textMuted)),
                            Text(
                              refId,
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.forestDeep,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Our admission counselor desk will contact you on ${_mobileController.text.trim()} to schedule an interactive campus visit.',
                  style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textMuted),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                _studentNameController.clear();
                _parentNameController.clear();
                _mobileController.clear();
                _messageController.clear();
              },
              child: const Text('Done'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Al-Qalam Campus'),
        backgroundColor: AppTheme.forestDeep,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campus Hero Banner
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/real/students-classroom.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppTheme.forestDeep,
                        child: const Center(
                          child: Icon(Icons.school, size: 64, color: Colors.white24),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.75),
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.85),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            SchoolDataRepository.schoolMottoArabic,
                            style: GoogleFonts.amiri(
                              fontSize: 18,
                              color: AppTheme.goldPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            SchoolDataRepository.schoolName,
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Foundational & Primary School • Gulzarbagh, Patna',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Director's Statement
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFECEFF1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.forestTint,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.format_quote_rounded,
                            color: AppTheme.forestPrimary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SchoolDataRepository.directorName,
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.forestDeep,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              SchoolDataRepository.directorTitle,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppTheme.textMuted,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '"Al-Qalam Public School was founded to offer children in Gulzarbagh and Patna a disciplined, caring, and values-centered start to formal schooling. Our objective is to develop sound foundational literacy, arithmetic comprehension, and moral character in every student."',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: AppTheme.textDark,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Campus Core Highlights
            Text(
              'Campus Pillars & Facilities',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.forestDeep,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildFacilityCard(
                    'CCTV Campus',
                    '24/7 Monitored Hallways & Security Gate',
                    Icons.security_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildFacilityCard(
                    'Smart Learning',
                    'Audio-Visual Enabled Primary Classrooms',
                    Icons.tv_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildFacilityCard(
                    'Values & Urdu',
                    'Character Ethics & Languages Program',
                    Icons.menu_book_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildFacilityCard(
                    'Reading Corner',
                    'Foundational Library with Illustrated Books',
                    Icons.local_library_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Real Photo Gallery
            Text(
              'Glimpses from Campus Activities',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.forestDeep,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildGalleryThumbnail('assets/real/students-classroom.jpg', 'Active Class'),
                  _buildGalleryThumbnail('assets/real/drawing-competition.jpg', 'Art Competition'),
                  _buildGalleryThumbnail('assets/real/educational-trip.jpg', 'Educational Excursion'),
                  _buildGalleryThumbnail('assets/real/star-student-certificate.jpg', 'Honor Recognition'),
                  _buildGalleryThumbnail('assets/real/class-topper-certificate.jpg', 'Academic Excellence'),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Admission Enquiry Form
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.goldPrimary.withValues(alpha: 0.4)),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.forestDeep.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.forestTint,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.school, color: AppTheme.forestPrimary),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Apply for Admission (2026-27)',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.forestDeep,
                                ),
                              ),
                              Text(
                                'Submit registration inquiry directly to school desk',
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
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _studentNameController,
                      decoration: const InputDecoration(
                        labelText: 'Child Full Name *',
                        prefixIcon: Icon(Icons.person_outline, size: 18),
                      ),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Child full name is required'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _parentNameController,
                      decoration: const InputDecoration(
                        labelText: 'Parent / Guardian Name *',
                        prefixIcon: Icon(Icons.family_restroom, size: 18),
                      ),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Parent name is required'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: '10-Digit Mobile Number *',
                        prefixIcon: Icon(Icons.phone, size: 18),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Mobile number is required';
                        }
                        if (val.trim().length < 10) {
                          return 'Enter valid 10-digit number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedGrade,
                      decoration: const InputDecoration(
                        labelText: 'Class Applying For *',
                        prefixIcon: Icon(Icons.class_outlined, size: 18),
                      ),
                      items: _grades
                          .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedGrade = val);
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _messageController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Message or Notes (Optional)',
                        hintText: 'e.g. Previous school, transport requirement...',
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _submitInquiry,
                        icon: const Icon(Icons.send_rounded, size: 18),
                        label: const Text('Submit Admission Enquiry'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Contact & Campus Details Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFECEFF1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Campus Location & Hours',
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.forestDeep,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildContactLine(Icons.location_on, SchoolDataRepository.schoolAddress),
                  const SizedBox(height: 6),
                  _buildContactLine(Icons.phone, SchoolDataRepository.schoolPhone),
                  const SizedBox(height: 6),
                  _buildContactLine(Icons.email, SchoolDataRepository.schoolEmail),
                  const SizedBox(height: 6),
                  _buildContactLine(Icons.access_time, 'Office Timing: Mon - Sat: 8:30 AM to 1:30 PM'),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFacilityCard(String title, String desc, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFECEFF1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.forestPrimary, size: 22),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            desc,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryThumbnail(String imagePath, String caption) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFECEFF1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppTheme.forestTint,
                child: const Icon(Icons.image, color: AppTheme.forestPrimary),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: Colors.black54,
                child: Text(
                  caption,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactLine(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppTheme.forestPrimary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textDark),
          ),
        ),
      ],
    );
  }
}
