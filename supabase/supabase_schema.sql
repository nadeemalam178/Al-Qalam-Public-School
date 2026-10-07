-- ==============================================================================
-- Al-Qalam Public School (Gulzarbagh, Patna)
-- Unified Central Supabase PostgreSQL Schema & Security Architecture
-- Single Source of Truth for Both Website (Next.js) & Mobile App (Flutter)
-- ==============================================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ==============================================================================
-- 1. PROFILES & ACADEMIC YEARS
-- Profiles must be defined before helper functions that query them.
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('admin', 'teacher', 'guardian')),
  full_name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  designation TEXT,
  avatar_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.academic_years (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,             -- e.g. '2026-2027'
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  is_current BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 2. HELPER FUNCTIONS FOR ROLE VERIFICATION (Eliminates RLS recursion)
-- ==============================================================================

CREATE OR REPLACE FUNCTION public.current_user_role()
RETURNS TEXT AS $$
  SELECT role FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  );
$$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE OR REPLACE FUNCTION public.is_teacher()
RETURNS BOOLEAN AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'teacher'
  );
$$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE OR REPLACE FUNCTION public.is_guardian()
RETURNS BOOLEAN AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'guardian'
  );
$$ LANGUAGE sql STABLE SECURITY DEFINER;

-- ==============================================================================
-- 4. CLASSES & SECTIONS
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.classes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,                    -- e.g. 'Class 3'
  code TEXT UNIQUE NOT NULL,             -- e.g. 'CLS-3'
  grade_level INT NOT NULL,              -- Ordering index (0: Pre-Nur, 1: Nur ... 8: Class 5)
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.sections (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  class_id UUID NOT NULL REFERENCES public.classes(id) ON DELETE CASCADE,
  name TEXT NOT NULL,                    -- 'A', 'B'
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(class_id, name)
);

-- ==============================================================================
-- 5. SUBJECTS
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.subjects (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  class_id UUID REFERENCES public.classes(id) ON DELETE CASCADE,
  name TEXT NOT NULL,                    -- e.g. 'Mathematics', 'Science & EVS'
  code TEXT NOT NULL,                    -- e.g. 'MATH-3'
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(class_id, name)
);

-- ==============================================================================
-- 6. STUDENTS
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.students (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  admission_no TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  class_id UUID REFERENCES public.classes(id) ON DELETE SET NULL,
  section_id UUID REFERENCES public.sections(id) ON DELETE SET NULL,
  grade TEXT NOT NULL,                   -- e.g. 'Class 3'
  section TEXT NOT NULL DEFAULT 'A',
  roll_no INT,
  father_name TEXT,
  mother_name TEXT,
  phone TEXT,
  address TEXT,
  dob DATE,
  blood_group TEXT,
  attendance_rate NUMERIC(5,2) DEFAULT 95.0,
  pending_fees NUMERIC(10,2) DEFAULT 0.0,
  photo_url TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 7. GUARDIAN_STUDENTS (Multi-Child / Sibling Relationship Support)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.guardian_students (
  guardian_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES public.students(id) ON DELETE CASCADE,
  relationship TEXT DEFAULT 'Parent',
  is_primary BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  PRIMARY KEY (guardian_id, student_id)
);

-- ==============================================================================
-- 8. TEACHERS
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.teachers (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id UUID UNIQUE NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  employee_id TEXT UNIQUE NOT NULL,
  qualification TEXT,
  joining_date DATE DEFAULT CURRENT_DATE,
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'on_leave', 'resigned')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 9. TEACHER_CLASSES (Class & Subject Assignments)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.teacher_classes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  teacher_id UUID NOT NULL REFERENCES public.teachers(id) ON DELETE CASCADE,
  class_id UUID NOT NULL REFERENCES public.classes(id) ON DELETE CASCADE,
  section_id UUID REFERENCES public.sections(id) ON DELETE CASCADE,
  subject_id UUID REFERENCES public.subjects(id) ON DELETE SET NULL,
  academic_year_id UUID REFERENCES public.academic_years(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 10. ATTENDANCE
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.attendance (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  student_id UUID NOT NULL REFERENCES public.students(id) ON DELETE CASCADE,
  class_id UUID REFERENCES public.classes(id) ON DELETE SET NULL,
  section_id UUID REFERENCES public.sections(id) ON DELETE SET NULL,
  date DATE NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('present', 'absent', 'late', 'excused')),
  remarks TEXT,
  recorded_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(student_id, date)
);

-- ==============================================================================
-- 11. HOMEWORK
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.homework (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  class_id UUID REFERENCES public.classes(id) ON DELETE SET NULL,
  section_id UUID REFERENCES public.sections(id) ON DELETE SET NULL,
  subject_id UUID REFERENCES public.subjects(id) ON DELETE SET NULL,
  grade TEXT NOT NULL,
  subject TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  due_date DATE NOT NULL,
  attachment_url TEXT,
  assigned_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  is_completed BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 12. DIARY (Daily Class Log)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.diary (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  class_id UUID NOT NULL REFERENCES public.classes(id) ON DELETE CASCADE,
  section_id UUID REFERENCES public.sections(id) ON DELETE CASCADE,
  date DATE NOT NULL DEFAULT CURRENT_DATE,
  title TEXT NOT NULL,
  entry TEXT NOT NULL,
  created_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 13. EXAMS
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.exams (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  academic_year_id UUID REFERENCES public.academic_years(id) ON DELETE SET NULL,
  title TEXT NOT NULL,                   -- 'Term 1 Assessment 2026'
  term TEXT NOT NULL,                    -- 'Term 1'
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 14. MARKS (Report Card Evaluations)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.marks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  exam_id UUID NOT NULL REFERENCES public.exams(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES public.students(id) ON DELETE CASCADE,
  subject_id UUID REFERENCES public.subjects(id) ON DELETE SET NULL,
  subject_name TEXT NOT NULL,
  marks_obtained NUMERIC(5,2) NOT NULL,
  max_marks NUMERIC(5,2) NOT NULL DEFAULT 100.0,
  grade TEXT,
  remarks TEXT,
  recorded_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(exam_id, student_id, subject_name)
);

-- ==============================================================================
-- 15. FEE INVOICES
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.fee_invoices (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  invoice_no TEXT UNIQUE NOT NULL,
  student_id UUID NOT NULL REFERENCES public.students(id) ON DELETE CASCADE,
  academic_year_id UUID REFERENCES public.academic_years(id) ON DELETE SET NULL,
  fee_head TEXT NOT NULL,                -- e.g. 'Monthly Tuition - Sep 2026'
  amount_due NUMERIC(10,2) NOT NULL,
  due_date DATE NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'partially_paid', 'paid', 'overdue')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 16. FEE PAYMENTS
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.fee_payments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  receipt_no TEXT UNIQUE NOT NULL,
  invoice_id UUID NOT NULL REFERENCES public.fee_invoices(id) ON DELETE CASCADE,
  amount NUMERIC(10,2) NOT NULL,
  payment_mode TEXT NOT NULL DEFAULT 'Cash', -- 'Cash', 'UPI', 'Bank Transfer', 'Cheque'
  transaction_reference TEXT,
  paid_at TIMESTAMPTZ DEFAULT NOW(),
  recorded_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 17. NOTICES & CIRCULARS
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.notices (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  category TEXT DEFAULT 'general',       -- 'Academic', 'Admissions', 'Safety', 'General'
  target_role TEXT DEFAULT 'all' CHECK (target_role IN ('all', 'guardian', 'teacher', 'admin')),
  attachment_url TEXT,
  publish_date TIMESTAMPTZ DEFAULT NOW(),
  is_active BOOLEAN DEFAULT true,
  created_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 18. ADMISSION ENQUIRIES (Shared Website Form + Mobile Leads)
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.admission_enquiries (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  reference_no TEXT UNIQUE,
  parent_name TEXT NOT NULL,
  student_name TEXT NOT NULL,
  grade_applying TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT,
  message TEXT,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'contacted', 'admitted', 'rejected')),
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 19. LEAVE REQUESTS
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.leave_requests (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  student_id UUID NOT NULL REFERENCES public.students(id) ON DELETE CASCADE,
  requested_by UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  reason TEXT NOT NULL,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  reviewed_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  review_notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 20. TIMETABLES
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.timetables (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  class_id UUID NOT NULL REFERENCES public.classes(id) ON DELETE CASCADE,
  section_id UUID REFERENCES public.sections(id) ON DELETE CASCADE,
  subject_id UUID REFERENCES public.subjects(id) ON DELETE SET NULL,
  teacher_id UUID REFERENCES public.teachers(id) ON DELETE SET NULL,
  grade TEXT NOT NULL,
  section TEXT NOT NULL DEFAULT 'A',
  subject TEXT NOT NULL,
  day_of_week INT NOT NULL CHECK (day_of_week BETWEEN 1 AND 6), -- 1=Mon, 6=Sat
  day_name TEXT NOT NULL,
  period_no INT NOT NULL,
  start_time TEXT NOT NULL,
  end_time TEXT NOT NULL,
  room_no TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 21. AUDIT LOGS
-- ==============================================================================
CREATE TABLE IF NOT EXISTS public.audit_logs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  actor_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  action TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  entity_id UUID,
  metadata JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ==============================================================================
-- 21B. SCHEMA MIGRATION / UPGRADE SAFEGUARDS
-- If tables already existed from an earlier prototype schema, ensure all new
-- relational columns and constraints exist before indexes and policies are created.
-- ==============================================================================
ALTER TABLE public.classes ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ DEFAULT NOW();
ALTER TABLE public.classes ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

ALTER TABLE public.sections ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ DEFAULT NOW();
ALTER TABLE public.sections ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

ALTER TABLE public.students ADD COLUMN IF NOT EXISTS class_id UUID REFERENCES public.classes(id) ON DELETE SET NULL;
ALTER TABLE public.students ADD COLUMN IF NOT EXISTS section_id UUID REFERENCES public.sections(id) ON DELETE SET NULL;
ALTER TABLE public.students ADD COLUMN IF NOT EXISTS photo_url TEXT;
ALTER TABLE public.students ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT true;
ALTER TABLE public.students ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

ALTER TABLE public.guardian_students ADD COLUMN IF NOT EXISTS is_primary BOOLEAN DEFAULT true;
ALTER TABLE public.guardian_students ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ DEFAULT NOW();

ALTER TABLE public.attendance ADD COLUMN IF NOT EXISTS class_id UUID REFERENCES public.classes(id) ON DELETE SET NULL;
ALTER TABLE public.attendance ADD COLUMN IF NOT EXISTS section_id UUID REFERENCES public.sections(id) ON DELETE SET NULL;
ALTER TABLE public.attendance ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

ALTER TABLE public.homework ADD COLUMN IF NOT EXISTS class_id UUID REFERENCES public.classes(id) ON DELETE SET NULL;
ALTER TABLE public.homework ADD COLUMN IF NOT EXISTS section_id UUID REFERENCES public.sections(id) ON DELETE SET NULL;
ALTER TABLE public.homework ADD COLUMN IF NOT EXISTS subject_id UUID REFERENCES public.subjects(id) ON DELETE SET NULL;
ALTER TABLE public.homework ADD COLUMN IF NOT EXISTS attachment_url TEXT;
ALTER TABLE public.homework ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

ALTER TABLE public.notices ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT true;
ALTER TABLE public.notices ADD COLUMN IF NOT EXISTS attachment_url TEXT;
ALTER TABLE public.notices ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

ALTER TABLE public.admission_enquiries ADD COLUMN IF NOT EXISTS reference_no TEXT;
ALTER TABLE public.admission_enquiries ADD COLUMN IF NOT EXISTS notes TEXT;
ALTER TABLE public.admission_enquiries ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- Backfill relational links from textual names if upgrading existing data
UPDATE public.students s
SET class_id = c.id
FROM public.classes c
WHERE s.class_id IS NULL AND (s.grade = c.name OR s.grade = c.code);

UPDATE public.students s
SET section_id = sec.id
FROM public.sections sec
WHERE s.section_id IS NULL AND s.class_id = sec.class_id AND s.section = sec.name;

UPDATE public.homework h
SET class_id = c.id
FROM public.classes c
WHERE h.class_id IS NULL AND (h.grade = c.name OR h.grade = c.code);

UPDATE public.attendance a
SET class_id = s.class_id, section_id = s.section_id
FROM public.students s
WHERE a.student_id = s.id AND a.class_id IS NULL;

-- ==============================================================================
-- 22. PERFORMANCE INDEXES
-- ==============================================================================
CREATE INDEX IF NOT EXISTS idx_profiles_role ON public.profiles(role);
CREATE INDEX IF NOT EXISTS idx_sections_class ON public.sections(class_id);
CREATE INDEX IF NOT EXISTS idx_subjects_class ON public.subjects(class_id);
CREATE INDEX IF NOT EXISTS idx_students_class ON public.students(class_id, section_id);
CREATE INDEX IF NOT EXISTS idx_students_admission ON public.students(admission_no);
CREATE INDEX IF NOT EXISTS idx_guardian_students_guardian ON public.guardian_students(guardian_id);
CREATE INDEX IF NOT EXISTS idx_guardian_students_student ON public.guardian_students(student_id);
CREATE INDEX IF NOT EXISTS idx_teacher_classes_teacher ON public.teacher_classes(teacher_id);
CREATE INDEX IF NOT EXISTS idx_teacher_classes_class ON public.teacher_classes(class_id, section_id);
CREATE INDEX IF NOT EXISTS idx_attendance_student_date ON public.attendance(student_id, date);
CREATE INDEX IF NOT EXISTS idx_homework_grade ON public.homework(grade);
CREATE INDEX IF NOT EXISTS idx_homework_class ON public.homework(class_id, section_id);
CREATE INDEX IF NOT EXISTS idx_marks_student ON public.marks(student_id);
CREATE INDEX IF NOT EXISTS idx_marks_exam ON public.marks(exam_id);
CREATE INDEX IF NOT EXISTS idx_fee_invoices_student ON public.fee_invoices(student_id);
CREATE INDEX IF NOT EXISTS idx_fee_invoices_status ON public.fee_invoices(status);
CREATE INDEX IF NOT EXISTS idx_fee_payments_invoice ON public.fee_payments(invoice_id);
CREATE INDEX IF NOT EXISTS idx_notices_role_active ON public.notices(target_role, is_active, publish_date DESC);
CREATE INDEX IF NOT EXISTS idx_admission_status ON public.admission_enquiries(status);
CREATE INDEX IF NOT EXISTS idx_timetables_lookup ON public.timetables(class_id, section_id, day_of_week);
CREATE INDEX IF NOT EXISTS idx_audit_logs_actor ON public.audit_logs(actor_id, created_at DESC);

-- ==============================================================================
-- 23. AUTOMATIC PROFILE TRIGGER ON AUTH SIGN-UP
-- ==============================================================================
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

-- ==============================================================================
-- 24. AUTOMATIC FEE RECONCILIATION TRIGGER
-- ==============================================================================
CREATE OR REPLACE FUNCTION public.reconcile_fee_invoice()
RETURNS TRIGGER AS $$
DECLARE
  v_invoice_id UUID;
  v_amount_due NUMERIC(10,2);
  v_total_paid NUMERIC(10,2);
  v_due_date DATE;
  v_new_status TEXT;
  v_student_id UUID;
BEGIN
  v_invoice_id := NEW.invoice_id;

  SELECT amount_due, due_date, student_id
  INTO v_amount_due, v_due_date, v_student_id
  FROM public.fee_invoices
  WHERE id = v_invoice_id;

  SELECT COALESCE(SUM(amount), 0.0)
  INTO v_total_paid
  FROM public.fee_payments
  WHERE invoice_id = v_invoice_id;

  IF v_total_paid >= v_amount_due THEN
    v_new_status := 'paid';
  ELSIF v_total_paid > 0 THEN
    v_new_status := 'partially_paid';
  ELSE
    IF v_due_date < CURRENT_DATE THEN
      v_new_status := 'overdue';
    ELSE
      v_new_status := 'pending';
    END IF;
  END IF;

  UPDATE public.fee_invoices
  SET status = v_new_status, updated_at = NOW()
  WHERE id = v_invoice_id;

  -- Recompute and update student pending fees total
  UPDATE public.students
  SET pending_fees = (
    SELECT COALESCE(SUM(fi.amount_due - COALESCE(p.paid, 0)), 0)
    FROM public.fee_invoices fi
    LEFT JOIN (
      SELECT invoice_id, SUM(amount) AS paid
      FROM public.fee_payments
      GROUP BY invoice_id
    ) p ON fi.id = p.invoice_id
    WHERE fi.student_id = v_student_id AND fi.status != 'paid'
  ), updated_at = NOW()
  WHERE id = v_student_id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_after_fee_payment ON public.fee_payments;
CREATE TRIGGER trg_after_fee_payment
  AFTER INSERT OR UPDATE ON public.fee_payments
  FOR EACH ROW EXECUTE FUNCTION public.reconcile_fee_invoice();

-- ==============================================================================
-- 25. ROW LEVEL SECURITY (RLS) POLICIES
-- ==============================================================================

-- Enable RLS across all 21 tables
ALTER TABLE public.academic_years ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.classes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sections ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.subjects ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.students ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.guardian_students ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.teachers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.teacher_classes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.homework ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.diary ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.exams ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.marks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.fee_invoices ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.fee_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notices ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.admission_enquiries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.leave_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.timetables ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;

-- ------------------------------------------------------------------------------
-- LEGACY POLICIES CLEANUP (From earlier prototype versions)
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "Users can read own profile" ON public.profiles;
DROP POLICY IF EXISTS "Admins have full profile access" ON public.profiles;
DROP POLICY IF EXISTS "Read notices policy" ON public.notices;
DROP POLICY IF EXISTS "Admins can post notices" ON public.notices;
DROP POLICY IF EXISTS "Guardians view child attendance" ON public.attendance;
DROP POLICY IF EXISTS "Teachers and admins can record attendance" ON public.attendance;

-- ------------------------------------------------------------------------------
-- PROFILES POLICIES
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "profiles_select_own" ON public.profiles;
CREATE POLICY "profiles_select_own" ON public.profiles
  FOR SELECT USING (auth.uid() = id OR public.is_admin());

DROP POLICY IF EXISTS "profiles_admin_all" ON public.profiles;
CREATE POLICY "profiles_admin_all" ON public.profiles
  FOR ALL USING (public.is_admin());

DROP POLICY IF EXISTS "profiles_update_self" ON public.profiles;
CREATE POLICY "profiles_update_self" ON public.profiles
  FOR UPDATE USING (auth.uid() = id);

-- ------------------------------------------------------------------------------
-- ACADEMIC YEARS / CLASSES / SECTIONS / SUBJECTS POLICIES (Public/Auth Read)
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "read_academic_years" ON public.academic_years;
CREATE POLICY "read_academic_years" ON public.academic_years FOR SELECT TO public USING (true);
DROP POLICY IF EXISTS "admin_academic_years" ON public.academic_years;
CREATE POLICY "admin_academic_years" ON public.academic_years FOR ALL USING (public.is_admin());

DROP POLICY IF EXISTS "read_classes" ON public.classes;
CREATE POLICY "read_classes" ON public.classes FOR SELECT TO public USING (true);
DROP POLICY IF EXISTS "admin_classes" ON public.classes;
CREATE POLICY "admin_classes" ON public.classes FOR ALL USING (public.is_admin());

DROP POLICY IF EXISTS "read_sections" ON public.sections;
CREATE POLICY "read_sections" ON public.sections FOR SELECT TO public USING (true);
DROP POLICY IF EXISTS "admin_sections" ON public.sections;
CREATE POLICY "admin_sections" ON public.sections FOR ALL USING (public.is_admin());

DROP POLICY IF EXISTS "read_subjects" ON public.subjects;
CREATE POLICY "read_subjects" ON public.subjects FOR SELECT TO public USING (true);
DROP POLICY IF EXISTS "admin_subjects" ON public.subjects;
CREATE POLICY "admin_subjects" ON public.subjects FOR ALL USING (public.is_admin());

-- ------------------------------------------------------------------------------
-- STUDENTS POLICIES (Strict Guardian-Child and Teacher-Class Isolation)
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "students_access" ON public.students;
CREATE POLICY "students_access" ON public.students
  FOR SELECT TO authenticated
  USING (
    public.is_admin()
    OR (
      public.is_guardian() AND id IN (
        SELECT student_id FROM public.guardian_students WHERE guardian_id = auth.uid()
      )
    )
    OR (
      public.is_teacher() AND class_id IN (
        SELECT tc.class_id FROM public.teacher_classes tc
        JOIN public.teachers t ON t.id = tc.teacher_id
        WHERE t.profile_id = auth.uid()
      )
    )
  );

DROP POLICY IF EXISTS "admin_students_manage" ON public.students;
CREATE POLICY "admin_students_manage" ON public.students
  FOR ALL USING (public.is_admin());

-- ------------------------------------------------------------------------------
-- GUARDIAN_STUDENTS POLICIES
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "guardian_students_select" ON public.guardian_students;
CREATE POLICY "guardian_students_select" ON public.guardian_students
  FOR SELECT TO authenticated
  USING (guardian_id = auth.uid() OR public.is_admin());

DROP POLICY IF EXISTS "admin_guardian_students" ON public.guardian_students;
CREATE POLICY "admin_guardian_students" ON public.guardian_students
  FOR ALL USING (public.is_admin());

-- ------------------------------------------------------------------------------
-- TEACHERS & TEACHER_CLASSES POLICIES
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "teachers_select" ON public.teachers;
CREATE POLICY "teachers_select" ON public.teachers
  FOR SELECT TO authenticated USING (true);

DROP POLICY IF EXISTS "admin_teachers" ON public.teachers;
CREATE POLICY "admin_teachers" ON public.teachers
  FOR ALL USING (public.is_admin());

DROP POLICY IF EXISTS "teacher_classes_select" ON public.teacher_classes;
CREATE POLICY "teacher_classes_select" ON public.teacher_classes
  FOR SELECT TO authenticated USING (true);

DROP POLICY IF EXISTS "admin_teacher_classes" ON public.teacher_classes;
CREATE POLICY "admin_teacher_classes" ON public.teacher_classes
  FOR ALL USING (public.is_admin());

-- ------------------------------------------------------------------------------
-- ATTENDANCE POLICIES
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "attendance_select" ON public.attendance;
CREATE POLICY "attendance_select" ON public.attendance
  FOR SELECT TO authenticated
  USING (
    public.is_admin()
    OR (
      public.is_guardian() AND student_id IN (
        SELECT student_id FROM public.guardian_students WHERE guardian_id = auth.uid()
      )
    )
    OR (
      public.is_teacher() AND class_id IN (
        SELECT tc.class_id FROM public.teacher_classes tc
        JOIN public.teachers t ON t.id = tc.teacher_id
        WHERE t.profile_id = auth.uid()
      )
    )
  );

DROP POLICY IF EXISTS "attendance_record" ON public.attendance;
CREATE POLICY "attendance_record" ON public.attendance
  FOR ALL TO authenticated
  USING (
    public.is_admin()
    OR (
      public.is_teacher() AND class_id IN (
        SELECT tc.class_id FROM public.teacher_classes tc
        JOIN public.teachers t ON t.id = tc.teacher_id
        WHERE t.profile_id = auth.uid()
      )
    )
  );

-- ------------------------------------------------------------------------------
-- HOMEWORK & DIARY POLICIES
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "homework_select" ON public.homework;
CREATE POLICY "homework_select" ON public.homework
  FOR SELECT TO authenticated USING (true);

DROP POLICY IF EXISTS "homework_manage" ON public.homework;
CREATE POLICY "homework_manage" ON public.homework
  FOR ALL TO authenticated
  USING (
    public.is_admin()
    OR (
      public.is_teacher() AND (
        class_id IN (
          SELECT tc.class_id FROM public.teacher_classes tc
          JOIN public.teachers t ON t.id = tc.teacher_id
          WHERE t.profile_id = auth.uid()
        ) OR assigned_by = auth.uid()
      )
    )
  );

DROP POLICY IF EXISTS "diary_select" ON public.diary;
CREATE POLICY "diary_select" ON public.diary
  FOR SELECT TO authenticated USING (true);

DROP POLICY IF EXISTS "diary_manage" ON public.diary;
CREATE POLICY "diary_manage" ON public.diary
  FOR ALL TO authenticated
  USING (
    public.is_admin()
    OR (
      public.is_teacher() AND class_id IN (
        SELECT tc.class_id FROM public.teacher_classes tc
        JOIN public.teachers t ON t.id = tc.teacher_id
        WHERE t.profile_id = auth.uid()
      )
    )
  );

-- ------------------------------------------------------------------------------
-- EXAMS & MARKS POLICIES
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "exams_select" ON public.exams;
CREATE POLICY "exams_select" ON public.exams
  FOR SELECT TO authenticated USING (true);

DROP POLICY IF EXISTS "admin_exams" ON public.exams;
CREATE POLICY "admin_exams" ON public.exams
  FOR ALL USING (public.is_admin());

DROP POLICY IF EXISTS "marks_select" ON public.marks;
CREATE POLICY "marks_select" ON public.marks
  FOR SELECT TO authenticated
  USING (
    public.is_admin()
    OR (
      public.is_guardian() AND student_id IN (
        SELECT student_id FROM public.guardian_students WHERE guardian_id = auth.uid()
      )
    )
    OR (
      public.is_teacher() AND student_id IN (
        SELECT s.id FROM public.students s
        WHERE s.class_id IN (
          SELECT tc.class_id FROM public.teacher_classes tc
          JOIN public.teachers t ON t.id = tc.teacher_id
          WHERE t.profile_id = auth.uid()
        )
      )
    )
  );

DROP POLICY IF EXISTS "marks_manage" ON public.marks;
CREATE POLICY "marks_manage" ON public.marks
  FOR ALL TO authenticated
  USING (
    public.is_admin()
    OR (
      public.is_teacher() AND student_id IN (
        SELECT s.id FROM public.students s
        WHERE s.class_id IN (
          SELECT tc.class_id FROM public.teacher_classes tc
          JOIN public.teachers t ON t.id = tc.teacher_id
          WHERE t.profile_id = auth.uid()
        )
      )
    )
  );

-- ------------------------------------------------------------------------------
-- FEES POLICIES (Parent views only own child; Admin manages)
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "fee_invoices_select" ON public.fee_invoices;
CREATE POLICY "fee_invoices_select" ON public.fee_invoices
  FOR SELECT TO authenticated
  USING (
    public.is_admin()
    OR (
      public.is_guardian() AND student_id IN (
        SELECT student_id FROM public.guardian_students WHERE guardian_id = auth.uid()
      )
    )
  );

DROP POLICY IF EXISTS "fee_invoices_admin" ON public.fee_invoices;
CREATE POLICY "fee_invoices_admin" ON public.fee_invoices
  FOR ALL USING (public.is_admin());

DROP POLICY IF EXISTS "fee_payments_select" ON public.fee_payments;
CREATE POLICY "fee_payments_select" ON public.fee_payments
  FOR SELECT TO authenticated
  USING (
    public.is_admin()
    OR (
      public.is_guardian() AND invoice_id IN (
        SELECT fi.id FROM public.fee_invoices fi
        JOIN public.guardian_students gs ON gs.student_id = fi.student_id
        WHERE gs.guardian_id = auth.uid()
      )
    )
  );

DROP POLICY IF EXISTS "fee_payments_admin" ON public.fee_payments;
CREATE POLICY "fee_payments_admin" ON public.fee_payments
  FOR ALL USING (public.is_admin());

-- ------------------------------------------------------------------------------
-- NOTICES POLICIES (Public Website Read for 'all', Scoped for Authenticated)
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "notices_public_select" ON public.notices;
CREATE POLICY "notices_public_select" ON public.notices
  FOR SELECT TO public
  USING (
    (target_role = 'all' AND is_active = true)
    OR (
      auth.role() = 'authenticated' AND (
        public.is_admin()
        OR target_role = 'all'
        OR (public.is_guardian() AND target_role = 'guardian')
        OR (public.is_teacher() AND target_role = 'teacher')
      )
    )
  );

DROP POLICY IF EXISTS "admin_notices_manage" ON public.notices;
CREATE POLICY "admin_notices_manage" ON public.notices
  FOR ALL USING (public.is_admin());

-- ------------------------------------------------------------------------------
-- ADMISSION ENQUIRIES POLICIES (Public Website Insert, Admin Read/Update)
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "admission_public_insert" ON public.admission_enquiries;
CREATE POLICY "admission_public_insert" ON public.admission_enquiries
  FOR INSERT TO public
  WITH CHECK (true);

DROP POLICY IF EXISTS "admission_admin_all" ON public.admission_enquiries;
CREATE POLICY "admission_admin_all" ON public.admission_enquiries
  FOR ALL USING (public.is_admin());

-- ------------------------------------------------------------------------------
-- LEAVE REQUESTS POLICIES
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "leave_requests_select" ON public.leave_requests;
CREATE POLICY "leave_requests_select" ON public.leave_requests
  FOR SELECT TO authenticated
  USING (
    public.is_admin()
    OR requested_by = auth.uid()
    OR (
      public.is_teacher() AND student_id IN (
        SELECT s.id FROM public.students s
        WHERE s.class_id IN (
          SELECT tc.class_id FROM public.teacher_classes tc
          JOIN public.teachers t ON t.id = tc.teacher_id
          WHERE t.profile_id = auth.uid()
        )
      )
    )
  );

DROP POLICY IF EXISTS "leave_requests_guardian_insert" ON public.leave_requests;
CREATE POLICY "leave_requests_guardian_insert" ON public.leave_requests
  FOR INSERT TO authenticated
  WITH CHECK (
    requested_by = auth.uid() AND student_id IN (
      SELECT student_id FROM public.guardian_students WHERE guardian_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "leave_requests_admin_update" ON public.leave_requests;
CREATE POLICY "leave_requests_admin_update" ON public.leave_requests
  FOR UPDATE USING (public.is_admin() OR public.is_teacher());

-- ------------------------------------------------------------------------------
-- TIMETABLES POLICIES
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "timetables_select" ON public.timetables;
CREATE POLICY "timetables_select" ON public.timetables
  FOR SELECT TO authenticated USING (true);

DROP POLICY IF EXISTS "admin_timetables" ON public.timetables;
CREATE POLICY "admin_timetables" ON public.timetables
  FOR ALL USING (public.is_admin());

-- ------------------------------------------------------------------------------
-- AUDIT LOGS POLICIES (Admins only, Authenticated can insert)
-- ------------------------------------------------------------------------------
DROP POLICY IF EXISTS "audit_logs_select" ON public.audit_logs;
CREATE POLICY "audit_logs_select" ON public.audit_logs
  FOR SELECT TO authenticated USING (public.is_admin());

DROP POLICY IF EXISTS "audit_logs_insert" ON public.audit_logs;
CREATE POLICY "audit_logs_insert" ON public.audit_logs
  FOR INSERT TO authenticated WITH CHECK (true);

-- ==============================================================================
-- 26. STORAGE BUCKETS CONFIGURATION
-- ==============================================================================
INSERT INTO storage.buckets (id, name, public) VALUES
  ('student-photos', 'student-photos', true),
  ('teacher-photos', 'teacher-photos', true),
  ('school-assets', 'school-assets', true),
  ('notices', 'notices', true),
  ('homework', 'homework', true),
  ('documents', 'documents', true)
ON CONFLICT (id) DO NOTHING;

-- Public read access on public school storage buckets
DROP POLICY IF EXISTS "Public storage read" ON storage.objects;
CREATE POLICY "Public storage read" ON storage.objects
  FOR SELECT TO public
  USING (bucket_id IN ('student-photos', 'teacher-photos', 'school-assets', 'notices', 'homework', 'documents'));

-- Authenticated upload access
DROP POLICY IF EXISTS "Staff storage insert" ON storage.objects;
CREATE POLICY "Staff storage insert" ON storage.objects
  FOR INSERT TO authenticated
  WITH CHECK (
    bucket_id IN ('student-photos', 'teacher-photos', 'school-assets', 'notices', 'homework', 'documents')
    AND (public.is_admin() OR public.is_teacher())
  );
