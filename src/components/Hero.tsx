import React from "react";
import Link from "next/link";
import Image from "next/image";
import { GraduationCap, ArrowRight, ShieldCheck, MonitorPlay, MapPin } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function Hero() {
  return (
    <section className="relative overflow-hidden bg-forest-hero text-white pt-12 sm:pt-16 lg:pt-20 pb-16 sm:pb-24 border-b border-[#0d3b1f]">
      {/* Subtle Natural Ambient Lighting */}
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-full max-w-7xl h-80 bg-gradient-to-b from-[#2F7D4A]/15 via-transparent to-transparent blur-3xl pointer-events-none" />
      <div className="absolute bottom-6 -right-16 w-72 h-72 rounded-full bg-[#EDE2D3]/5 blur-3xl pointer-events-none" />

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">
          {/* Left Column: Heading, Subtitle, CTAs & Value Bullets */}
          <div className="lg:col-span-7 text-center lg:text-left space-y-6">
            {/* Campus Tag Pill */}
            <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#0d3b1f]/70 border border-[#2F7D4A]/50 text-[#EDE2D3] text-xs sm:text-sm font-semibold shadow-xs">
              <span className="w-2 h-2 rounded-full bg-[#E8F3EA]" />
              <span>Gulzarbagh, Alamganj, Patna, Bihar</span>
            </div>

            {/* School Title & Tagline */}
            <div className="space-y-2">
              <h1 className="text-3xl sm:text-4xl md:text-5xl lg:text-6xl font-black tracking-tight text-white leading-tight">
                {SCHOOL_DATA.name}
              </h1>
              <p className="text-xl sm:text-2xl md:text-3xl font-bold text-[#FAF8F2] italic">
                &ldquo;{SCHOOL_DATA.tagline}&rdquo;
              </p>
            </div>

            {/* Quranic Verse Motto */}
            <div className="inline-block bg-[#0d3b1f]/60 px-4 py-2 rounded-xl border border-[#2F7D4A]/40">
              <p className="text-sm font-serif text-[#EDE2D3] tracking-wide font-medium">
                {SCHOOL_DATA.mottoArabic}
              </p>
              <p className="text-[11px] text-stone-300 italic">
                {SCHOOL_DATA.mottoTranslation}
              </p>
            </div>

            {/* Description */}
            <p className="text-[#EDE2D3] text-sm sm:text-base lg:text-lg leading-relaxed max-w-2xl mx-auto lg:mx-0 font-normal">
              A disciplined, nurturing primary school fostering foundational concepts, character, and curiosity. Providing modern learning through <span className="text-white font-semibold underline decoration-[#EDE2D3]/60 decoration-2 underline-offset-4">Smart Classes</span> and safe campus oversight with <span className="text-white font-semibold underline decoration-[#EDE2D3]/60 decoration-2 underline-offset-4">CCTV Monitoring</span>.
            </p>

            {/* Primary & Secondary CTAs */}
            <div className="pt-2 flex flex-col sm:flex-row items-center justify-center lg:justify-start gap-4">
              <Link
                href="/admissions"
                className="w-full sm:w-auto inline-flex items-center justify-center gap-2.5 px-7 py-3.5 rounded-xl font-bold text-white bg-[#14532D] hover:bg-[#0d3b1f] border border-[#2F7D4A] shadow-sm hover:shadow-md active:scale-98 transition-all text-sm sm:text-base"
              >
                <GraduationCap className="w-5 h-5 text-[#EDE2D3]" />
                <span>Admission Enquiry</span>
              </Link>

              <Link
                href="/about"
                className="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-6 py-3.5 rounded-xl font-bold text-[#14532D] bg-[#FAF8F2] hover:bg-white shadow-xs active:scale-98 transition-all text-sm sm:text-base"
              >
                <span>Explore Our School</span>
                <ArrowRight className="w-4 h-4 text-[#6B4226]" />
              </Link>
            </div>

            {/* Confirmed Facility Badges */}
            <div className="pt-4 border-t border-[#1b7a3f]/40 flex flex-wrap items-center justify-center lg:justify-start gap-6 text-xs sm:text-sm text-[#EDE2D3]">
              <div className="flex items-center gap-2">
                <div className="w-7 h-7 rounded-lg bg-[#E8F3EA]/15 text-white flex items-center justify-center border border-[#E8F3EA]/30">
                  <ShieldCheck className="w-4 h-4 text-[#E8F3EA]" />
                </div>
                <span className="font-semibold">CCTV Monitored Campus</span>
              </div>

              <div className="flex items-center gap-2">
                <div className="w-7 h-7 rounded-lg bg-[#E8F3EA]/15 text-white flex items-center justify-center border border-[#E8F3EA]/30">
                  <MonitorPlay className="w-4 h-4 text-[#E8F3EA]" />
                </div>
                <span className="font-semibold">Interactive Smart Classes</span>
              </div>
            </div>
          </div>

          {/* Right Column: Authentic Logo Crest Showcase */}
          <div className="lg:col-span-5 flex justify-center">
            <div className="relative w-full max-w-sm sm:max-w-md">
              {/* Card Housing the Official Crest */}
              <div className="relative rounded-3xl bg-[#0d3b1f]/85 border border-[#2F7D4A]/50 p-8 sm:p-10 shadow-xl flex flex-col items-center text-center space-y-6">
                {/* Official Crest */}
                <div className="relative w-44 h-44 sm:w-52 sm:h-52 rounded-full bg-white p-2.5 shadow-lg ring-4 ring-[#EDE2D3]/40">
                  <Image
                    src="/logo.png"
                    alt="Al-Qalam Public School Official Crest"
                    width={208}
                    height={208}
                    className="w-full h-full object-contain"
                    priority
                  />
                </div>

                <div className="space-y-1">
                  <h3 className="text-xl font-bold text-white tracking-tight">
                    {SCHOOL_DATA.name}
                  </h3>
                  <p className="text-xs font-semibold text-[#EDE2D3] tracking-wider uppercase">
                    Official School Crest
                  </p>
                </div>

                <div className="w-full grid grid-cols-2 gap-3 pt-2 border-t border-[#2F7D4A]/40 text-left">
                  <div className="p-3 rounded-xl bg-[#14532D]/80 border border-[#2F7D4A]/40">
                    <p className="text-[10px] uppercase font-bold text-[#EDE2D3]">Curriculum</p>
                    <p className="text-xs font-bold text-white mt-0.5">Foundational & Primary</p>
                  </div>
                  <div className="p-3 rounded-xl bg-[#14532D]/80 border border-[#2F7D4A]/40">
                    <p className="text-[10px] uppercase font-bold text-[#EDE2D3]">Environment</p>
                    <p className="text-xs font-bold text-white mt-0.5">Safe & Disciplined</p>
                  </div>
                </div>

                <div className="flex items-center gap-1.5 text-xs text-stone-300">
                  <MapPin className="w-3.5 h-3.5 text-[#EDE2D3]" />
                  <span>Opp. Jashn Palace, Ashok Rajpath Rd</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
