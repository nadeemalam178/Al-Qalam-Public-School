-- ==============================================================================
-- Al-Qalam Public School (Gulzarbagh, Patna)
-- Comprehensive Supabase Seed Data & Single-Source-of-Truth Demonstration Script
-- ==============================================================================

-- 1. Insert Active Academic Year
INSERT INTO public.academic_years (id, name, start_date, end_date, is_current)
VALUES
  ('a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', '2026-2027', '2026-04-01', '2027-03-31', true)
ON CONFLICT (name) DO NOTHING;

-- 2. Insert Core Classes
INSERT INTO public.classes (id, name, code, grade_level) VALUES
  ('c1000000-0000-0000-0000-000000000000', 'Pre-Nursery', 'PRE-NUR', 0),
  ('c2000000-0000-0000-0000-000000000000', 'Nursery', 'NUR', 1),
  ('c3000000-0000-0000-0000-000000000000', 'LKG', 'LKG', 2),
  ('c4000000-0000-0000-0000-000000000000', 'UKG', 'UKG', 3),
  ('c5000000-0000-0000-0000-000000000000', 'Class 1', 'CLS-1', 4),
  ('c6000000-0000-0000-0000-000000000000', 'Class 2', 'CLS-2', 5),
  ('c7000000-0000-0000-0000-000000000000', 'Class 3', 'CLS-3', 6),
  ('c8000000-0000-0000-0000-000000000000', 'Class 4', 'CLS-4', 7),
  ('c9000000-0000-0000-0000-000000000000', 'Class 5', 'CLS-5', 8)
ON CONFLICT (code) DO NOTHING;

-- 3. Insert Sections
INSERT INTO public.sections (id, class_id, name) VALUES
  ('s7000000-0000-0000-0000-000000000001', 'c7000000-0000-0000-0000-000000000000', 'A'),
  ('s7000000-0000-0000-0000-000000000002', 'c7000000-0000-0000-0000-000000000000', 'B')
ON CONFLICT (class_id, name) DO NOTHING;

-- 4. Insert Subjects for Class 3
INSERT INTO public.subjects (id, class_id, name, code) VALUES
  ('sub10000-0000-0000-0000-000000000001', 'c7000000-0000-0000-0000-000000000000', 'English Language', 'ENG-3'),
  ('sub10000-0000-0000-0000-000000000002', 'c7000000-0000-0000-0000-000000000000', 'Mathematics', 'MATH-3'),
  ('sub10000-0000-0000-0000-000000000003', 'c7000000-0000-0000-0000-000000000000', 'Science & EVS', 'EVS-3'),
  ('sub10000-0000-0000-0000-000000000004', 'c7000000-0000-0000-0000-000000000000', 'Hindi Reader', 'HIN-3'),
  ('sub10000-0000-0000-0000-000000000005', 'c7000000-0000-0000-0000-000000000000', 'Urdu & Arabic Calligraphy', 'URD-3'),
  ('sub10000-0000-0000-0000-000000000006', 'c7000000-0000-0000-0000-000000000000', 'Deeniyat & Ethics', 'DEEN-3')
ON CONFLICT (class_id, name) DO NOTHING;

-- 5. Insert Core Demo Profiles (Pre-seeded with known UUIDs)
-- Note: When users sign up via Supabase Auth, trigger handles their UUID.
-- These UUIDs provide immediate offline/online demo alignment.
INSERT INTO public.profiles (id, role, full_name, email, phone, designation) VALUES
  ('11111111-1111-1111-1111-111111111111', 'admin', 'Kausar Jahan', 'director@alqalam.edu.in', '+91 93084 62418', 'Director & Campus Administrator'),
  ('22222222-2222-2222-2222-222222222222', 'teacher', 'Farzana Begum', 'farzana.t@alqalam.edu.in', '+91 94310 56782', 'Senior Primary Teacher (Maths & EVS)'),
  ('33333333-3333-3333-3333-333333333333', 'guardian', 'Mohd. Tariq Alam', 'tariq.alam@gmail.com', '+91 98350 12450', 'Parent of Zaid & Zoya Alam')
ON CONFLICT (id) DO UPDATE SET
  full_name = EXCLUDED.full_name,
  role = EXCLUDED.role,
  phone = EXCLUDED.phone,
  designation = EXCLUDED.designation;

-- 6. Insert Teacher Faculty Record
INSERT INTO public.teachers (id, profile_id, employee_id, qualification, joining_date, status) VALUES
  ('t2000000-0000-0000-0000-000000000001', '22222222-2222-2222-2222-222222222222', 'AQPS-T-101', 'M.Sc., B.Ed. (Mathematics)', '2019-07-01', 'active')
ON CONFLICT (profile_id) DO NOTHING;

-- 7. Assign Teacher to Class 3-A
INSERT INTO public.teacher_classes (id, teacher_id, class_id, section_id, subject_id, academic_year_id) VALUES
  ('tc000000-0000-0000-0000-000000000001', 't2000000-0000-0000-0000-000000000001', 'c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', 'sub10000-0000-0000-0000-000000000002', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d')
ON CONFLICT (id) DO NOTHING;

-- 8. Insert Students (Including Multi-Child Siblings for Tariq Alam)
INSERT INTO public.students (id, admission_no, name, class_id, section_id, grade, section, roll_no, father_name, mother_name, phone, address, dob, blood_group, attendance_rate, pending_fees)
VALUES
  ('stu00000-0000-0000-0000-000000000001', 'AQPS-2024-082', 'Zaid Alam', 'c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', 'Class 3', 'A', 12, 'Mohd. Tariq Alam', 'Shabana Khatoon', '+91 98350 12450', 'Gulzarbagh Main Bazar, Patna - 800007', '2017-08-14', 'B+', 94.2, 1200.0),
  ('stu00000-0000-0000-0000-000000000002', 'AQPS-2025-031', 'Zoya Alam', 'c5000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', 'Class 1', 'A', 6, 'Mohd. Tariq Alam', 'Shabana Khatoon', '+91 98350 12450', 'Gulzarbagh Main Bazar, Patna - 800007', '2019-11-20', 'O+', 98.0, 0.0),
  ('stu00000-0000-0000-0000-000000000003', 'AQPS-2024-089', 'Aisha Fatima', 'c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', 'Class 3', 'A', 15, 'Syed Arshad Ali', 'Nusrat Parveen', '+91 97092 33411', 'Near Old Water Tank, Gulzarbagh, Patna', '2018-01-05', 'O+', 97.5, 0.0),
  ('stu00000-0000-0000-0000-000000000004', 'AQPS-2024-094', 'Rayan Siddiqui', 'c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', 'Class 3', 'A', 18, 'Imran Siddiqui', 'Nazia Begum', '+91 99341 88200', 'Fateullah Colony Road #3, Gulzarbagh', '2017-10-22', 'A+', 88.0, 2400.0),
  ('stu00000-0000-0000-0000-000000000005', 'AQPS-2024-102', 'Maryam Khan', 'c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', 'Class 3', 'A', 21, 'Asif Khan', 'Sultana Khan', '+91 91234 56789', 'Sultanganj Crossing, Patna City', '2018-03-12', 'AB+', 92.0, 0.0),
  ('stu00000-0000-0000-0000-000000000006', 'AQPS-2024-110', 'Hamza Tariq', 'c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', 'Class 3', 'A', 24, 'Tariq Anwar', 'Farida Bano', '+91 93345 67890', 'Bari Patan Devi Road, Patna', '2017-06-19', 'O-', 91.5, 1200.0),
  ('stu00000-0000-0000-0000-000000000007', 'AQPS-2025-014', 'Zainab Parveen', 'c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', 'Class 3', 'A', 28, 'Kamran Haider', 'Salma Khatoon', '+91 98012 34567', 'Ranipur, Patna City', '2017-12-02', 'B-', 96.0, 0.0)
ON CONFLICT (admission_no) DO NOTHING;

-- 9. Link Guardian to Children (Demonstrating Multi-Child Support)
INSERT INTO public.guardian_students (guardian_id, student_id, relationship, is_primary) VALUES
  ('33333333-3333-3333-3333-333333333333', 'stu00000-0000-0000-0000-000000000001', 'Father', true),
  ('33333333-3333-3333-3333-333333333333', 'stu00000-0000-0000-0000-000000000002', 'Father', true)
ON CONFLICT (guardian_id, student_id) DO NOTHING;

-- 10. Insert Attendance Records
INSERT INTO public.attendance (student_id, class_id, section_id, date, status, remarks, recorded_by) VALUES
  ('stu00000-0000-0000-0000-000000000001', 'c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', CURRENT_DATE, 'present', 'On time', '22222222-2222-2222-2222-222222222222'),
  ('stu00000-0000-0000-0000-000000000003', 'c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', CURRENT_DATE, 'present', 'Active in class', '22222222-2222-2222-2222-222222222222'),
  ('stu00000-0000-0000-0000-000000000004', 'c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', CURRENT_DATE, 'late', 'Bus delayed by 10 mins', '22222222-2222-2222-2222-222222222222'),
  ('stu00000-0000-0000-0000-000000000005', 'c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', CURRENT_DATE, 'present', 'Participated in Math quiz', '22222222-2222-2222-2222-222222222222'),
  ('stu00000-0000-0000-0000-000000000006', 'c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', CURRENT_DATE, 'absent', 'Medical leave informed', '22222222-2222-2222-2222-222222222222')
ON CONFLICT (student_id, date) DO NOTHING;

-- 11. Insert Homework
INSERT INTO public.homework (grade, subject, title, description, due_date, is_completed, assigned_by) VALUES
  ('Class 3', 'Mathematics', 'Multiplication Tables & Word Problems', 'Complete Exercise 4.2 Questions 1 to 8 on Page 45 of Mathematics Primer.', CURRENT_DATE + INTERVAL '1 day', false, '22222222-2222-2222-2222-222222222222'),
  ('Class 3', 'Science & EVS', 'Parts of a Plant Diagram', 'Draw, label, and colour the parts of a flowering plant in your project notebook.', CURRENT_DATE + INTERVAL '1 day', true, '22222222-2222-2222-2222-222222222222'),
  ('Class 3', 'English Language', 'Chapter 4: The Golden Feather', 'Read Chapter 4 aloud twice and write difficult vocabulary words with meanings.', CURRENT_DATE + INTERVAL '2 days', false, '22222222-2222-2222-2222-222222222222'),
  ('Class 3', 'Urdu & Arabic Calligraphy', 'Calligraphy & Verse Memorization', 'Write one full page of neat cursive calligraphy and learn Surah Al-Alaq verses 1-5.', CURRENT_DATE + INTERVAL '2 days', false, '22222222-2222-2222-2222-222222222222');

-- 12. Insert Daily Diary Entries
INSERT INTO public.diary (class_id, section_id, date, title, entry, created_by) VALUES
  ('c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', CURRENT_DATE, 'Class 3-A Daily Progress', 'Covered Chapter 4 fractions intro in Math. EVS plant drawing practice in 3rd period. Students behaved exceptionally well during Arabic recitation.', '22222222-2222-2222-2222-222222222222');

-- 13. Insert Exams & Term Assessments
INSERT INTO public.exams (id, academic_year_id, title, term, start_date, end_date) VALUES
  ('ex000000-0000-0000-0000-000000000001', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'First Term Assessment 2026', 'Term 1', '2026-09-15', '2026-09-24')
ON CONFLICT (id) DO NOTHING;

-- 14. Insert Marks for Zaid Alam (Class 3-A)
INSERT INTO public.marks (exam_id, student_id, subject_id, subject_name, marks_obtained, max_marks, grade, remarks, recorded_by) VALUES
  ('ex000000-0000-0000-0000-000000000001', 'stu00000-0000-0000-0000-000000000001', 'sub10000-0000-0000-0000-000000000001', 'English Language', 92.0, 100.0, 'A+', 'Fluent reading and excellent penmanship', '22222222-2222-2222-2222-222222222222'),
  ('ex000000-0000-0000-0000-000000000001', 'stu00000-0000-0000-0000-000000000001', 'sub10000-0000-0000-0000-000000000002', 'Mathematics', 96.0, 100.0, 'A+', 'Outstanding problem-solving speed', '22222222-2222-2222-2222-222222222222'),
  ('ex000000-0000-0000-0000-000000000001', 'stu00000-0000-0000-0000-000000000001', 'sub10000-0000-0000-0000-000000000003', 'Science & EVS', 89.0, 100.0, 'A', 'Very attentive and curious in experiments', '22222222-2222-2222-2222-222222222222'),
  ('ex000000-0000-0000-0000-000000000001', 'stu00000-0000-0000-0000-000000000004', 'Hindi Reader', 88.0, 100.0, 'A', 'Good spelling and neat cursive script', '22222222-2222-2222-2222-222222222222'),
  ('ex000000-0000-0000-0000-000000000001', 'stu00000-0000-0000-0000-000000000005', 'Urdu & Arabic Calligraphy', 94.0, 100.0, 'A+', 'Mastery over Arabic phonetics', '22222222-2222-2222-2222-222222222222'),
  ('ex000000-0000-0000-0000-000000000001', 'stu00000-0000-0000-0000-000000000006', 'Deeniyat & Ethics', 98.0, 100.0, 'A+', 'Exemplary conduct and Surah memorization', '22222222-2222-2222-2222-222222222222')
ON CONFLICT (exam_id, student_id, subject_name) DO NOTHING;

-- 15. Insert Fee Invoices
INSERT INTO public.fee_invoices (id, invoice_no, student_id, academic_year_id, fee_head, amount_due, due_date, status) VALUES
  ('inv00000-0000-0000-0000-000000000001', 'INV-2026-SEP-082', 'stu00000-0000-0000-0000-000000000001', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Monthly Tuition - Sep 2026', 1200.0, '2026-10-10', 'pending'),
  ('inv00000-0000-0000-0000-000000000002', 'INV-2026-AUG-082', 'stu00000-0000-0000-0000-000000000001', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Monthly Tuition - Aug 2026', 1200.0, '2026-08-10', 'paid'),
  ('inv00000-0000-0000-0000-000000000003', 'INV-2026-SEP-089', 'stu00000-0000-0000-0000-000000000003', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', 'Monthly Tuition - Sep 2026', 1200.0, '2026-10-10', 'paid')
ON CONFLICT (invoice_no) DO NOTHING;

-- 16. Insert Fee Payments
INSERT INTO public.fee_payments (id, receipt_no, invoice_id, amount, payment_mode, transaction_reference, recorded_by, notes) VALUES
  ('pay00000-0000-0000-0000-000000000001', 'REC-AQPS-2026-7841', 'inv00000-0000-0000-0000-000000000002', 1200.0, 'Cash', 'COUNTER-CASH-7841', '11111111-1111-1111-1111-111111111111', 'Paid in full at campus counter'),
  ('pay00000-0000-0000-0000-000000000002', 'REC-AQPS-2026-7842', 'inv00000-0000-0000-0000-000000000003', 1200.0, 'UPI', 'UPI-98341908-AQPS', '11111111-1111-1111-1111-111111111111', 'Paid online via UPI transfer')
ON CONFLICT (receipt_no) DO NOTHING;

-- 17. Insert Shared Notices & Circulars (Website + Mobile)
INSERT INTO public.notices (title, content, category, target_role, publish_date, is_active, created_by) VALUES
  (
    'Parent-Teacher Meeting (PTM) Scheduled for Oct 5',
    'Dear Parents, The First Term Assessment PTM is scheduled for Saturday, 5th October 2026 from 9:00 AM to 1:00 PM. Kindly collect your ward''s progress report and interact with subject educators.',
    'Academic',
    'all',
    NOW() - INTERVAL '1 day',
    true,
    '11111111-1111-1111-1111-111111111111'
  ),
  (
    'Admissions Open for Session 2026-27 (Pre-Nursery to Class 5)',
    'Admissions for the upcoming academic session are now officially open. Collect registration forms from campus administrative office or apply online directly through our website.',
    'Admissions',
    'all',
    NOW() - INTERVAL '3 days',
    true,
    '11111111-1111-1111-1111-111111111111'
  ),
  (
    'Annual Science & Art Exhibition 2026',
    'Students of Class 1 to 5 are requested to finalize their science working models and painting entries under faculty guidance by next Friday.',
    'Academic',
    'all',
    NOW() - INTERVAL '5 days',
    true,
    '11111111-1111-1111-1111-111111111111'
  ),
  (
    'Winter School Uniform Transition Circular',
    'All parents are notified that the transition to winter uniforms will commence on 1st November 2026. Blazers and sweaters are available at the school counter.',
    'General',
    'guardian',
    NOW() - INTERVAL '7 days',
    true,
    '11111111-1111-1111-1111-111111111111'
  );

-- 18. Insert Admission Enquiries (Directly matches website form entries)
INSERT INTO public.admission_enquiries (reference_no, parent_name, student_name, grade_applying, phone, email, message, status) VALUES
  ('AQPS-908121', 'Zubair Ahmed', 'Faizan Zubair', 'Class 1', '+91 98351 90812', 'zubair.ahmed@gmail.com', 'Inquiring about syllabus, bus transport facility from Patna City, and admission procedure.', 'pending'),
  ('AQPS-876542', 'Dr. Shahla Bano', 'Hafsa Farooqui', 'Lower Kindergarten (LKG)', '+91 94312 87654', 'shahla.bano@yahoo.co.in', 'Looking for child admission in junior KG section. Please share school prospectus.', 'contacted'),
  ('AQPS-127893', 'Md. Shahnawaz', 'Ayaan Shahnawaz', 'Nursery / Pre-School', '+91 99340 12789', 'shahnawaz.patna@outlook.com', 'Wanted to know regarding age criteria for Pre-Nursery session 2026-27.', 'pending')
ON CONFLICT (reference_no) DO NOTHING;

-- 19. Insert Class 3-A Weekly Timetable
INSERT INTO public.timetables (class_id, section_id, grade, section, subject, day_of_week, day_name, period_no, start_time, end_time, room_no) VALUES
  ('c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', 'Class 3', 'A', 'Quran Recitation & Moral Science', 1, 'Monday', 1, '08:00 AM', '08:45 AM', 'Room 301'),
  ('c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', 'Class 3', 'A', 'English Grammar & Reader', 1, 'Monday', 2, '08:45 AM', '09:30 AM', 'Room 301'),
  ('c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', 'Class 3', 'A', 'Mathematics & Mental Arithmetic', 1, 'Monday', 3, '09:45 AM', '10:30 AM', 'Room 301'),
  ('c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', 'Class 3', 'A', 'Science & Environmental Studies', 1, 'Monday', 4, '10:30 AM', '11:15 AM', 'Room 301'),
  ('c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', 'Class 3', 'A', 'Urdu / Hindi Language Studies', 1, 'Monday', 5, '11:30 AM', '12:15 PM', 'Room 301'),
  ('c7000000-0000-0000-0000-000000000000', 's7000000-0000-0000-0000-000000000001', 'Class 3', 'A', 'Art, Drawing & Handwriting Drill', 1, 'Monday', 6, '12:15 PM', '01:00 PM', 'Room 301');

-- 20. Insert Initial Audit Log Entries
INSERT INTO public.audit_logs (actor_id, action, entity_type, entity_id, metadata) VALUES
  ('11111111-1111-1111-1111-111111111111', 'INITIALIZE_SYSTEM', 'system', 'a1b2c3d4-e5f6-7a8b-9c0d-1e2f3a4b5c6d', '{"message": "School academic session 2026-2027 launched with unified database."}'::jsonb),
  ('11111111-1111-1111-1111-111111111111', 'FEE_PAYMENT_RECORDED', 'fee_payments', 'pay00000-0000-0000-0000-000000000001', '{"receipt_no": "REC-AQPS-2026-7841", "amount": 1200.0, "student": "Zaid Alam"}'::jsonb),
  ('22222222-2222-2222-2222-222222222222', 'ATTENDANCE_MARKED', 'attendance', 'stu00000-0000-0000-0000-000000000001', '{"class": "Class 3-A", "present_count": 5, "late_count": 1, "absent_count": 1}'::jsonb);
