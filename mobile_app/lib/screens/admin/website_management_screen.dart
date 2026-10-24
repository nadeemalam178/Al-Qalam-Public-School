import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/school_provider.dart';
import '../../models/gallery_item_model.dart';
import '../../models/notice_model.dart';
import '../../theme/app_theme.dart';
import 'post_notice_screen.dart';

class WebsiteManagementScreen extends StatefulWidget {
  const WebsiteManagementScreen({super.key});

  @override
  State<WebsiteManagementScreen> createState() => _WebsiteManagementScreenState();
}

class _WebsiteManagementScreenState extends State<WebsiteManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAddPhotoDialog() {
    final titleController = TextEditingController();
    final urlController = TextEditingController();
    final tagController = TextEditingController(text: 'Campus Life');
    final descController = TextEditingController();
    String selectedCategory = 'Activities';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(Icons.add_photo_alternate_rounded,
                  color: AppTheme.forestPrimary),
              const SizedBox(width: 8),
              Text(
                'Add Photo to Website',
                style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This photo will be displayed live on the school website gallery.',
                  style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textMuted),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Photo Title *',
                    hintText: 'e.g., Annual Science Exhibition 2026',
                    prefixIcon: Icon(Icons.title_rounded),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Category *',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Achievements', child: Text('Achievements')),
                    DropdownMenuItem(value: 'Activities', child: Text('Activities')),
                    DropdownMenuItem(value: 'Classroom', child: Text('Classroom')),
                    DropdownMenuItem(value: 'Events', child: Text('Events')),
                    DropdownMenuItem(value: 'Campus', child: Text('Campus')),
                    DropdownMenuItem(value: 'Facilities', child: Text('Facilities')),
                  ],
                  onChanged: (val) {
                    if (val != null) setDialogState(() => selectedCategory = val);
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: urlController,
                  decoration: const InputDecoration(
                    labelText: 'Image URL or Path *',
                    hintText: 'https://... or /images/school/...',
                    prefixIcon: Icon(Icons.link_rounded),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: tagController,
                  decoration: const InputDecoration(
                    labelText: 'Tag / Badge',
                    hintText: 'e.g., State Honor, Science Fair',
                    prefixIcon: Icon(Icons.label_outline_rounded),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Short Description (Optional)',
                    hintText: 'Brief details about this event or milestone...',
                    prefixIcon: Icon(Icons.description_outlined),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty ||
                    urlController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter title and image URL.')),
                  );
                  return;
                }

                final school = Provider.of<SchoolProvider>(context, listen: false);
                final newPhoto = SchoolGalleryItem(
                  id: 'gal-${DateTime.now().millisecondsSinceEpoch}',
                  title: titleController.text.trim(),
                  category: selectedCategory,
                  src: urlController.text.trim(),
                  tag: tagController.text.trim().isEmpty
                      ? 'Campus Life'
                      : tagController.text.trim(),
                  description: descController.text.trim(),
                );

                school.addGalleryPhoto(newPhoto);
                Navigator.pop(ctx);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Photo published! Live on website gallery.',
                      style: GoogleFonts.inter(),
                    ),
                    backgroundColor: AppTheme.forestPrimary,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.forestPrimary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Publish to Website'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeletePhoto(SchoolGalleryItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Delete from Website Gallery?'),
        content: Text(
          'Are you sure you want to remove "${item.title}" from the live school website gallery?',
          style: GoogleFonts.inter(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final school = Provider.of<SchoolProvider>(context, listen: false);
              school.deleteGalleryPhoto(item.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Photo removed from website gallery.')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.danger),
            child: const Text('Delete Photo', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteNotice(SchoolNotice notice) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Remove Notice from Website?'),
        content: Text(
          'Are you sure you want to remove "${notice.title}" from the live website notice board?',
          style: GoogleFonts.inter(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final school = Provider.of<SchoolProvider>(context, listen: false);
              school.deleteSchoolNotice(notice.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notice removed from website and app.')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.danger),
            child: const Text('Delete Notice', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _openLiveWebsite() async {
    final uri = Uri.parse('https://alqalampublicschool.vercel.app');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final school = Provider.of<SchoolProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Website Management (CMS)',
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
              'Live sync with alqalampublicschool.vercel.app',
              style: GoogleFonts.inter(fontSize: 11, color: AppTheme.goldLight),
            ),
          ],
        ),
        backgroundColor: AppTheme.forestDeep,
        actions: [
          IconButton(
            tooltip: 'Preview Live Website',
            icon: const Icon(Icons.open_in_browser_rounded),
            onPressed: _openLiveWebsite,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.goldPrimary,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: [
            Tab(
              icon: const Icon(Icons.photo_library_outlined, size: 18),
              text: 'Gallery (${school.galleryItems.length})',
            ),
            Tab(
              icon: const Icon(Icons.campaign_outlined, size: 18),
              text: 'Notices (${school.notices.length})',
            ),
            Tab(
              icon: const Icon(Icons.how_to_reg_outlined, size: 18),
              text: 'Inquiries (${school.inquiries.length})',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // -------------------------------------------------------------------
          // TAB 1: PHOTO GALLERY
          // -------------------------------------------------------------------
          _buildGalleryTab(school),

          // -------------------------------------------------------------------
          // TAB 2: LIVE NOTICES
          // -------------------------------------------------------------------
          _buildNoticesTab(school),

          // -------------------------------------------------------------------
          // TAB 3: ADMISSION INQUIRIES
          // -------------------------------------------------------------------
          _buildInquiriesTab(school),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton.extended(
              onPressed: _showAddPhotoDialog,
              backgroundColor: AppTheme.forestPrimary,
              icon: const Icon(Icons.add_a_photo_rounded, color: Colors.white),
              label: Text(
                'Add Photo',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          : null,
    );
  }

  Widget _buildGalleryTab(SchoolProvider school) {
    final photos = school.galleryItems;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: AppTheme.forestTint,
          child: Row(
            children: [
              const Icon(Icons.cloud_done_rounded,
                  color: AppTheme.forestPrimary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Photos added here appear instantly on the website /gallery page.',
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppTheme.forestDeep,
                      fontWeight: FontWeight.w500),
                ),
              ),
              OutlinedButton.icon(
                onPressed: _showAddPhotoDialog,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.forestPrimary,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: photos.isEmpty
              ? Center(
                  child: Text(
                    'No photos uploaded yet.\nTap "Add Photo" to publish.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(color: AppTheme.textMuted),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: photos.length,
                  itemBuilder: (ctx, idx) {
                    final p = photos[idx];
                    return Card(
                      elevation: 1.5,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: 75,
                                height: 75,
                                color: Colors.stone.shade200,
                                child: p.src.startsWith('http')
                                    ? Image.network(
                                        p.src,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => const Icon(
                                            Icons.image,
                                            color: AppTheme.textMuted),
                                      )
                                    : Image.asset(
                                        p.src.startsWith('/')
                                            ? 'assets' + p.src
                                            : p.src,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => const Icon(
                                            Icons.image,
                                            color: AppTheme.textMuted),
                                      ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppTheme.forestPrimary
                                              .withValues(alpha: 0.12),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          p.category,
                                          style: GoogleFonts.inter(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.forestPrimary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppTheme.goldPrimary
                                              .withValues(alpha: 0.15),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          p.tag,
                                          style: GoogleFonts.inter(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.goldDark,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    p.title,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (p.description.isNotEmpty) ...[
                                    const SizedBox(height: 3),
                                    Text(
                                      p.description,
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        color: AppTheme.textMuted,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded,
                                  color: AppTheme.danger, size: 22),
                              tooltip: 'Delete from Website',
                              onPressed: () => _confirmDeletePhoto(p),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildNoticesTab(SchoolProvider school) {
    final notices = school.notices;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: AppTheme.forestTint,
          child: Row(
            children: [
              const Icon(Icons.campaign_rounded,
                  color: AppTheme.forestPrimary, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Notices published here sync live to Website and Parent Mobile Apps.',
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppTheme.forestDeep,
                      fontWeight: FontWeight.w500),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PostNoticeScreen()),
                ),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Broadcast'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.forestPrimary,
                  foregroundColor: Colors.white,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: notices.isEmpty
              ? Center(
                  child: Text(
                    'No active notices.',
                    style: GoogleFonts.inter(color: AppTheme.textMuted),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: notices.length,
                  itemBuilder: (ctx, idx) {
                    final n = notices[idx];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppTheme.forestPrimary
                                        .withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    n.category,
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.forestPrimary,
                                    ),
                                  ),
                                ),
                                if (n.isImportant) ...[
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'URGENT',
                                      style: GoogleFonts.inter(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                                const Spacer(),
                                Text(
                                  n.date,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: AppTheme.textMuted,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline_rounded,
                                      color: AppTheme.danger, size: 20),
                                  tooltip: 'Delete Notice',
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () => _confirmDeleteNotice(n),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              n.title,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              n.summary,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppTheme.textMuted,
                                height: 1.35,
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
    );
  }

  Widget _buildInquiriesTab(SchoolProvider school) {
    final inquiries = school.inquiries;

    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: inquiries.length,
      itemBuilder: (ctx, idx) {
        final inq = inquiries[idx];
        Color statusColor;
        if (inq.status == 'New Enquiry' || inq.status == 'pending') {
          statusColor = AppTheme.goldDark;
        } else if (inq.status == 'Contacted' || inq.status == 'contacted') {
          statusColor = Colors.blue;
        } else {
          statusColor = AppTheme.forestPrimary;
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      inq.referenceId,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textMuted,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        inq.status,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${inq.studentName} (${inq.grade})',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Parent: ${inq.parentName} • Contact: ${inq.mobile}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
                if (inq.message.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.stone.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '"${inq.message}"',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: Colors.stone.shade700,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.phone_in_talk_rounded, size: 16),
                      label: const Text('Call'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.forestPrimary,
                        visualDensity: VisualDensity.compact,
                      ),
                      onPressed: () async {
                        final phoneUri = Uri.parse('tel:${inq.mobile}');
                        if (await canLaunchUrl(phoneUri)) {
                          await launchUrl(phoneUri);
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.chat_bubble_outline_rounded,
                          size: 16),
                      label: const Text('WhatsApp'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF25D366),
                        visualDensity: VisualDensity.compact,
                      ),
                      onPressed: () async {
                        final clean =
                            inq.mobile.replaceAll(RegExp(r'\D'), '');
                        final waUri = Uri.parse(
                            'https://wa.me/91$clean?text=Namaste%20${inq.parentName},%20Greetings%20from%20Al-Qalam%20Public%20School%20Patna.');
                        if (await canLaunchUrl(waUri)) {
                          await launchUrl(waUri,
                              mode: LaunchMode.externalApplication);
                        }
                      },
                    ),
                    const Spacer(),
                    PopupMenuButton<String>(
                      tooltip: 'Change Status',
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.forestPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text('Update',
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.forestPrimary)),
                            const Icon(Icons.arrow_drop_down,
                                size: 18, color: AppTheme.forestPrimary),
                          ],
                        ),
                      ),
                      onSelected: (newStatus) {
                        school.updateInquiryStatus(inq.id, newStatus);
                      },
                      itemBuilder: (ctx) => [
                        const PopupMenuItem(
                            value: 'New Enquiry', child: Text('New Enquiry')),
                        const PopupMenuItem(
                            value: 'Contacted', child: Text('Contacted')),
                        const PopupMenuItem(
                            value: 'Enrolled / Admitted',
                            child: Text('Enrolled / Admitted')),
                      ],
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
