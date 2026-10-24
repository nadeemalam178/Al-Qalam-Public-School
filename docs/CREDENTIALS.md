# 🏫 Al-Qalam Public School - Authentication & Access Guide

This document describes how authentication and access management work for the **Al-Qalam Public School Mobile App** and web services.

---

## 🔒 Security Architecture

1. **Supabase Cloud Authentication**:
   - All logins are authenticated directly through Supabase Auth using industry-standard JWT tokens with PKCE flow.
   - Passwords are never hardcoded in client source code or mobile APK packages.
   - All passwords in Supabase Auth are salted and hashed using bcrypt.

2. **Row-Level Security (RLS)**:
   - PostgreSQL policies strictly separate Administrator, Teacher, and Parent accounts.
   - A Parent can only view fee invoices, attendance, and homework corresponding to their linked children.
   - A Teacher can record attendance and post assignments for their designated class.
   - An Administrator has full oversight over school statistics, enrollments, and fees.

---

## 📌 Roles & Access

| Role | Access Scope |
| :--- | :--- |
| **Administrator** | Full Campus Oversight, Fee Collections, Faculty Management, Circulars & Analytics |
| **Teacher** | Daily Attendance Marking, Homework Assigning, Class Timetables, Student Rosters |
| **Parent / Guardian** | Linked Student ID Card, Fee Dues & Receipts, Homework, Timetable, School Notices |

---

## 🚀 Setting Up Users in Supabase

To add staff or parents:
1. Open your **Supabase Dashboard**: [https://supabase.com/dashboard/project/zarvozaaexpblrhjsfzq](https://supabase.com/dashboard/project/zarvozaaexpblrhjsfzq)
2. Go to **Authentication** -> **Users** -> Click **Add User** -> **Create User**.
3. Enter their email address and a strong temporary password.
4. Go to Table Editor -> `public.profiles` to ensure their `role` matches (`admin`, `teacher`, or `guardian`).
