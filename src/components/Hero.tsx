import React from "react";
import Link from "next/link";
import Image from "next/image";
import { ArrowRight, MonitorPlay, ShieldCheck, HeartHandshake, BookOpen } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";
import { schoolImages } from "@/data/schoolImages";

export default function Hero() {
  const trustPoints = [
    {
      label: "Smart Classes",
      icon: MonitorPlay,
    },
    {
      label: "Safe Campus",
      icon: ShieldCheck,
    },
    {
      label: "Caring Learning Environment",
      icon: HeartHandshake,
    },
    {
      label: "Foundational & Primary Education",
      icon: BookOpen,
    },
  ];

  return (
    <section className="relative bg-gradient-to-b from-stone-50 via-white to-stone-50/60 border-b border-stone-200 pt-10 sm:pt-14 lg:pt-16 pb-12 sm:pb-16 overflow-hidden">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-10 lg:gap-12 items-center">
          {/* Left Column: Eyebrow, Main Heading, Copy, Actions */}
          <div className="lg:col-span-6 space-y-6 text-center lg:text-left animate-slide-up">
            {/* Multi-badge Trust Ribbon */}
            <div className="flex flex-wrap items-center justify-center lg:justify-start gap-2">
              <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-md text-xs font-bold uppercase tracking-wider text-white bg-[#B45309] shadow-xs">
                <span className="w-1.5 h-1.5 rounded-full bg-white animate-pulse" />
                <span>Admissions 2026-27 Open</span>
              </span>
              <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-md text-xs font-bold uppercase tracking-wider text-[#14532D] bg-[#E8F3EA] border border-[#2F7D4A]/25">
                <span>CBSE Pattern + Deeniyat</span>
              </span>
            </div>

            <h1 className="font-heading font-bold text-3xl sm:text-4xl md:text-5xl lg:text-[2.85rem] text-stone-900 tracking-tight leading-[1.15]">
              Excellence in <span className="text-[#14532D]">Foundational & Moral</span> Education
            </h1>

            <p className="text-stone-600 text-base sm:text-lg leading-relaxed max-w-xl mx-auto lg:mx-0">
              Located in Gulzarbagh, Patna, <strong>Al-Qalam Public School</strong> provides young minds with structured English-medium academics, caring teacher mentorship, and interactive Smart Classrooms rooted in strong moral values.
            </p>

            {/* Arabic Motto Line */}
            <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-md bg-stone-50 border border-stone-200 text-stone-600 text-xs shadow-2xs">
              <span className="font-serif font-bold text-[#14532D] text-sm">
                {SCHOOL_DATA.mottoArabic}
              </span>
              <span className="text-stone-300">•</span>
              <span className="italic text-stone-500">
                &ldquo;{SCHOOL_DATA.mottoTranslation}&rdquo;
              </span>
            </div>

            {/* High-Conversion CTAs */}
            <div className="flex flex-col sm:flex-row items-center justify-center lg:justify-start gap-3.5 pt-2">
              <Link
                href="/admissions"
                className="btn-primary-school w-full sm:w-auto text-sm py-3 px-6 shadow-sm hover:shadow transition-all flex items-center justify-center gap-2"
              >
                <span>Online Admission Enquiry</span>
                <ArrowRight className="w-4 h-4 text-white/80" />
              </Link>

              <Link
                href="/contact"
                className="w-full sm:w-auto text-sm py-3 px-6 rounded-lg font-semibold text-[#14532D] bg-white hover:bg-stone-50 border border-stone-300 shadow-xs transition-colors flex items-center justify-center gap-2"
              >
                <span>Schedule Campus Visit</span>
              </Link>
            </div>
          </div>

          {/* Right Column: Authentic Large School Photograph */}
          <div className="lg:col-span-6 flex justify-center">
            <div className="relative w-full max-w-lg lg:max-w-none">
              <div className="relative rounded-2xl overflow-hidden shadow-lg border border-stone-200/90 bg-stone-900 aspect-[4/3]">
                <Image
                  src={schoolImages.hero.src}
                  alt={schoolImages.hero.alt}
                  fill
                  priority
                  sizes="(max-width: 1024px) 100vw, 50vw"
                  className="object-cover object-center"
                />
                <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent pointer-events-none" />

                {/* Subtitle Badge at Base of Image */}
                <div className="absolute bottom-3 left-3 right-3 flex items-center justify-between text-xs text-white">
                  <span className="bg-black/65 backdrop-blur-xs px-3 py-1 rounded-md font-medium text-[11px] text-white border border-white/15">
                    Al-Qalam Classroom Learning • Gulzarbagh
                  </span>
                  <span className="hidden sm:inline bg-black/65 backdrop-blur-xs px-2.5 py-1 rounded-md text-[10px] text-stone-300 border border-white/15">
                    Patna, Bihar
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Subtle Trust Strip Underneath Hero */}
        <div className="mt-12 sm:mt-14 pt-8 border-t border-stone-200/80">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4 sm:gap-6">
            {trustPoints.map((point, index) => {
              const IconComp = point.icon;
              return (
                <div
                  key={index}
                  className="flex items-center gap-3 p-3.5 rounded-xl bg-white border border-stone-200/90 shadow-2xs"
                >
                  <div className="w-8 h-8 rounded-lg bg-[#E8F3EA] text-[#14532D] flex items-center justify-center shrink-0">
                    <IconComp className="w-4 h-4" />
                  </div>
                  <span className="text-xs sm:text-sm font-semibold text-stone-800 leading-snug">
                    {point.label}
                  </span>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </section>
  );
}
