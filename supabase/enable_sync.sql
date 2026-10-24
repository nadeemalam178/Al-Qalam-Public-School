-- ==============================================================================
-- 🏫 Al-Qalam Public School - Supabase 1-Click Sync & Permission Fix
-- ==============================================================================
-- Instructions:
-- 1. Open your Supabase Dashboard SQL Editor:
--    https://supabase.com/dashboard/project/zarvozaaexpblrhjsfzq/sql
-- 2. Paste this entire script into the SQL Editor and click "RUN" (green button).
-- ==============================================================================

-- 1. Disable RLS on the core shared tables so Website & App can communicate:
--    - admission_enquiries : Allows web admission queries to be saved and viewed in App.
--    - notices             : Allows admin app broadcasts to display on live website.
--    - teachers            : Allows admin to add, view, and delete faculty members.
--    - timetables          : Allows admin to manage class-wise routine schedules.
--    - gallery_items       : Allows admin to upload/delete website gallery photos.

ALTER TABLE IF EXISTS public.admission_enquiries DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.notices DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.teachers DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.timetables DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.gallery_items DISABLE ROW LEVEL SECURITY;

-- 2. Grant full read/write privileges to anon (Website) and authenticated (Mobile App):
GRANT USAGE ON SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated, service_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;
