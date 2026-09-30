# 🎓 Al-Qalam Public School — Mobile Management Suite

A cross-platform Flutter application (Android, iOS, Windows Desktop, Web) crafted for **Al-Qalam Public School**, Gulzarbagh, Patna. Built with Material 3 design and authentic school branding (Deep Forest Green `#0B3B20` & Warm Amber Gold `#D4AF37`), featuring dedicated portals for **Parents/Students**, **Teachers**, and **Administrators / Principal**.

---

## 📱 Features by Persona

### 👨‍👩‍👧 1. Parent & Student Portal
* **Student Identity Card**: Real-time display of Roll #, Class & Section (Class 3-A), Attendance %, Blood Group, and Due Fees badge.
* **Attendance Tracker**: Visual monthly breakdown (Present, Absent, Late, Holiday) with an interactive **"Apply for Leave"** modal sent directly to the class teacher.
* **Fee Ledger & Payments**: Full breakdown of Quarter 1-3 fees, outstanding dues, payment gateway simulation (UPI, Cash at Counter, NetBanking), and **downloadable official digital receipts** with school watermark.
* **Daily Diary & Homework**: Subject-wise homework tasks (Maths, English, EVS, Urdu), due dates, teacher instructions, and one-tap completion toggle.
* **Academic Report Card**: Half-Yearly term examination results with subject scores, percentages, grade letters, class rank (#3), progress bars, and teacher/director evaluations.
* **Class Timetable**: Period-by-period daily schedule with subject, teacher name, and classroom room numbers.
* **School Notices**: Official announcements, priority tags (URGENT / Standard), and circular details.

### 👩‍🏫 2. Class Teacher Portal
* **Daily Attendance Register**: Class 3-A attendance register with quick `P` (Present), `A` (Absent), and `L` (Late) toggles, plus a one-click **"Mark All Present"** button.
* **Assign Homework / Post to Diary**: Form to publish daily homework with subject, title, instructions, and due date directly to parents' phones.
* **Student Directory & Roster**: Searchable student list with roll numbers, parent names, residential addresses, and **one-tap Direct Call Guardian** button.

### 🏫 3. School Administration & Principal Portal
* **Executive Hub**: Live metrics on total student enrollment, total fees collected, outstanding dues, and overall student attendance rate.
* **Fee Collection Counter**: Record offline cash or online fee payments for students with auto-calculation of balances and instant receipt generation.
* **Notice Broadcast Composer**: Compose and publish school-wide circulars (Admissions, Academic, Safety, General) with urgent flags.
* **Admission Enquiries Manager**: Review inbound admission leads submitted via the app or web, track status (`New Enquiry` ➔ `Contacted` ➔ `Campus Visit Scheduled` ➔ `Enrolled`), and call applicants directly.
* **Student Registry**: Complete central repository of all registered students.

---

## ⚡ Instant Role Switching (Demo Feature)

Tap the **"Switch"** button in the top right of the App Bar or open the Navigation Drawer to instantly switch between:
1. **Parent View**: *Mohd. Tariq Alam* (Father of Zaid Alam, Class 3-A, Roll #12)
2. **Teacher View**: *Farzana Begum* (Class 3-A Class Teacher & Mathematics Instructor)
3. **Admin View**: *Rahat Jahan* (Director & Founder, Al-Qalam Public School)

---

## 🚀 Running the App Locally

Ensure Flutter is in your PATH. The Flutter SDK is located at `C:\Users\alamn\Downloads\flutter\bin`.

### Run on Windows Desktop:
```powershell
cd mobile_app
flutter run -d windows
```

### Run in Google Chrome (Web):
```powershell
cd mobile_app
flutter run -d chrome
```

### Run on Connected Android Device or Emulator:
```powershell
cd mobile_app
flutter run -d android
```

### Run All Unit & Widget Tests:
```powershell
cd mobile_app
flutter test
```

### Code Quality Check:
```powershell
cd mobile_app
flutter analyze
```

---

## 🎨 Design System & Colors
* **Primary Forest Deep**: `#0B3B20`
* **Primary Forest Green**: `#14532D`
* **Warm Amber Gold**: `#D4AF37` / `#B8860B`
* **Soft Mint Tint**: `#E8F3EA`
* **Background Light**: `#FAF8F2`
* **Typography**: Outfit (Headings) & Inter (Body), with Amiri for Arabic motto:
  > *"الَّذِي عَلَّمَ بِالْقَلَمِ" — "Who taught by the pen (Surah Al-Alaq)"*
