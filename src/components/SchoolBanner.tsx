import React from "react";
import Image from "next/image";
import { ShieldCheck, MonitorPlay, Sparkles, MapPin, Award } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function SchoolBanner() {
  return (
    <section className="relative w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 my-10 sm:my-16">
      {/* Outer Banner Card with Gold/Emerald Border Accent */}
      <div className="relative overflow-hidden rounded-3xl bg-radial from-[#1e5e38] via-[#0e3d20] to-[#051a0d] border-4 border-[#c89d52] shadow-2xl p-6 sm:p-10 lg:p-12 text-white">
        {/* Decorative Gold Inset Border */}
        <div className="absolute inset-2 sm:inset-3 border border-[#f7d58b]/30 rounded-2xl pointer-events-none" />

        {/* Ambient Radial Lighting */}
        <div className="absolute -top-24 left-1/2 -translate-x-1/2 w-96 sm:w-[600px] h-64 bg-radial from-[#f7d58b]/15 to-transparent blur-2xl pointer-events-none" />

        {/* Top Header Row */}
        <div className="relative z-10 flex flex-col sm:flex-row items-center justify-between gap-4 pb-6 border-b border-[#c89d52]/30">
          {/* Logo & School Classification */}
          <div className="flex items-center gap-3 sm:gap-4 text-center sm:text-left">
            <div className="relative w-14 h-14 sm:w-16 sm:h-16 shrink-0 filter drop-shadow-[0_4px_12px_rgba(0,0,0,0.5)]">
              <Image
                src="/logo.png"
                alt="Al-Qalam Public School Authentic Emblem"
                width={64}
                height={64}
                className="w-full h-full object-contain"
                priority
              />
            </div>
            <div>
              <p className="text-xs sm:text-sm font-bold uppercase tracking-widest text-[#ede2d3]">
                Al-Qalam Public School
              </p>
              <p className="text-[11px] sm:text-xs font-semibold text-[#f7d58b] tracking-wider uppercase">
                Primary & Foundational Education
              </p>
            </div>
          </div>

          {/* Slogan Pill */}
          <div className="inline-flex items-center gap-2 px-5 py-2 rounded-full bg-[#0a2916]/80 border border-[#c89d52]/60 shadow-md">
            <Sparkles className="w-3.5 h-3.5 text-[#f7d58b]" />
            <span className="font-serif text-sm sm:text-base font-bold text-[#f7d58b] tracking-widest uppercase">
              &ldquo;{SCHOOL_DATA.tagline}&rdquo;
            </span>
          </div>

          {/* Key Amenities */}
          <div className="hidden lg:flex items-center gap-2 px-4 py-1.5 rounded-full bg-[#e8f3ea]/10 border border-[#e8f3ea]/20 text-xs font-bold uppercase tracking-wider text-[#ede2d3]">
            <span>CCTV Security</span>
            <span>•</span>
            <span>Smart Classes</span>
          </div>
        </div>

        {/* Center Banner Showcase */}
        <div className="relative z-10 py-8 sm:py-12 flex flex-col items-center text-center space-y-4 sm:space-y-6">
          {/* Quranic Verse */}
          <div className="space-y-1">
            <p className="font-serif text-2xl sm:text-3xl lg:text-4xl text-[#ffd978] tracking-wide dir-rtl" dir="rtl">
              الَّذِي عَلَّمَ بِالْقَلَمِ
            </p>
            <p className="text-[11px] sm:text-xs text-[#d1fae5] tracking-widest uppercase font-semibold opacity-90">
              Who taught by the pen — Surah Al-Alaq
            </p>
          </div>

          {/* Urdu Calligraphy Name */}
          <div className="pt-2">
            <h2
              className="text-4xl sm:text-6xl lg:text-7xl font-bold text-white tracking-wide select-none drop-shadow-[0_4px_16px_rgba(0,0,0,0.8)]"
              dir="rtl"
              style={{ fontFamily: "'Noto Nastaliq Urdu', 'Amiri', serif" }}
            >
              القلم پبلک اسکول
            </h2>
          </div>

          {/* English School Title */}
          <div>
            <h1 className="text-3xl sm:text-5xl lg:text-6xl font-black text-[#ef4444] tracking-wider sm:tracking-widest uppercase drop-shadow-[0_4px_20px_rgba(239,68,68,0.35)]">
              AL-QALAM PUBLIC SCHOOL
            </h1>
          </div>

          {/* Official Confirmed Address Badge */}
          <div className="inline-flex items-center gap-2 px-5 py-2.5 rounded-full bg-[#0d3b1f]/90 border border-[#2f7d4a] shadow-lg max-w-2xl">
            <MapPin className="w-4 h-4 text-[#f7d58b] shrink-0" />
            <span className="text-xs sm:text-sm font-bold text-white tracking-wide text-center">
              Opposite Jashn Palace, Loharwa Ghat Lane, Ashok Rajpath Rd, Gulzarbagh, Patna - 800007
            </span>
          </div>
        </div>

        {/* Bottom Banner Feature Bar */}
        <div className="relative z-10 pt-4 sm:pt-6 border-t border-[#c89d52]/30 flex flex-col sm:flex-row items-center justify-between gap-3 text-xs sm:text-sm text-[#ede2d3]">
          <div className="flex flex-wrap items-center justify-center gap-4 sm:gap-6 font-semibold">
            <span className="inline-flex items-center gap-1.5">
              <ShieldCheck className="w-4 h-4 text-[#c89d52]" /> CCTV Monitored Campus
            </span>
            <span className="inline-flex items-center gap-1.5">
              <MonitorPlay className="w-4 h-4 text-[#c89d52]" /> Interactive Smart Classes
            </span>
            <span className="inline-flex items-center gap-1.5">
              <Award className="w-4 h-4 text-[#c89d52]" /> Moral & Foundational Excellence
            </span>
          </div>

          <div className="font-bold text-[#f7d58b] uppercase tracking-wider text-xs">
            Director: <span className="text-white">{SCHOOL_DATA.director.name}</span>
          </div>
        </div>
      </div>
    </section>
  );
}
