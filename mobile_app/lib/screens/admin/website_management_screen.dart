import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/school_provider.dart';
import '../../models/gallery_item_model.dart';
import '../../theme/app_theme.dart';

class WebsiteManagementScreen extends StatefulWidget {
  const WebsiteManagementScreen({super.key});

  @override
  State<WebsiteManagementScreen> createState() =>
      _WebsiteManagementScreenState();
}

class _WebsiteManagementScreenState extends State<WebsiteManagementScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Campus',
    'Activities',
    'Classroom',
    'Achievements',
  ];

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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Icon(Icons.add_photo_alternate_rounded,
                  color: AppTheme.forestPrimary),
              const SizedBox(width: 8),
              Text(
                'Add Website Gallery Photo',
                style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ],
          ),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Uploaded photos appear instantly on the school website gallery section.',
                  style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[600]),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Photo Title *',
                    hintText: 'e.g. Science Exhibition 2026',
                    prefixIcon: Icon(Icons.title, size: 18),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: urlController,
                  decoration: const InputDecoration(
                    labelText: 'Image URL or Asset Path *',
                    hintText: 'https://... or /images/...',
                    prefixIcon: Icon(Icons.link, size: 18),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    prefixIcon: Icon(Icons.category, size: 18),
                  ),
                  items: _categories
                      .where((c) => c != 'All')
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setDialogState(() => selectedCategory = val);
                    }
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: tagController,
                  decoration: const InputDecoration(
                    labelText: 'Tag / Badge',
                    hintText: 'e.g. Science Lab, Sports',
                    prefixIcon: Icon(Icons.label_outline, size: 18),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Caption / Description (Optional)',
                    hintText: 'Brief summary of the photograph event...',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel',
                  style: GoogleFonts.inter(color: Colors.grey[700])),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                final src = urlController.text.trim();
                if (title.isEmpty || src.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please provide both title and image URL.')),
                  );
                  return;
                }

                final newItem = SchoolGalleryItem(
                  id: 'gal-${DateTime.now().millisecondsSinceEpoch}',
                  title: title,
                  category: selectedCategory,
                  src: src,
                  tag: tagController.text.trim().isNotEmpty
                      ? tagController.text.trim()
                      : 'Campus',
                  description: descController.text.trim(),
                );

                Provider.of<SchoolProvider>(context, listen: false)
                    .addGalleryPhoto(newItem);

                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Photo "$title" added to website gallery!',
                      style: GoogleFonts.inter(),
                    ),
                    backgroundColor: AppTheme.forestPrimary,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.forestPrimary,
              ),
              child: Text('Upload Photo',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeletePhoto(BuildContext context, SchoolGalleryItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Text('Remove Photo',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: Text(
          'Remove "${item.title}" from the public website gallery?',
          style: GoogleFonts.inter(fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: GoogleFonts.inter()),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<SchoolProvider>(context, listen: false)
                  .deleteGalleryPhoto(item.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Photo removed from website gallery.'),
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

  void _previewImage(BuildContext context, SchoolGalleryItem item) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: item.src.startsWith('http')
                  ? Image.network(
                      item.src,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.broken_image)),
                      ),
                    )
                  : Image.asset(
                      item.src.startsWith('/')
                          ? item.src.substring(1)
                          : item.src,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  if (item.description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: GoogleFonts.inter(
                          fontSize: 12, color: Colors.grey[700]),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 8),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openLiveWebsite() async {
    final uri = Uri.parse('https://alqalampublicschool.vercel.app/gallery');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final school = Provider.of<SchoolProvider>(context);
    final canPop = ModalRoute.of(context)?.canPop ?? false;

    final filteredItems = school.galleryItems.where((item) {
      if (_selectedCategory == 'All') return true;
      return item.category.toLowerCase() == _selectedCategory.toLowerCase();
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F6),
      appBar: canPop
          ? AppBar(
              title: const Text('Website Gallery Management'),
              backgroundColor: AppTheme.forestDeep,
              actions: [
                IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: _openLiveWebsite,
                  tooltip: 'View Live Gallery on Website',
                ),
              ],
            )
          : null,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddPhotoDialog,
        backgroundColor: AppTheme.forestPrimary,
        icon: const Icon(Icons.add_photo_alternate, color: Colors.white),
        label: Text(
          'Add Photo',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
        top: !canPop,
        bottom: true,
        child: Column(
          children: [
            // Header Info & Website Link
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Website Photo Gallery',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.forestDeep,
                          ),
                        ),
                        Text(
                          '${school.galleryItems.length} photos published on live school website',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: _openLiveWebsite,
                    icon: const Icon(Icons.open_in_browser, size: 16),
                    label: const Text('Live Website'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.forestPrimary,
                      textStyle: GoogleFonts.inter(fontSize: 11),
                      side: const BorderSide(color: AppTheme.forestPrimary),
                    ),
                  ),
                ],
              ),
            ),

            // Category Filter Bar
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((cat) {
                    final isSel = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: isSel,
                        selectedColor: AppTheme.forestPrimary,
                        backgroundColor: const Color(0xFFF3F4F6),
                        labelStyle: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSel ? Colors.white : AppTheme.textDark,
                        ),
                        onSelected: (val) {
                          if (val) setState(() => _selectedCategory = cat);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const Divider(height: 1),

            // Gallery Grid
            Expanded(
              child: filteredItems.isEmpty
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
                                Icons.photo_library_outlined,
                                size: 48,
                                color: AppTheme.forestPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No Gallery Photos in "$_selectedCategory"',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.forestDeep,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Tap "+ Add Photo" to publish campus events, awards, or student activities.',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppTheme.textMuted,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: _showAddPhotoDialog,
                              icon: const Icon(Icons.add_photo_alternate,
                                  size: 18),
                              label: const Text('Upload Photo'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.forestPrimary,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.82,
                      ),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];

                        return InkWell(
                          onTap: () => _previewImage(context, item),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: Colors.grey.withValues(alpha: 0.15)),
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
                                // Photo Preview Box
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(16)),
                                          child: item.src.startsWith('http')
                                              ? Image.network(
                                                  item.src,
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (_, __, ___) =>
                                                          Container(
                                                    color: AppTheme.forestTint,
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.image,
                                                        color: AppTheme
                                                            .forestPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Image.asset(
                                                  item.src.startsWith('/')
                                                      ? item.src.substring(1)
                                                      : item.src,
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (_, __, ___) =>
                                                          Container(
                                                    color: AppTheme.forestTint,
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.image,
                                                        color: AppTheme
                                                            .forestPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 6,
                                        right: 6,
                                        child: CircleAvatar(
                                          radius: 14,
                                          backgroundColor: Colors.black54,
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: const Icon(Icons.delete,
                                                color: Colors.white, size: 14),
                                            onPressed: () =>
                                                _confirmDeletePhoto(
                                                    context, item),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 6,
                                        left: 6,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withValues(alpha: 0.6),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            item.category,
                                            style: GoogleFonts.inter(
                                              fontSize: 9,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Title Details
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    item.title,
                                    style: GoogleFonts.outfit(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.forestDeep,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
