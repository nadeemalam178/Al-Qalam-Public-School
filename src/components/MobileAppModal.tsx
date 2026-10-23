"use client";

import React, { useState } from "react";
import {
  X,
  Smartphone,
  ShieldCheck,
  UserCheck,
  GraduationCap,
  CheckCircle2,
  Lock,
} from "lucide-react";

interface RoleCard {
  role: "Parent" | "Teacher" | "Administrator";
  title: string;
  details: string;
  features: string[];
}

const ROLES_INFO: RoleCard[] = [
  {
    role: "Parent",
    title: "Parent & Student Portal",
    details: "Designed exclusively for verified guardians to monitor student attendance, view digital fee receipts, track daily homework, and receive school circulars in real-time.",
    features: [
      "Instant Daily Attendance Notifications",
      "Online Fee Dues & Downloadable Receipts",
      "Daily Homework Diary & Teacher Remarks",
      "Digital Student ID Card & Academic Progress Cards",
    ],
  },
  {
    role: "Teacher",
    title: "Faculty & Classroom Desk",
    details: "Authorized faculty portal for quick morning rollcall, digital homework assignment, subject syllabus tracking, and direct student performance entry.",
    features: [
      "1-Tap Morning Attendance Rollcall",
      "Daily Homework Assignment & Subject Schedules",
      "Periodic Unit Test Marks & Grading Submission",
      "Classroom Timetable & Official Holiday Schedules",
    ],
  },
  {
    role: "Administrator",
    title: "Director & Campus Administration",
    details: "Complete institutional governance desk for school administrators to supervise campus operations, fee collection reports, faculty attendance, and urgent circular broadcasts.",
    features: [
      "Real-time Admission Enquiries Pipeline",
      "Consolidated Fee Collections & Dues Analytics",
      "Campus-wide Instant Emergency & Circular Broadcast",
      "Complete Student Rosters & Faculty Records Oversight",
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
        className="relative max-w-2xl w-full bg-white rounded-3xl overflow-hidden shadow-2xl flex flex-col max-h-[92vh] border border-stone-200"
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
                Institutional App Suite for Parents, Teachers &amp; Administration
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
                {current.role} Portal
              </span>
              <span className="text-[11px] text-stone-500 font-medium flex items-center gap-1">
                <Lock className="w-3 h-3 text-[#14532D]" />
                <span>Protected Role</span>
              </span>
            </div>

            <p className="text-xs sm:text-sm text-stone-700 leading-relaxed">
              {current.details}
            </p>

            {/* Security Notice Box */}
            <div className="p-3.5 rounded-xl bg-white border border-[#2F7D4A]/20 flex items-center gap-2.5 text-xs text-stone-600">
              <Lock className="w-4 h-4 text-[#14532D] shrink-0" />
              <span>
                Personalized login credentials are issued privately by the school administrative desk to enrolled parents and appointed faculty.
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
              <span className="font-bold text-stone-900 block">Android Compatibility:</span>
              <span>Android 7.0 (Nougat) up to Android 15</span>
            </div>
            <div>
              <span className="font-bold text-stone-900 block">Architecture:</span>
              <span>Secured Cloud Database Sync</span>
            </div>
            <div>
              <span className="font-bold text-stone-900 block">Authentication:</span>
              <span>Encrypted Session Tokens &amp; Role-Based Access Control</span>
            </div>
          </div>
        </div>

        {/* Footer Actions */}
        <div className="px-6 py-4 bg-stone-50 border-t border-stone-200 flex flex-col sm:flex-row items-center justify-between gap-4">
          <p className="text-[11px] text-stone-500 text-center sm:text-left">
            Need help installing or accessing your account? Contact the administrative desk at Ashok Rajpath Rd.
          </p>

          <div className="flex items-center gap-3 shrink-0">
            <a
              href="https://wa.me/919308462418?text=Hello%20Al-Qalam%20School,%20I%20need%20assistance%20with%20the%20mobile%20app."
              target="_blank"
              rel="noopener noreferrer"
              className="px-4 py-2.5 rounded-xl bg-[#25D366] hover:bg-[#20BE5B] text-white font-bold text-xs shadow-xs transition-colors flex items-center gap-1.5"
            >
              <span>Contact Campus Helpdesk</span>
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
