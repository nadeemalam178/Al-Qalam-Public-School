-- ==============================================================================
-- 🏫 Al-Qalam Public School - Supabase 1-Click Sync & Permission Fix
-- ==============================================================================
-- Instructions:
-- 1. Open your Supabase Dashboard SQL Editor:
--    https://supabase.com/dashboard/project/zarvozaaexpblrhjsfzq/sql
-- 2. Paste this entire script into the SQL Editor and click "RUN" (green button).
-- ==============================================================================

-- 1. Create parent_accounts table if it doesn't already exist:
CREATE TABLE IF NOT EXISTS public.parent_accounts (
    id TEXT PRIMARY KEY,
    student_name TEXT NOT NULL,
    parent_name TEXT NOT NULL,
    grade TEXT NOT NULL,
    roll_no TEXT DEFAULT '1',
    phone TEXT NOT NULL,
    login_id TEXT NOT NULL,
    password TEXT NOT NULL DEFAULT 'alqalam2026',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Ensure login_id and password columns exist on teachers:
ALTER TABLE IF EXISTS public.teachers ADD COLUMN IF NOT EXISTS login_id TEXT;
ALTER TABLE IF EXISTS public.teachers ADD COLUMN IF NOT EXISTS password TEXT;

-- 3. Disable RLS on the core shared tables so Website & App can communicate:
--    - admission_enquiries : Allows web admission queries to be saved and viewed in App.
--    - notices             : Allows admin app broadcasts to display on live website.
--    - teachers            : Allows admin to add, view, and manage faculty logins.
--    - parent_accounts     : Allows admin to manage guardian logins.
--    - timetables          : Allows admin to manage class-wise routine schedules.
--    - gallery_items       : Allows admin to upload/delete website gallery photos.

ALTER TABLE IF EXISTS public.admission_enquiries DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.notices DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.teachers DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.parent_accounts DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.timetables DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS public.gallery_items DISABLE ROW LEVEL SECURITY;

-- 4. Grant full read/write privileges to anon (Website) and authenticated (Mobile App):
GRANT USAGE ON SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated, service_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;
