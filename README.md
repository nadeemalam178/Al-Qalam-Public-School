# 🏫 Al-Qalam Public School (Gulzarbagh, Patna)
> **Institutional Web Portal, Cross-Platform Mobile App & Unified Cloud Database**

An enterprise-grade educational ecosystem serving students, parents, teachers, and school administration from **Pre-Nursery through Class 5** in Sultanganj, Gulzarbagh, Patna.

---

## 📁 Clean Repository Structure

```
Al Qalam Public School/
├── src/                    # Next.js 16 Web Application (React 19, Tailwind CSS)
│   ├── app/                # App Router (Home, Academics, Admissions, Notices, Gallery, Contact)
│   ├── components/         # Reusable UI components & DPS Patna design system
│   ├── data/               # Institutional facts, curricula, and image registries
│   └── lib/                # Supabase client & API integrations
│
├── mobile_app/             # Flutter Mobile Suite (iOS & Android)
│   ├── lib/                # Multi-role app (Admin, Teacher, and Parent dashboards)
│   └── assets/             # In-app icons, branding badges & offline assets
│
├── supabase/               # Unified Cloud Database (PostgreSQL)
│   ├── supabase_schema.sql # 21 core relational tables, RLS security policies & triggers
│   └── supabase_seed_data.sql # Verified test data, student rosters & credentials
│
├── docs/                   # Complete Documentation & Architecture Guides
│   ├── COMPLETE_PROJECT_SUMMARY.md # Master engineering & delivery report
│   ├── CREDENTIALS.md      # Active test accounts & role logins
│   └── FACEBOOK_IMPORT.md  # Social media content integration protocols
│
├── releases/               # Compiled Android Application Binaries
│   ├── Al-Qalam-Public-School-Release.apk   # Universal release build (63 MB)
│   ├── alqalam-school-arm64-release.apk     # Optimized 64-bit release build (26 MB)
│   └── alqalam-school-debug.apk             # Development debug binary
│
├── public/                 # Static Web Assets (Crests, icons, downloadable APK)
│   └── Al-Qalam-Public-School-Release.apk   # Live website download endpoint
│
└── Assets/                 # Raw High-Resolution Institutional Media
    ├── branding/           # Clean vector badges, creation scripts & emblems
    └── (photo files)       # Classroom, excursion, drawing competition & merit photos
```

---

## 🚀 Quick Start Guide

### 1. Web Portal (Next.js)
```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Production build & static generation
npm run build
```
Open [http://localhost:3000](http://localhost:3000) to view the school website.

### 2. Mobile App (Flutter)
```bash
cd mobile_app

# Fetch dependencies
flutter pub get

# Run on connected device or emulator
flutter run

# Compile production APK
flutter build apk --release
```

---

## 🔐 Credentials & Architecture
For active test accounts, administrative roles, and database schema diagrams, see:
- 📖 [Project Summary](file:///c:/Users/alamn/Downloads/Antigravity/Al%20Qalam%20Public%20School/docs/COMPLETE_PROJECT_SUMMARY.md)
- 🔑 [Account Credentials](file:///c:/Users/alamn/Downloads/Antigravity/Al%20Qalam%20Public%20School/docs/CREDENTIALS.md)
- 🗄️ [Database Schema](file:///c:/Users/alamn/Downloads/Antigravity/Al%20Qalam%20Public%20School/supabase/supabase_schema.sql)

