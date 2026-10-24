class TeacherModel {
  final String id;
  final String name;
  final String subject;
  final String classAssigned;
  final String phone;
  final String email;
  final String qualification;
  final bool isActive;

  const TeacherModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.classAssigned,
    required this.phone,
    required this.email,
    this.qualification = 'B.Ed / Trained Graduate',
    this.isActive = true,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'subject': subject,
        'class_assigned': classAssigned,
        'phone': phone,
        'email': email,
        'qualification': qualification,
        'is_active': isActive,
      };

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? json['full_name'] as String? ?? '',
        subject: json['subject'] as String? ??
            json['designation'] as String? ??
            'Primary Teacher',
        classAssigned: json['class_assigned'] as String? ?? 'All Classes',
        phone: json['phone'] as String? ?? '',
        email: json['email'] as String? ?? '',
        qualification: json['qualification'] as String? ?? 'Trained Teacher',
        isActive: json['is_active'] as bool? ?? true,
      );
}
