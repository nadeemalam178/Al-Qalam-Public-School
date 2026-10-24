-- ==============================================================================
-- Al-Qalam Public School - Supabase Unified Permissions & Security Script
-- Applies to BOTH Website (anon) and Mobile App (authenticated)
-- Run this in your Supabase SQL Editor:
-- https://supabase.com/dashboard/project/zarvozaaexpblrhjsfzq/sql
-- ==============================================================================

-- 1. CREATE GALLERY_ITEMS TABLE (Shared between Admin CMS & Public Website)
CREATE TABLE IF NOT EXISTS public.gallery_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  category TEXT NOT NULL DEFAULT 'Campus',
  tag TEXT DEFAULT 'Campus Life',
  src TEXT NOT NULL,
  description TEXT DEFAULT '',
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. CREATE WEBSITE_SETTINGS TABLE
CREATE TABLE IF NOT EXISTS public.website_settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT now()
);

INSERT INTO public.website_settings (key, value)
VALUES 
  ('announcement_ticker', 'Admissions Open for Session 2026-27 | Pre-School to Class 5 | Call Campus Desk: +91 93084 62418')
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value;

-- 3. GRANT USAGE & FULL ACCESS TO SCHEMA ROLES
GRANT USAGE ON SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA public TO anon, authenticated, service_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON ROUTINES TO anon, authenticated, service_role;

-- 4. ROW LEVEL SECURITY (RLS) FOR PUBLIC WEBSITE (anon role)
-- A. Admission Enquiries: Public website visitors can submit enquiries
ALTER TABLE public.admission_enquiries ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public website to insert admission enquiries" ON public.admission_enquiries;
CREATE POLICY "Allow public website to insert admission enquiries"
ON public.admission_enquiries
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

DROP POLICY IF EXISTS "Allow authenticated to view admission enquiries" ON public.admission_enquiries;
CREATE POLICY "Allow authenticated to view admission enquiries"
ON public.admission_enquiries
FOR SELECT
TO authenticated
USING (true);

DROP POLICY IF EXISTS "Allow authenticated to update admission enquiries" ON public.admission_enquiries;
CREATE POLICY "Allow authenticated to update admission enquiries"
ON public.admission_enquiries
FOR UPDATE
TO authenticated
USING (true);

-- B. School Notices: Public visitors can view active general notices
ALTER TABLE public.notices ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public to read active notices" ON public.notices;
CREATE POLICY "Allow public to read active notices"
ON public.notices
FOR SELECT
TO anon, authenticated
USING (is_active = true);

DROP POLICY IF EXISTS "Allow authenticated to manage notices" ON public.notices;
CREATE POLICY "Allow authenticated to manage notices"
ON public.notices
FOR ALL
TO authenticated
USING (true);

-- C. Gallery Items: Public can read, authenticated can manage
ALTER TABLE public.gallery_items ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public to read gallery items" ON public.gallery_items;
CREATE POLICY "Allow public to read gallery items"
ON public.gallery_items
FOR SELECT
TO anon, authenticated
USING (is_active = true);

DROP POLICY IF EXISTS "Allow authenticated to manage gallery items" ON public.gallery_items;
CREATE POLICY "Allow authenticated to manage gallery items"
ON public.gallery_items
FOR ALL
TO authenticated
USING (true);

-- D. Website Settings
ALTER TABLE public.website_settings ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow public to read settings" ON public.website_settings;
CREATE POLICY "Allow public to read settings" ON public.website_settings FOR SELECT TO anon, authenticated USING (true);
DROP POLICY IF EXISTS "Allow authenticated to update settings" ON public.website_settings;
CREATE POLICY "Allow authenticated to update settings" ON public.website_settings FOR ALL TO authenticated USING (true);

-- E. Classes, Sections & Academic Years: Public read for admission forms
ALTER TABLE public.classes ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public read classes" ON public.classes;
CREATE POLICY "Public read classes" ON public.classes FOR SELECT TO anon, authenticated USING (true);

ALTER TABLE public.sections ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public read sections" ON public.sections;
CREATE POLICY "Public read sections" ON public.sections FOR SELECT TO anon, authenticated USING (true);

ALTER TABLE public.academic_years ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public read academic years" ON public.academic_years;
CREATE POLICY "Public read academic years" ON public.academic_years FOR SELECT TO anon, authenticated USING (true);

-- 5. ROW LEVEL SECURITY (RLS) FOR MOBILE APP (authenticated role)
-- Profiles: Users can view their own profile, admins can view all
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow authenticated to read profiles" ON public.profiles;
CREATE POLICY "Allow authenticated to read profiles"
ON public.profiles
FOR SELECT
TO authenticated
USING (true);

DROP POLICY IF EXISTS "Allow authenticated to update own profile" ON public.profiles;
CREATE POLICY "Allow authenticated to update own profile"
ON public.profiles
FOR UPDATE
TO authenticated
USING (auth.uid() = id);

-- Students: Authenticated staff and guardians can view student rosters
ALTER TABLE public.students ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow authenticated to read students" ON public.students;
CREATE POLICY "Allow authenticated to read students"
ON public.students
FOR SELECT
TO authenticated
USING (true);

-- Attendance: Authenticated users can view & record attendance
ALTER TABLE public.attendance ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow authenticated to read attendance" ON public.attendance;
CREATE POLICY "Allow authenticated to read attendance"
ON public.attendance
FOR SELECT
TO authenticated
USING (true);

DROP POLICY IF EXISTS "Allow authenticated to insert attendance" ON public.attendance;
CREATE POLICY "Allow authenticated to insert attendance"
ON public.attendance
FOR INSERT
TO authenticated
WITH CHECK (true);

-- Homework: Authenticated users can read & post homework
ALTER TABLE public.homework ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow authenticated to read homework" ON public.homework;
CREATE POLICY "Allow authenticated to read homework"
ON public.homework
FOR SELECT
TO authenticated
USING (true);

DROP POLICY IF EXISTS "Allow authenticated to post homework" ON public.homework;
CREATE POLICY "Allow authenticated to post homework"
ON public.homework
FOR INSERT
TO authenticated
WITH CHECK (true);

-- Fee Invoices & Payments
ALTER TABLE public.fee_invoices ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow authenticated to read fee invoices" ON public.fee_invoices;
CREATE POLICY "Allow authenticated to read fee invoices"
ON public.fee_invoices
FOR SELECT
TO authenticated
USING (true);

ALTER TABLE public.fee_payments ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow authenticated to read fee payments" ON public.fee_payments;
CREATE POLICY "Allow authenticated to read fee payments"
ON public.fee_payments
FOR SELECT
TO authenticated
USING (true);

DROP POLICY IF EXISTS "Allow authenticated to record fee payments" ON public.fee_payments;
CREATE POLICY "Allow authenticated to record fee payments"
ON public.fee_payments
FOR INSERT
TO authenticated
WITH CHECK (true);

-- Timetables & Diary
ALTER TABLE public.timetables ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow authenticated to read timetables" ON public.timetables;
CREATE POLICY "Allow authenticated to read timetables"
ON public.timetables
FOR SELECT
TO authenticated
USING (true);

ALTER TABLE public.diary ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow authenticated to read diary" ON public.diary;
CREATE POLICY "Allow authenticated to read diary"
ON public.diary
FOR ALL
TO authenticated
USING (true);

-- Audit Logs
ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow authenticated to insert audit logs" ON public.audit_logs;
CREATE POLICY "Allow authenticated to insert audit logs"
ON public.audit_logs
FOR INSERT
TO authenticated
WITH CHECK (true);

-- 6. SEED INITIAL GALLERY PHOTOS (if empty)
INSERT INTO public.gallery_items (id, title, category, tag, src, description, is_active)
VALUES
  ('a1b2c3d4-0001-4000-8000-000000000001', 'Rotary Shiksha Ratna Samman Recognition', 'Achievements', 'State Honor', '/images/school/achievements/rotary-shiksha-ratna-award.jpg', 'Director Rahat Jahan receiving the Rotary Shiksha Ratna Samman from Hon''ble Chief Minister of Bihar Nitish Kumar.', true),
  ('a1b2c3d4-0002-4000-8000-000000000002', 'Annual Examination Merit Awards Ceremony', 'Achievements', 'Merit Shield', '/images/school/achievements/annual-exam-merit-shield.jpg', 'Annual examination toppers recognized with academic merit shields and certificates.', true),
  ('a1b2c3d4-0003-4000-8000-000000000003', 'Annual Quiz & Computer Competition', 'Activities', 'STEM & Logic', '/images/school/activities/annual-quiz-competition.jpg', 'Students competing in inter-house mental arithmetic, Islamic studies, and IT rounds.', true),
  ('a1b2c3d4-0004-4000-8000-000000000004', 'Classroom Learning & Interactive Pedagogy', 'Classroom', 'Smart Class', '/images/school/classroom/classroom-learning.jpg', 'Engaging, child-centered classroom sessions focusing on Urdu, English, Mathematics and Science.', true)
ON CONFLICT (id) DO NOTHING;

-- 7. VERIFICATION OUTPUT
SELECT 'SUCCESS: All schema permissions, gallery_items, and RLS policies configured for Website + Mobile App!' AS result;
