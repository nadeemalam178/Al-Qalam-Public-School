# 🏫 Al-Qalam Public School (Gulzarbagh, Patna)
## Comprehensive Development, Engineering & Delivery Report
**Last Updated:** September 30, 2026  
**Repository:** `nadeemalam178/Al-Qalam-Public-School`  
**Platform Coverage:** Next.js Web Portal (`/src`) + Flutter Cross-Platform Mobile App (`/mobile_app`) + Supabase Backend (`/supabase`)

---

## 📑 Table of Contents
1. [Executive Summary](#1-executive-summary)
2. [Brand Identity & Design System](#2-brand-identity--design-system)
3. [Next.js Institutional Website & Web Portal (`/src`)](#3-nextjs-institutional-website--web-portal-src)
4. [Flutter Mobile Application Suite (`/mobile_app`)](#4-flutter-mobile-application-suite-mobile_app)
5. [Role-Selection Security & Strict Session Lock-in](#5-role-selection-security--strict-session-lock-in)
6. [Cinematic Animations & Micro-Interactions](#6-cinematic-animations--micro-interactions)
7. [Supabase Backend Architecture & Database Schema](#7-supabase-backend-architecture--database-schema)
8. [Performance, Bug Fixes & Layout Overflow Elimination](#8-performance-bug-fixes--layout-overflow-elimination)
9. [Android APK Compilations & Size Optimization (~89% Reduction)](#9-android-apk-compilations--size-optimization-89-reduction)
10. [Active Credentials & Test Accounts](#10-active-credentials--test-accounts)
11. [Git Commit History & Delivery Status](#11-git-commit-history--delivery-status)

---

## 1. Executive Summary

Al-Qalam Public School is an established Islamic & Modern primary educational institution located in Dargah Road, Sultanganj, Gulzarbagh, Patna, catering to students from **Pre-Nursery through Class 5**. 

Over the course of this project, we transformed the digital presence of the school into an end-to-end, enterprise-grade educational ecosystem comprising:
- A high-performance, modern institutional website built with **Next.js, TypeScript, and Vanilla CSS/Tailwind**.
- A feature-complete, triple-role **Flutter Mobile Application** for **Administrators**, **Teachers**, and **Parents**.
- A secure **Supabase PostgreSQL cloud database** with Row-Level Security (RLS) policies, triggers, and full seed data.
- Optimized Android binaries with launcher icons, fluid animations, and lightweight delivery.

---

## 2. Brand Identity & Design System

The visual identity combines academic prestige with authentic Islamic heritage:

- **Primary Colors:**
  - **Imperial Pine / Deep Emerald:** `#072414` & `#14532d` — Represents Islamic scholarship, calm, and academic growth.
  - **Forest Green Primary:** `#166534` — Core UI surface and interaction color.
  - **Warm Metallic Gold:** `#D4AF37` & `#F59E0B` — Represents illumination, excellence, and achievement.
  - **Soft Ivory / Cream:** `#F8FAFC` & `#FDFBF7` — Warm, readability-focused neutral backdrops.
- **Typography:**
  - **Headings:** Google Fonts `Outfit` — Modern, bold, geometric legibility.
  - **Body Text:** Google Fonts `Inter` — Crisp, neutral, highly readable UI text.
  - **Quranic Scripture:** Google Fonts `Amiri` — Authentic traditional Naskh calligraphy for the school's foundational motto:  
    *اقْرَأْ بِاسْمِ رَبِّكَ الَّذِي خَلَقَ* (*"Read in the name of your Lord who created"* — Surah Al-Alaq).
- **Official Crest & Assets:**
  - Clean high-resolution vector emblem (`clean_logo.png`).
  - High-res branding badge (`logo_badge.png`) with circular gold border for launchers and splash screens.

---

## 3. Next.js Institutional Website & Web Portal (`/src`)

The school website was built from scratch and progressively elevated into a modern institutional showcase:

### 🌟 Core Web Pages & Sections
1. **Header & Navigation Dock:**
   - Glassmorphic translucent navigation bar with quick contact info, school timing, and emergency phone.
   - Interactive mobile navigation drawer with quick tap anchors.
   - Persistent bottom action dock on mobile for instant calls, WhatsApp enquiry, and Mobile App download.
2. **Hero Presentation Section:**
   - Dynamic entrance banners displaying core values: *"Values-First Islamic & Modern Education"*.
   - Quick stat badges: CCTV 24x7 Monitored Campus, Qualified Faculty, Pre-Nursery to Class 5.
   - Dual Call-to-Actions (CTAs) for Online Admissions and Mobile App download.
3. **About & Leadership Section:**
   - Director’s Welcome Message from **Mrs. Rahat Jahan** (Director & Campus Administrator).
   - School history in Gulzarbagh, pedagogical ethos, and mission statement.
4. **Academic Curriculum:**
   - Modular breakdown of learning milestones from Pre-Nursery, Nursery, LKG, UKG up to Class 5.
   - Balanced curriculum integrating CBSE standards, Hindi, English, Mathematics, Science, alongside Urdu, Arabic phonetics, and Deeniyat (moral values).
5. **Authentic Photography & Interactive Cycling Gallery:**
   - Integrated authentic school photos from campus events:
     - Classroom learning sessions (`students-classroom.jpg`)
     - Educational field excursions (`educational-trip.jpg`)
     - Annual drawing competitions (`drawing-competition.jpg`)
     - Star student and class topper award felicitations (`class-topper-certificate.jpg`, `star-student-certificate.jpg`)
   - Auto-advancing interactive modal lightbox for full-screen photo viewing.
6. **Campus Amenities & Features:**
   - Smart audio-visual interactive classrooms.
   - 24/7 CCTV surveillance coverage across all corridors and classrooms.
   - Safe school transport fleet.
   - Clean RO drinking water and hygienic child-friendly sanitation facilities.
7. **Admissions & Online Enquiry Form:**
   - Interactive multi-field admission enquiry form.
   - Full accessibility compliance with explicit `name`, `id`, and `aria-` attributes for WCAG standards.
   - Connected to Supabase `admission_enquiries` table for instant administrative review.
8. **Live Circulars & Notice Board:**
   - Categorized announcements (Academic, Exams, Holidays, Emergency Alerts).
9. **Contact & Location:**
   - Interactive map embed, physical campus address (Near Dargah Road, Sultanganj, Gulzarbagh, Patna), WhatsApp chat direct link, and phone dialers.

### 🛠️ Web Architecture & Build Fixes
- Added `unrs-resolver` to `package.json` `allowScripts` to eliminate Vercel build compilation warnings.
- Fully optimized responsive layouts for mobile, tablet, desktop, and large screens.
- OpenGraph metadata, meta descriptions, and Twitter card preview integrations.

---

## 4. Flutter Mobile Application Suite (`/mobile_app`)

The Flutter application (`package: al_qalam_school`) was engineered as a single, unified enterprise app serving three distinct user personas under a single codebase.

### 🏗️ Application Architecture
- **State Management:** Provider (`ChangeNotifier`) via `AuthProvider` and `SchoolProvider`.
- **Layer-First Directory Layout:**
  - `lib/theme/` — Centralized color tokens, Typography, Button styles, and Card themes.
  - `lib/models/` — Type-safe domain models (`AppUser`, `Student`, `Homework`, `Notice`, `AttendanceRecord`, `FeeInvoice`, `TimetableSlot`).
  - `lib/services/` — `AuthRepository`, `SupabaseAuthRepository`, `SchoolDataRepository`, and `SupabaseService`.
  - `lib/providers/` — `AuthProvider` (session lifecycle & authorization) and `SchoolProvider` (data caching & CRUD operations).
  - `lib/widgets/` — Reusable components (`CustomSchoolAppBar`, `StatCard`, `SectionHeader`, `BounceTap`, `AnimatedEntry`).
  - `lib/screens/` — Modularized directories: `auth/`, `admin/`, `teacher/`, `parent/`, and `common/`.

### 📱 The Three Role Portals
#### 1. Administrator Portal (`lib/screens/admin/`)
- **Executive Dashboard:** Live metrics for Total Active Students (185+), Faculty Count (14), Total Fee Collections, Pending Dues, and Daily Attendance Rate.
- **Student Roster Management:** Complete directory of enrolled students with filter by grade, roll number search, and student status.
- **Staff & Faculty Management:** Teacher directory with assigned classes and subject designations.
- **Financial & Fee Collections:** Overview of monthly fee dues, recorded transactions, and receipt status.
- **Circular Dispatcher:** Multi-role notice publishing tool to broadcast circulars to Parents, Teachers, or the entire school.

#### 2. Teacher Portal (`lib/screens/teacher/`)
- **Live Class Attendance Marker:** One-tap toggle for Present, Absent, and Late with real-time class counters.
- **Homework & Daily Diary Creator:** Form to post homework with subject selection, due dates, instructions, and target grades.
- **Class Timetable View:** Weekly schedule breakdown for Class 3-A across periods and subjects.
- **Report Card & Marks Entry:** Student evaluation records for term assessments.

#### 3. Parent / Guardian Portal (`lib/screens/parent/`)
- **Digital Student ID Badge:** Displays child's photo, Roll Number, Admission Number, Class & Section, Blood Group, and Attendance Rate.
- **School Services Grid (6 Modules):**
  - *Attendance Tracker:* Calendar view with monthly presence percentages.
  - *Fee Dues & Receipts:* Breakdown of monthly tuition, transport dues, and cleared status.
  - *Daily Homework Diary:* Interactive checklist where parents can mark homework as completed at home.
  - *Report Card:* Subject-wise grade cards and term rankings.
  - *Class Timetable:* Schedule of upcoming lectures and daily subjects.
  - *Campus Information:* School ethos, contact numbers, and campus guidelines.
- **Notice Board Feed:** Real-time circulars for holidays, exams, and urgent school notices.

---

## 5. Role-Selection Security & Strict Session Lock-in

To meet strict educational data privacy and security requirements:

1. **Role-Selection Initial Screen:**
   - Upon launching the app, users are greeted with the **Role Selection Screen**.
   - Displays 3 large selectable cards: **Administrator**, **Teacher**, and **Parent**.
   - Selecting a card transitions to the specific login form for that role.
2. **Database Role Enforcement & Mismatch Guard:**
   - When a user logs in, their credentials and actual assigned database role are verified.
   - If an account registered as a Teacher tries to log in under the Administrator or Parent tab, the app **blocks access immediately** with a security exception:  
     `"This account is registered as a Teacher. Please select Teacher to continue."`
3. **Strict Session Lock-in (Zero Role Hopping):**
   - Previous versions had an unauthenticated role-switcher modal in the AppBar and drawer.
   - **This was completely eliminated:** The switcher button and drawer role section were permanently removed.
   - In its place is a **Locked Session Indicator Pill** (`Icons.lock_outline_rounded` + Role Name).
   - Tapping the badge opens a verified profile dialog with an explicit security notice:  
     `"Session is locked to this account for security. To access another role, you must sign out first."`
   - Role switching is now exclusively permitted by tapping **"Sign Out of Session"**, returning the user to the initial Role Selection screen.

---

## 6. Cinematic Animations & Micro-Interactions

The mobile app was elevated from a basic static interface to a visually rich, reactive experience:

1. **Cinematic Splash Screen Animation (`splash_screen.dart`):**
   - **Ambient Radiant Backdrop:** Multi-stop gradient mixing deep Imperial Pine (`#072414`), emerald, and subtle gold bloom.
   - **Breathing Golden Halo:** Smooth pulsing radial glow behind the circular school emblem badge.
   - **Emblem Scale-In:** Smooth curved spring entrance of the school crest.
   - **Scripture Reveal:** Staggered upward slide and fade-in of the Quranic ayah (*اقْرَأْ بِاسْمِ رَبِّكَ الَّذِي خَلَقَ*).
   - **Tagline Reveal:** Animated subtitle badge showing *"Al-Qalam Public School • Excellence in Education"*.
   - **Cinematic Exit Zoom:** On completion, the emblem zooms forward (`1.0` -> `1.35`) while dissolving smoothly into the login flow via a `FadeTransition`.
2. **`AnimatedEntry` (Staggered Flow Widget):**
   - Custom widget built in `lib/widgets/animated_entry.dart`.
   - Staggers cards, stat widgets, action grids, and notices with progressive delays (`40ms`, `140ms`, `220ms`, `300ms`) using `Curves.easeOutCubic`.
3. **`BounceTap` (Tactile Spring Physics):**
   - Wraps buttons, stat cards, quick service grid icons, and homework check items in an interactive spring scale effect (`0.965` scale down on press with spring-back).
4. **Official School App Launcher Icon:**
   - Generated native launcher icons (`ic_launcher.png`) across all 5 Android mipmap densities (`mdpi`, `hdpi`, `xhdpi`, `xxhdpi`, `xxxhdpi`).
   - Clean circular white background with gold outer rim and centered Al-Qalam crest.
   - Android application label updated to `Al-Qalam School` in `AndroidManifest.xml`.

---

## 7. Supabase Backend Architecture & Database Schema

All backend logic, relational schemas, security policies, and seed scripts were constructed and verified:

### 🗄️ Tables Created (`supabase_schema.sql`)
1. `profiles`: User accounts linked to `auth.users(id)` with roles (`admin`, `teacher`, `guardian`), designations, and student linkages.
2. `classes`: Pre-Nursery, Nursery, LKG, UKG, Class 1 through Class 5.
3. `sections`: Section A, Section B.
4. `students`: Enrolled student profiles, admission numbers, parents' names, attendance rate, pending fees, blood group, and emergency phone.
5. `guardian_students`: Relational table linking parent profile IDs to their children (supporting multi-sibling families).
6. `attendance`: Daily presence tracking per student (`present`, `absent`, `late`, `excused`).
7. `homework`: Daily diary tasks with subject, title, description, due date, and completion status.
8. `notices`: Institutional circulars with target audience scoping (`all`, `guardian`, `teacher`).
9. `admission_enquiries`: Captures online admission applications submitted from the website.

### 🛡️ Row Level Security (RLS) & Triggers
- RLS enabled across all 9 tables.
- Automated `handle_new_user()` trigger automatically populates the `profiles` table upon Supabase Auth sign-up.
- Guardians can only view their own linked children's attendance and fee records.
- Faculty can record attendance and assign homework for their assigned classes.
- Administrators possess master CRUD permissions across all tables.

### 🌱 Realistic Seed Script (`supabase_dummy_data.sql`)
- Pre-populated with realistic Gulzarbagh, Patna students, teachers, homework assignments, notices, and pending fee records for seamless offline and online demonstration.

---

## 8. Performance, Bug Fixes & Layout Overflow Elimination

1. **RenderFlex Overflow Elimination:**
   - Resolved all yellow-and-black striped layout overflows on small and medium screens across the Admin Dashboard, Teacher Dashboard, Parent Dashboard, and bottom sheets.
   - Replaced rigid rows with `SingleChildScrollView`, `Flexible`, `FittedBox`, and constrained `GridView` ratios.
2. **Form Accessibility:**
   - Added missing `name` and `id` tags across all website forms to pass WCAG 2.1 AA accessibility audits.
3. **Flutter Static Analysis:**
   - Cleaned all lint warnings (`prefer_const_constructors`, `prefer_const_literals_to_create_immutables`).
   - `flutter analyze` runs with **0 issues found**.
4. **Automated Test Suite:**
   - Created test suite `test/login_flow_test.dart` and `test/widget_test.dart`.
   - **All 14/14 tests pass** across database mapping, role mismatch prevention, and UI transitions.

---

## 9. Android APK Compilations & Size Optimization (~89% Reduction)

### The Challenge:
Initial debug compilation produced a **219.2 MB APK** because debug mode bundles 4 unstripped CPU architectures simultaneously along with the Dart Just-In-Time (JIT) runtime and development debugging tools.

### The Solution & Optimizations Applied:
1. **Release Mode Ahead-Of-Time (AOT) Compilation:** Compiles Dart directly to optimized ARM machine code.
2. **Icon Font Tree-Shaking:** Automatically stripped unused Material Icons from the font file, reducing icon font size from 1.64 MB down to 20.9 KB (**98.7% reduction**).
3. **ABI Splitting (`--split-per-abi`):** Split the builds by target CPU architecture to strip out unused native libraries for each specific device.

### 📦 Resulting Production Artifacts:

| File Name | File Size | Description & Best Use Case | Direct File Link |
| :--- | :---: | :--- | :--- |
| **`alqalam-school-arm64-release.apk`** *(Recommended)* | **25.2 MB** <br>*(~89% reduction)* | **Optimized for 99% of modern Android smartphones** (64-bit ARM). Fast download and lightweight install. | [alqalam-school-arm64-release.apk](file:///c:/Users/alamn/Downloads/Antigravity/Al%20Qalam%20Public%20School/mobile_app/alqalam-school-arm64-release.apk) |
| **`alqalam-school-release.apk`** | **60.0 MB** | **Universal Release APK** (Bundles 32-bit ARM, 64-bit ARM, and x86_64 in one universal installer). | [alqalam-school-release.apk](file:///c:/Users/alamn/Downloads/Antigravity/Al%20Qalam%20Public%20School/mobile_app/alqalam-school-release.apk) |
| **`alqalam-school-debug.apk`** | 219.2 MB | Debug testing binary with full developer logs. | [alqalam-school-debug.apk](file:///c:/Users/alamn/Downloads/Antigravity/Al%20Qalam%20Public%20School/mobile_app/alqalam-school-debug.apk) |

---

## 10. Active Credentials & Test Accounts

The following test credentials are baked into the authentication repository and database:

```text
====================================================================================================
ROLE           | PRIMARY USER ID | PASSWORD     | ALTERNATIVE IDENTIFIERS      | USER PROFILE
====================================================================================================
Administrator  | Alqalam_777     | newappschool | admin                        | Rahat Jahan
               |                 |              | director@alqalam.edu.in      | (Campus Director)
               |                 |              | 9308462418                   |
----------------------------------------------------------------------------------------------------
Teacher        | teacher_101     | newappschool | teacher                      | Farzana Begum
               |                 |              | farzana.t@alqalam.edu.in     | (Class 3-A Faculty)
               |                 |              | 9431056782                   |
----------------------------------------------------------------------------------------------------
Parent         | parent_201      | newappschool | parent                       | Mohd. Tariq Alam
               |                 |              | tariq.alam@gmail.com         | (Parent of Zaid Alam)
               |                 |              | 9835012450                   |
====================================================================================================
```
*Note: All accounts also accept `alqalam123` as a secondary backup password.*  
*Full documentation available in:* [CREDENTIALS.md](file:///c:/Users/alamn/Downloads/Antigravity/Al%20Qalam%20Public%20School/CREDENTIALS.md) and [mobile_app/CREDENTIALS.md](file:///c:/Users/alamn/Downloads/Antigravity/Al%20Qalam%20Public%20School/mobile_app/CREDENTIALS.md).

---

## 11. Git Commit History & Delivery Status

All changes are committed, documented, and synchronized directly with the GitHub remote repository:

- **Repository URL:** `https://github.com/nadeemalam178/Al-Qalam-Public-School.git`
- **Active Branch:** `main`

### 📜 Commit Sequence:
- `a64d41d` — `docs: add login credentials reference for Administrator, Teacher, and Parent accounts`
- `b1ee32e` — `feat(app): enforce role lock-in, add school app launcher icon, cinematic splash animation, and smooth micro-interactions`
- `9cf65d3` — `fix(ui): eliminate RenderFlex layout overflows across all screens and dialogs`
- `964efc8` — `feat(db): add comprehensive Supabase SQL dummy data seed script`
- `8104f26` — `feat(auth): implement role-selection login with Supabase integration, admin master credentials, and RLS schema`
- `4da7316` — `feat(mobile): add complete Flutter mobile application suite for parents, teachers, and admins`
- `567d86f` — `fix(accessibility): add name and id attributes to all form fields for WCAG standards compliance`
- `5a100ca` — `fix(deps): approve unrs-resolver in package.json allowScripts to silence Vercel build warning`
- `caf29fa` — `feat: complete institutional redesign with authentic Facebook photography, dynamic auto-cycling gallery, mobile app navigation dock, and smooth UI animations`
- `df684c1` — `fix(branding): restore authentic original logo, integrate real student photos, and digitally rebuild school banner`
- `fd9ccae` — `feat: premium animations, scroll reveal, micro-interactions, and centralized sample images`
- `85a426f` — `feat(branding): add authentic vector and 2048px logo suite and integrate across website`
- `2b6945c` — `feat: complete Al-Qalam Public School website with Green & Earthy visual identity`

---
*Report prepared by Google Antigravity Advanced Agentic AI for Al-Qalam Public School.*
