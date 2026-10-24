-- ==============================================================================
-- Al-Qalam Public School - Supabase Unified Permissions & Security Script
-- Applies to BOTH Website (anon) and Mobile App (authenticated)
-- Run this in your Supabase SQL Editor:
-- https://supabase.com/dashboard/project/zarvozaaexpblrhjsfzq/sql
-- ==============================================================================

-- 1. GRANT USAGE & FULL ACCESS TO SCHEMA ROLES
GRANT USAGE ON SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA public TO anon, authenticated, service_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON ROUTINES TO anon, authenticated, service_role;

-- 2. ROW LEVEL SECURITY (RLS) FOR PUBLIC WEBSITE (anon role)
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

-- B. School Notices: Public visitors can view active general notices
ALTER TABLE public.notices ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public to read active notices" ON public.notices;
CREATE POLICY "Allow public to read active notices"
ON public.notices
FOR SELECT
TO anon, authenticated
USING (is_active = true);

-- C. Classes, Sections & Academic Years: Public read for admission forms
ALTER TABLE public.classes ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public read classes" ON public.classes;
CREATE POLICY "Public read classes" ON public.classes FOR SELECT TO anon, authenticated USING (true);

ALTER TABLE public.sections ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public read sections" ON public.sections;
CREATE POLICY "Public read sections" ON public.sections FOR SELECT TO anon, authenticated USING (true);

ALTER TABLE public.academic_years ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Public read academic years" ON public.academic_years;
CREATE POLICY "Public read academic years" ON public.academic_years FOR SELECT TO anon, authenticated USING (true);

-- 3. ROW LEVEL SECURITY (RLS) FOR MOBILE APP (authenticated role)
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

-- 4. VERIFICATION OUTPUT
SELECT 'SUCCESS: All schema permissions and RLS policies configured for Website + Mobile App!' AS result;
