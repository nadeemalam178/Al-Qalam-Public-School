-- ==============================================================================
-- Al-Qalam Public School - Supabase PostgreSQL Schema & Security Policies
-- Run this script in your Supabase Dashboard: SQL Editor -> New Query -> Run
-- ==============================================================================

-- 1. Profiles Table (Core Role Authorization)
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  role TEXT NOT NULL CHECK (role IN ('admin', 'teacher', 'guardian')),
  full_name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  designation TEXT,
  avatar_url TEXT,
  student_id TEXT,
  class_assigned TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Classes & Sections
CREATE TABLE IF NOT EXISTS public.classes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  code TEXT UNIQUE NOT NULL,
  grade_level INT NOT NULL
);

CREATE TABLE IF NOT EXISTS public.sections (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  class_id UUID REFERENCES public.classes(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  UNIQUE(class_id, name)
);

-- 3. Students
CREATE TABLE IF NOT EXISTS public.students (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  admission_no TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  grade TEXT NOT NULL,
  section TEXT NOT NULL,
  roll_no INT,
  father_name TEXT,
  mother_name TEXT,
  phone TEXT,
  address TEXT,
  dob DATE,
  blood_group TEXT,
  attendance_rate NUMERIC(5,2) DEFAULT 95.0,
  pending_fees NUMERIC(10,2) DEFAULT 0.0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Guardian Students Relationship (Multi-child/Sibling Support)
CREATE TABLE IF NOT EXISTS public.guardian_students (
  guardian_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  student_id UUID REFERENCES public.students(id) ON DELETE CASCADE,
  relationship TEXT DEFAULT 'Parent',
  PRIMARY KEY (guardian_id, student_id)
);

-- 5. Attendance Records
CREATE TABLE IF NOT EXISTS public.attendance (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  student_id UUID REFERENCES public.students(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('present', 'absent', 'late', 'excused')),
  remarks TEXT,
  recorded_by UUID REFERENCES public.profiles(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(student_id, date)
);

-- 6. Homework & School Diary
CREATE TABLE IF NOT EXISTS public.homework (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  grade TEXT NOT NULL,
  subject TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  due_date DATE NOT NULL,
  assigned_by UUID REFERENCES public.profiles(id),
  is_completed BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. School Notices & Circulars
CREATE TABLE IF NOT EXISTS public.notices (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  category TEXT DEFAULT 'general',
  target_role TEXT DEFAULT 'all' CHECK (target_role IN ('all', 'guardian', 'teacher')),
  publish_date TIMESTAMPTZ DEFAULT NOW(),
  created_by UUID REFERENCES public.profiles(id)
);

-- 8. Admission Enquiries (Connected to Next.js Web Form)
CREATE TABLE IF NOT EXISTS public.admission_enquiries (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  parent_name TEXT NOT NULL,
  student_name TEXT NOT NULL,
  grade_applying TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT,
  message TEXT,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'contacted', 'admitted', 'rejected')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 9. Automatic Profile Creation Trigger on Auth Sign-Up
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, email, role, phone, designation)
  VALUES (
    new.id,
    COALESCE(new.raw_user_meta_data->>'full_name', split_part(new.email, '@', 1)),
    new.email,
    COALESCE(new.raw_user_meta_data->>'role', 'guardian'),
    COALESCE(new.raw_user_meta_data->>'phone', ''),
    COALESCE(new.raw_user_meta_data->>'designation', 'School Member')
  )
  ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    full_name = COALESCE(EXCLUDED.full_name, profiles.full_name);
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- 10. Enable Row Level Security (RLS) on all tables
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.classes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sections ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.students ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.guardian_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.homework ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notices ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.admission_enquiries ENABLE ROW LEVEL SECURITY;

-- 11. Security Policies
-- Profiles: Users can view their own profile, Admins can view/edit all
DROP POLICY IF EXISTS "Users can read own profile" ON public.profiles;
CREATE POLICY "Users can read own profile"
  ON public.profiles FOR SELECT
  USING (auth.uid() = id);

DROP POLICY IF EXISTS "Admins have full profile access" ON public.profiles;
CREATE POLICY "Admins have full profile access"
  ON public.profiles FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles p
      WHERE p.id = auth.uid() AND p.role = 'admin'
    )
  );

-- Notices: Authenticated users can read circulars targeting them or all
DROP POLICY IF EXISTS "Read notices policy" ON public.notices;
CREATE POLICY "Read notices policy"
  ON public.notices FOR SELECT
  TO authenticated
  USING (
    target_role = 'all' OR
    EXISTS (
      SELECT 1 FROM public.profiles p
      WHERE p.id = auth.uid() AND (p.role = 'admin' OR p.role = target_role)
    )
  );

DROP POLICY IF EXISTS "Admins can post notices" ON public.notices;
CREATE POLICY "Admins can post notices"
  ON public.notices FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles p
      WHERE p.id = auth.uid() AND p.role = 'admin'
    )
  );

-- Attendance: Guardians view only their linked children; Teachers/Admins manage
DROP POLICY IF EXISTS "Guardians view child attendance" ON public.attendance;
CREATE POLICY "Guardians view child attendance"
  ON public.attendance FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.guardian_students gs
      WHERE gs.guardian_id = auth.uid() AND gs.student_id = attendance.student_id
    )
    OR
    EXISTS (
      SELECT 1 FROM public.profiles p
      WHERE p.id = auth.uid() AND (p.role = 'admin' OR p.role = 'teacher')
    )
  );

DROP POLICY IF EXISTS "Teachers and admins can record attendance" ON public.attendance;
CREATE POLICY "Teachers and admins can record attendance"
  ON public.attendance FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles p
      WHERE p.id = auth.uid() AND (p.role = 'admin' OR p.role = 'teacher')
    )
  );

-- Initial Classes Seed Data
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
