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
    <section className="relative bg-[#FAF8F2] border-b border-[#EDE2D3] pt-10 sm:pt-14 lg:pt-16 pb-12 sm:pb-16 overflow-hidden">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-10 lg:gap-12 items-center">
          {/* Left Column: Eyebrow, Main Heading, Copy, Actions */}
          <div className="lg:col-span-6 space-y-6 text-center lg:text-left">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#E8F3EA] border border-[#2F7D4A]/25 text-[#14532D] text-xs font-semibold tracking-wider uppercase">
              <span>{SCHOOL_DATA.name}</span>
            </div>

            <h1 className="font-heading font-black text-3xl sm:text-4xl md:text-5xl lg:text-[2.75rem] text-[#14532D] tracking-tight leading-[1.15]">
              Where Learning Builds Character
            </h1>

            <p className="text-stone-700 text-base sm:text-lg leading-relaxed max-w-xl mx-auto lg:mx-0">
              Located in Gulzarbagh, Patna, Al-Qalam Public School offers young learners disciplined foundational schooling, caring teacher guidance, and modern Smart Class instruction in a secure, nurturing campus.
            </p>

            {/* Arabic Motto Line */}
            <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-lg bg-white border border-[#E7E5E4] text-stone-600 text-xs shadow-2xs">
              <span className="font-serif font-medium text-[#14532D] text-sm">
                {SCHOOL_DATA.mottoArabic}
              </span>
              <span className="text-stone-300">•</span>
              <span className="italic text-stone-500">
                &ldquo;{SCHOOL_DATA.mottoTranslation}&rdquo;
              </span>
            </div>

            {/* CTAs */}
            <div className="flex flex-col sm:flex-row items-center justify-center lg:justify-start gap-3.5 pt-2">
              <Link
                href="/admissions"
                className="btn-primary w-full sm:w-auto px-6 py-3 rounded-lg text-sm font-semibold text-white bg-[#14532D] hover:bg-[#0B3B20] shadow-sm hover:shadow transition-all border border-[#0B3B20] flex items-center justify-center gap-2"
              >
                <span>Admission Enquiry</span>
                <ArrowRight className="w-4 h-4 text-[#EDE2D3]" />
              </Link>

              <Link
                href="#school-story"
                className="btn-primary w-full sm:w-auto px-6 py-3 rounded-lg text-sm font-semibold text-stone-800 bg-white hover:bg-stone-50 border border-[#E7E5E4] shadow-2xs transition-colors flex items-center justify-center"
              >
                <span>Explore Our School</span>
              </Link>
            </div>
          </div>

          {/* Right Column: Authentic Large School Photograph */}
          <div className="lg:col-span-6 flex justify-center">
            <div className="relative w-full max-w-lg lg:max-w-none">
              <div className="relative rounded-2xl overflow-hidden shadow-lg border border-[#EDE2D3] bg-stone-900 aspect-[4/3]">
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
                  <span className="bg-black/65 backdrop-blur-xs px-3 py-1 rounded-md font-medium text-[11px] text-[#FAF8F2] border border-white/15">
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
        <div className="mt-12 sm:mt-14 pt-8 border-t border-[#EDE2D3]">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4 sm:gap-6">
            {trustPoints.map((point, index) => {
              const IconComp = point.icon;
              return (
                <div
                  key={index}
                  className="flex items-center gap-3 p-3 sm:p-3.5 rounded-xl bg-white border border-[#E7E5E4] shadow-2xs"
                >
                  <div className="w-8 h-8 rounded-lg bg-[#E8F3EA] text-[#14532D] flex items-center justify-center shrink-0 border border-[#2F7D4A]/20">
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
