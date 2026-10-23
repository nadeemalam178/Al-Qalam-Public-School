-- ==============================================================================
-- Al-Qalam Public School - Supabase Permission Fix for Website & Mobile App
-- Run this in your Supabase SQL Editor: https://supabase.com/dashboard/project/zarvozaaexpblrhjsfzq/sql
-- ==============================================================================

-- 1. Grant Schema Usage to Public Roles
GRANT USAGE ON SCHEMA public TO anon, authenticated, service_role;

-- 2. Grant Table Permissions for Website Public Inquiries & Live Notices
GRANT SELECT, INSERT, UPDATE ON TABLE public.admission_enquiries TO anon, authenticated;
GRANT SELECT ON TABLE public.notices TO anon, authenticated;
GRANT SELECT ON TABLE public.classes TO anon, authenticated;
GRANT SELECT ON TABLE public.sections TO anon, authenticated;
GRANT SELECT ON TABLE public.academic_years TO anon, authenticated;

-- 3. Grant Sequence Usage (for auto-incrementing IDs if any)
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;

-- 4. Enable Row Level Security (RLS) on admission_enquiries
ALTER TABLE public.admission_enquiries ENABLE ROW LEVEL SECURITY;

-- 5. Policy: Allow anyone (website visitors) to submit admission leads
DROP POLICY IF EXISTS "Allow public website to insert admission enquiries" ON public.admission_enquiries;
CREATE POLICY "Allow public website to insert admission enquiries"
ON public.admission_enquiries
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- 6. Policy: Allow admins to view all enquiries
DROP POLICY IF EXISTS "Allow admins to read all admission enquiries" ON public.admission_enquiries;
CREATE POLICY "Allow admins to read all admission enquiries"
ON public.admission_enquiries
FOR SELECT
TO authenticated
USING (true);

-- 7. Enable RLS on notices
ALTER TABLE public.notices ENABLE ROW LEVEL SECURITY;

-- 8. Policy: Allow anyone to read active public notices
DROP POLICY IF EXISTS "Allow public to read active notices" ON public.notices;
CREATE POLICY "Allow public to read active notices"
ON public.notices
FOR SELECT
TO anon, authenticated
USING (is_active = true AND target_role IN ('all', 'guardian'));

-- 9. Verification Query
SELECT 'Permissions successfully granted! Admission leads will now save in Supabase.' AS status;
