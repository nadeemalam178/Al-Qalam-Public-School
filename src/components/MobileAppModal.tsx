"use client";

import React, { useState } from "react";
import {
  X,
  Smartphone,
  ShieldCheck,
  UserCheck,
  GraduationCap,
  Key,
  CheckCircle2,
} from "lucide-react";

interface RoleCard {
  role: "Parent" | "Teacher" | "Administrator";
  title: string;
  user: string;
  pass: string;
  name: string;
  details: string;
  features: string[];
}

const ROLES_INFO: RoleCard[] = [
  {
    role: "Parent",
    title: "Parent & Student Portal",
    user: "parent_201",
    pass: "newappschool",
    name: "Mohd. Tariq Alam (Parent of Zaid)",
    details: "Monitor daily attendance, digital fee receipts, homework diary, timetable, and school circulars in real-time.",
    features: [
      "Instant Attendance Alerts & SMS",
      "Online Fee Dues & Downloadable Receipts",
      "Daily Homework Diary & Teacher Remarks",
      "Digital Student ID Card & Academic Report",
    ],
  },
  {
    role: "Teacher",
    title: "Faculty & Classroom Desk",
    user: "teacher_101",
    pass: "newappschool",
    name: "Farzana Begum (Senior Primary)",
    details: "Quick classroom attendance marking, homework publishing, student marks entry, and direct parent notifications.",
    features: [
      "1-Tap Morning Attendance Rollcall",
      "Daily Homework Assignment & Deadlines",
      "Periodic Unit Test Marks Submission",
      "Classroom Timetable & Holiday Schedule",
    ],
  },
  {
    role: "Administrator",
    title: "Director & Campus Admin",
    user: "Alqalam_777",
    pass: "newappschool",
    name: "Rahat Jahan (Director)",
    details: "Complete institutional governance: fee collections overview, faculty tracking, admission enquiries, and circular broadcasts.",
    features: [
      "Real-time Admission Enquiries Pipeline",
      "Total Fee Collection & Defaulter Tracking",
      "Campus-wide Instant Circular Broadcast",
      "Complete Student Roster & Teacher Records",
    ],
  },
];

export default function MobileAppModal({
  isOpen,
  onClose,
}: {
  isOpen: boolean;
  onClose: () => void;
}) {
  const [selectedRole, setSelectedRole] = useState<number>(0);

  if (!isOpen) return null;

  const current = ROLES_INFO[selectedRole];

  return (
    <div
      role="dialog"
      aria-modal="true"
      aria-labelledby="app-modal-title"
      className="fixed inset-0 z-50 flex items-center justify-center p-3 sm:p-6 bg-black/80 backdrop-blur-md animate-fadeIn"
      onClick={onClose}
    >
      <div
        className="relative max-w-3xl w-full bg-white rounded-3xl overflow-hidden shadow-2xl flex flex-col max-h-[92vh] border border-stone-200"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header Bar */}
        <div className="flex items-center justify-between px-6 py-4 bg-[#14532D] text-white">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-amber-400 text-stone-900 flex items-center justify-center shadow-xs">
              <Smartphone className="w-5 h-5" />
            </div>
            <div>
              <h3 id="app-modal-title" className="font-heading font-bold text-base sm:text-lg">
                Official Al-Qalam Mobile Suite
              </h3>
              <p className="text-[11px] text-emerald-200">
                Cross-Platform Flutter Suite for Admins, Teachers &amp; Parents
              </p>
            </div>
          </div>

          <button
            onClick={onClose}
            className="p-2 rounded-xl bg-white/10 hover:bg-white/20 text-white transition-colors cursor-pointer"
            aria-label="Close app modal"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Role Selector Tabs */}
        <div className="flex items-center border-b border-stone-200 bg-stone-50 px-6 text-xs font-semibold">
          {ROLES_INFO.map((r, i) => (
            <button
              key={r.role}
              onClick={() => setSelectedRole(i)}
              className={`py-3 px-4 border-b-2 transition-colors cursor-pointer flex items-center gap-2 ${
                selectedRole === i
                  ? "border-[#14532D] text-[#14532D] bg-white font-bold"
                  : "border-transparent text-stone-600 hover:text-stone-900"
              }`}
            >
              {r.role === "Parent" && <GraduationCap className="w-3.5 h-3.5" />}
              {r.role === "Teacher" && <UserCheck className="w-3.5 h-3.5" />}
              {r.role === "Administrator" && <ShieldCheck className="w-3.5 h-3.5" />}
              <span>{r.title}</span>
            </button>
          ))}
        </div>

        {/* Modal Body */}
        <div className="p-6 overflow-y-auto space-y-6">
          {/* Active Role Feature Card */}
          <div className="p-5 rounded-2xl bg-gradient-to-br from-[#E8F3EA]/70 to-emerald-50/40 border border-[#2F7D4A]/25 space-y-3">
            <div className="flex items-center justify-between">
              <span className="px-3 py-1 rounded-full text-xs font-bold bg-[#14532D] text-white">
                {current.role} Dashboard
              </span>
              <span className="text-[11px] text-stone-500 font-medium">
                Active Demonstration Role
              </span>
            </div>

            <h4 className="font-heading font-bold text-base sm:text-lg text-stone-900">
              {current.name}
            </h4>
            <p className="text-xs sm:text-sm text-stone-700 leading-relaxed">
              {current.details}
            </p>

            {/* Test Credentials Box */}
            <div className="p-3.5 rounded-xl bg-white border border-[#2F7D4A]/20 flex flex-wrap items-center justify-between gap-3 text-xs">
              <div className="flex items-center gap-2 text-stone-700">
                <Key className="w-4 h-4 text-[#14532D]" />
                <span>
                  User ID: <strong className="font-mono text-stone-900">{current.user}</strong>
                </span>
              </div>
              <div className="flex items-center gap-2 text-stone-700">
                <span>
                  Password: <strong className="font-mono text-stone-900">{current.pass}</strong>
                </span>
              </div>
              <span className="text-[10px] text-emerald-700 bg-emerald-100/70 px-2 py-0.5 rounded-md font-semibold">
                Instant Test Login
              </span>
            </div>
          </div>

          {/* Key In-App Modules */}
          <div>
            <h5 className="font-heading font-bold text-xs uppercase tracking-wider text-stone-500 mb-3">
              Included Modules for {current.role}s
            </h5>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              {current.features.map((feat, fIdx) => (
                <div
                  key={fIdx}
                  className="p-3 rounded-xl border border-stone-200 bg-stone-50/60 flex items-center gap-3 text-xs font-semibold text-stone-800"
                >
                  <CheckCircle2 className="w-4 h-4 text-emerald-600 shrink-0" />
                  <span>{feat}</span>
                </div>
              ))}
            </div>
          </div>

          {/* App Specifications */}
          <div className="p-4 rounded-xl bg-stone-50 border border-stone-200 flex flex-wrap items-center justify-between gap-4 text-xs text-stone-600">
            <div>
              <span className="font-bold text-stone-900 block">Universal Android Build:</span>
              <span>Compatible with Android 7.0 (Nougat) up to Android 15</span>
            </div>
            <div>
              <span className="font-bold text-stone-900 block">Engine:</span>
              <span>Flutter 3.x Suite with Cloud Sync</span>
            </div>
            <div>
              <span className="font-bold text-stone-900 block">Security:</span>
              <span>Encrypted Session Storage &amp; PIN Lock</span>
            </div>
          </div>
        </div>

        {/* Footer Actions */}
        <div className="px-6 py-4 bg-stone-50 border-t border-stone-200 flex flex-col sm:flex-row items-center justify-between gap-4">
          <p className="text-[11px] text-stone-500 text-center sm:text-left">
            Need help installing or logging into your student account? Contact our campus desk at Ashok Rajpath Rd.
          </p>

          <div className="flex items-center gap-3 shrink-0">
            <a
              href="https://wa.me/919308462418?text=Hello%20Al-Qalam%20School,%20please%20send%20me%20the%20mobile%20app%20download%20link."
              target="_blank"
              rel="noopener noreferrer"
              className="px-4 py-2.5 rounded-xl bg-[#25D366] hover:bg-[#20BE5B] text-white font-bold text-xs shadow-xs transition-colors flex items-center gap-1.5"
            >
              <span>Request APK on WhatsApp</span>
            </a>
            <button
              onClick={onClose}
              className="px-5 py-2.5 rounded-xl bg-stone-200 hover:bg-stone-300 text-stone-800 font-bold text-xs transition-colors cursor-pointer"
            >
              Close
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
