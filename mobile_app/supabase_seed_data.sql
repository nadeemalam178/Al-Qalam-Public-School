-- ==============================================================================
-- Al-Qalam Public School - Supabase Dummy / Demo Data Population Script
-- Run this in your Supabase Dashboard: SQL Editor -> New Query -> Run
-- ==============================================================================

-- 1. Insert Core Classes
INSERT INTO public.classes (name, code, grade_level) VALUES
  ('Pre-Nursery', 'PRE-NUR', 0),
  ('Nursery', 'NUR', 1),
  ('LKG', 'LKG', 2),
  ('UKG', 'UKG', 3),
  ('Class 1', 'CLS-1', 4),
  ('Class 2', 'CLS-2', 5),
  ('Class 3', 'CLS-3', 6),
  ('Class 4', 'CLS-4', 7),
  ('Class 5', 'CLS-5', 8)
ON CONFLICT (code) DO NOTHING;

-- 2. Insert Sample Students
INSERT INTO public.students (admission_no, name, grade, section, roll_no, father_name, mother_name, phone, address, dob, blood_group, attendance_rate, pending_fees)
VALUES
  ('AQPS-2024-082', 'Zaid Alam', 'Class 3', 'A', 12, 'Mohd. Tariq Alam', 'Shabana Khatoon', '+91 98350 12450', 'Gulzarbagh Main Bazar, Patna - 800007', '2017-08-14', 'B+', 94.2, 1200.0),
  ('AQPS-2024-089', 'Aisha Fatima', 'Class 3', 'A', 15, 'Syed Arshad Ali', 'Nusrat Parveen', '+91 97092 33411', 'Near Old Water Tank, Gulzarbagh, Patna', '2018-01-05', 'O+', 97.5, 0.0),
  ('AQPS-2024-094', 'Rayan Siddiqui', 'Class 3', 'A', 18, 'Imran Siddiqui', 'Nazia Begum', '+91 99341 88200', 'Fateullah Colony Road #3, Gulzarbagh', '2017-10-22', 'A+', 88.0, 2400.0),
  ('AQPS-2024-102', 'Maryam Khan', 'Class 3', 'A', 21, 'Asif Khan', 'Sultana Khan', '+91 91234 56789', 'Sultanganj Crossing, Patna City', '2018-03-12', 'AB+', 92.0, 0.0),
  ('AQPS-2024-110', 'Hamza Tariq', 'Class 3', 'A', 24, 'Tariq Anwar', 'Farida Bano', '+91 93345 67890', 'Bari Patan Devi Road, Patna', '2017-06-19', 'O-', 91.5, 1200.0),
  ('AQPS-2025-014', 'Zainab Parveen', 'Class 3', 'A', 28, 'Kamran Haider', 'Salma Khatoon', '+91 98012 34567', 'Ranipur, Patna City', '2017-12-02', 'B-', 96.0, 0.0)
ON CONFLICT (admission_no) DO NOTHING;

-- 3. Insert Sample Notices & Circulars
INSERT INTO public.notices (title, content, category, target_role, publish_date)
VALUES
  (
    'Parent-Teacher Meeting (PTM) Scheduled for Oct 5',
    'Dear Parents, The First Term Assessment PTM is scheduled for Saturday, 5th October 2026 from 9:00 AM to 1:00 PM. Kindly collect your ward''s progress report.',
    'Academic',
    'all',
    NOW() - INTERVAL '1 day'
  ),
  (
    'Admissions Open for Session 2026-27 (Pre-Nursery to Class 5)',
    'Admissions for the upcoming academic session are now officially open. Collect registration forms from campus administrative office or apply online.',
    'Admission',
    'all',
    NOW() - INTERVAL '3 days'
  ),
  (
    'Annual Science & Art Exhibition 2026',
    'Students of Class 1 to 5 are requested to finalize their science working models and painting entries under faculty guidance by next Friday.',
    'Event',
    'all',
    NOW() - INTERVAL '5 days'
  ),
  (
    'Winter School Uniform Transition Circular',
    'All parents are notified that the transition to winter uniforms will commence on 1st November 2026. Blazers and sweaters are available at the school counter.',
    'General',
    'guardian',
    NOW() - INTERVAL '7 days'
  );

-- 4. Insert Sample Homework
INSERT INTO public.homework (grade, subject, title, description, due_date, is_completed)
VALUES
  ('Class 3', 'Mathematics', 'Multiplication Tables & Word Problems', 'Complete Exercise 4.2 Questions 1 to 8 on Page 45 of Mathematics Primer.', CURRENT_DATE + INTERVAL '1 day', false),
  ('Class 3', 'Science & EVS', 'Parts of a Plant Diagram', 'Draw, label, and colour the parts of a flowering plant in your project notebook.', CURRENT_DATE + INTERVAL '1 day', true),
  ('Class 3', 'English Reader', 'Chapter 4: The Golden Feather', 'Read Chapter 4 aloud twice and write difficult vocabulary words with meanings.', CURRENT_DATE + INTERVAL '2 days', false),
  ('Class 3', 'Urdu / Hindi', 'Calligraphy & Verse Memorization', 'Write one full page of neat cursive calligraphy and learn Surah Al-Alaq verses 1-5.', CURRENT_DATE + INTERVAL '2 days', false);

-- 5. Insert Sample Admission Enquiries (Mock data matching website leads)
INSERT INTO public.admission_enquiries (parent_name, student_name, grade_applying, phone, email, message, status)
VALUES
  ('Zubair Ahmed', 'Faizan Zubair', 'Class 1', '+91 98351 90812', 'zubair.ahmed@gmail.com', 'Inquiring about syllabus, bus transport facility from Patna City, and admission procedure.', 'pending'),
  ('Dr. Shahla Bano', 'Hafsa Farooqui', 'LKG', '+91 94312 87654', 'shahla.bano@yahoo.co.in', 'Looking for child admission in junior KG section. Please share school prospectus.', 'contacted'),
  ('Md. Shahnawaz', 'Ayaan Shahnawaz', 'Pre-Nursery', '+91 99340 12789', 'shahnawaz.patna@outlook.com', 'Wanted to know regarding age criteria for Pre-Nursery session 2026-27.', 'pending');
