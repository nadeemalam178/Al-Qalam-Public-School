import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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

  final List<Map<String, String>> _galleryItems = [
    {
      'image': 'assets/real/school_building.png',
      'title': 'School Building (Hashmi Manzil)',
      'category': 'Campus Landmark',
      'description':
          'Al-Qalam Public School primary building located at Loharwa Ghat Lane, opposite Jashn Palace Marriage Hall, Alamganj, Patna-7.',
    },

    {
      'image': 'assets/real/rotary-shiksha-ratna-award.jpg',
      'title': 'Rotary Shiksha Ratna State Honor',
      'category': 'State Honor',
      'description':
          'Director Kausar Jahan receiving the prestigious Rotary Shiksha Ratna Award conferred by Hon\'ble Chief Minister Nitish Kumar for selfless service to grassroots child education in Patna.',
    },
    {
      'image': 'assets/real/interactive-classroom-session.jpg',
      'title': 'Smart AV Classroom Session',
      'category': 'Smart Learning',
      'description':
          'Engaging interactive audio-visual lesson on foundational science concepts with attentive primary students and modern projection displays.',
    },
    {
      'image': 'assets/real/classroom-learning.jpg',
      'title': 'Attentive Classroom Mentorship',
      'category': 'Academic Focus',
      'description':
          'Individual teacher attention and focused handwriting, reading, and arithmetic practice in a calm, disciplined learning environment.',
    },
    {
      'image': 'assets/real/educational-tour-bapu-tower.jpg',
      'title': 'Educational Tour to Bapu Tower',
      'category': 'Experiential Learning',
      'description':
          'Field excursion to Bapu Tower, Patna, inspiring students with historical knowledge, national ideals, and experiential learning outside campus walls.',
    },
    {
      'image': 'assets/real/educational-tour-eco-park.jpg',
      'title': 'Nature Excursion at Eco Park',
      'category': 'Outdoor Activity',
      'description':
          'Students discovering biodiversity, environment conservation, and physical agility through interactive nature walks at Rajdhani Vatika (Eco Park), Patna.',
    },
    {
      'image': 'assets/real/annual-drawing-competition.jpg',
      'title': 'Annual Art & Drawing Contest',
      'category': 'Creative Expression',
      'description':
          'Students showcasing vivid imagination, coloring skills, and creative artistic expression during the campus annual drawing festival.',
    },
    {
      'image': 'assets/real/annual-quiz-competition.jpg',
      'title': 'Annual Inter-House Quiz Competition',
      'category': 'Intellect & General Knowledge',
      'description':
          'Exciting inter-house intellectual contest testing student knowledge in science, language, mathematics, and national affairs.',
    },
    {
      'image': 'assets/real/independence-day-celebration.jpg',
      'title': 'Independence Day Celebration',
      'category': 'National Pride',
      'description':
          'Flag hoisting ceremony, patriotic speeches, and cultural performances instilling constitutional values and civic pride in every child.',
    },
  ];

  @override
  void dispose() {
    _studentNameController.dispose();
    _parentNameController.dispose();
    _mobileController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _callSchoolDesk() async {
    final cleanPhone = SchoolDataRepository.schoolPhone.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri.parse('tel:$cleanPhone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showToast('Could not dial: $cleanPhone');
    }
  }

  Future<void> _chatOnWhatsApp() async {
    final cleanPhone = SchoolDataRepository.schoolPhone.replaceAll(RegExp(r'[^0-9]'), '');
    final message = Uri.encodeComponent(
      'Hello Al-Qalam Public School Desk, I would like to inquire about admissions and campus programs.',
    );
    final uri = Uri.parse('https://wa.me/$cleanPhone?text=$message');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showToast('Could not open WhatsApp');
    }
  }

  Future<void> _openCampusMap() async {
    final encodedQuery = Uri.encodeComponent(
      'Al-Qalam Public School, Dr. Fateullah Colony, Near Water Tank, Gulzarbagh, Patna, Bihar 800007',
    );
    final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encodedQuery');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showToast('Could not open Maps');
    }
  }

  void _showToast(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.inter()),
        backgroundColor: AppTheme.forestPrimary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _openImageLightbox(Map<String, String> item) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFFF7F9F6),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Header with Close Button
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: AspectRatio(
                      aspectRatio: 16 / 11,
                      child: Image.asset(
                        item['image']!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppTheme.forestDeep,
                          child: const Center(
                            child: Icon(Icons.image_not_supported, color: Colors.white54, size: 48),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Material(
                      color: Colors.black45,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => Navigator.pop(ctx),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.close, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.forestDeep.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.goldPrimary, width: 1),
                      ),
                      child: Text(
                        item['category'] ?? 'Campus Event',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.goldLight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.forestDeep,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['description']!,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppTheme.textDark,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
        submissionDate: '04-Oct-2026',
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
              height: 190,
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
                      'assets/real/interactive-classroom-session.jpg',
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
                            Colors.black.withValues(alpha: 0.88),
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
                              fontSize: 19,
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
            const SizedBox(height: 16),

            // Quick Desk Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _callSchoolDesk,
                    icon: const Icon(Icons.phone_in_talk, size: 16),
                    label: const Text('Call Desk'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.forestPrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _chatOnWhatsApp,
                    icon: const Icon(Icons.chat_bubble_outline, size: 16),
                    label: const Text('WhatsApp'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _openCampusMap,
                    icon: const Icon(Icons.directions, size: 16),
                    label: const Text('Directions'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.forestDeep,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: AppTheme.forestPrimary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Prestigious Rotary Shiksha Ratna State Honor Card
            InkWell(
              onTap: () => _openImageLightbox(_galleryItems[0]),
              borderRadius: BorderRadius.circular(18),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F3820), Color(0xFF14532D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppTheme.goldPrimary, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.forestDeep.withValues(alpha: 0.2),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.asset(
                              'assets/real/rotary-shiksha-ratna-award.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.goldPrimary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.military_tech, size: 14, color: AppTheme.forestDeep),
                                const SizedBox(width: 4),
                                Text(
                                  'STATE RECOGNITION',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.forestDeep,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.touch_app, size: 12, color: Colors.white70),
                                const SizedBox(width: 4),
                                Text(
                                  'Tap to enlarge',
                                  style: GoogleFonts.inter(fontSize: 10, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rotary Shiksha Ratna Award',
                            style: GoogleFonts.outfit(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Conferred by Hon\'ble Chief Minister Nitish Kumar',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppTheme.goldLight,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Director Kausar Jahan received this prestigious state honor for exemplary grassroots educational service, nurturing foundational excellence and ethical character in young students.',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.85),
                              height: 1.45,
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
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
                    '24/7 Monitored Hallways & Gate',
                    Icons.security_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildFacilityCard(
                    'Smart Learning',
                    'Audio-Visual Screen Classrooms',
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
                    'Moral Ethics & Languages',
                    Icons.menu_book_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildFacilityCard(
                    'Reading Corner',
                    'Foundational Illustrated Books',
                    Icons.local_library_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Real School Activity Gallery
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Campus Moments & Activities',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.forestDeep,
                  ),
                ),
                Text(
                  'Tap to view',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 155,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _galleryItems.length,
                itemBuilder: (ctx, i) {
                  final item = _galleryItems[i];
                  return _buildGalleryCard(item);
                },
              ),
            ),
            const SizedBox(height: 28),

            // Campus Building Landmark Card
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFECEFF1)),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.forestDeep.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/real/school_building.png',
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                            errorBuilder: (_, __, ___) => Container(
                              color: AppTheme.forestTint,
                              child: const Icon(Icons.apartment, size: 48, color: AppTheme.forestPrimary),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppTheme.forestPrimary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Campus Building',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hashmi Manzil • Primary Learning Wing',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.forestDeep,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Loharwa Ghat Lane, Opposite Jashn Palace, Alamganj, Patna. Look for this building with the Al-Qalam board when visiting campus.',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AppTheme.textMuted,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

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

  Widget _buildGalleryCard(Map<String, String> item) {
    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFECEFF1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _openImageLightbox(item),
        borderRadius: BorderRadius.circular(14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                item['image']!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppTheme.forestTint,
                  child: const Icon(Icons.image, color: AppTheme.forestPrimary),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item['title']!,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      item['category'] ?? '',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        color: AppTheme.goldLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
