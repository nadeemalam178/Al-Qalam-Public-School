"use client";

import React, { useState, useEffect } from "react";
import Image from "next/image";
import Link from "next/link";
import {
  Calendar,
  Award,
  BookOpen,
  Compass,
  Trophy,
  ArrowRight,
  Layers,
  ChevronLeft,
  ChevronRight,
} from "lucide-react";
import { VERIFIED_SCHOOL_EVENTS, SchoolEventItem } from "@/data/galleryData";

const categoryIcons: Record<SchoolEventItem["category"], React.ReactNode> = {
  Achievements: <Award className="w-4 h-4 text-[#D97706]" />,
  Academic: <BookOpen className="w-4 h-4 text-[#14532D]" />,
  Activities: <Trophy className="w-4 h-4 text-[#2F7D4A]" />,
  Events: <Compass className="w-4 h-4 text-[#0B3B20]" />,
  Celebrations: <Calendar className="w-4 h-4 text-[#6B4226]" />,
};

function DynamicEventCard({ event, index }: { event: SchoolEventItem; index: number }) {
  const images = React.useMemo(() => {
    return [event.image, ...(event.altImages || [])];
  }, [event.image, event.altImages]);

  const [currentIdx, setCurrentIdx] = useState(0);
  const [isHovered, setIsHovered] = useState(false);

  // Hover auto-cycle
  useEffect(() => {
    if (!isHovered || images.length <= 1) return;

    const timer = setInterval(() => {
      setCurrentIdx((prev) => (prev + 1) % images.length);
    }, 1600);

    return () => clearInterval(timer);
  }, [isHovered, images.length]);

  // Ambient gentle auto-cycle
  useEffect(() => {
    if (isHovered || images.length <= 1) return;

    const delay = 4000 + (index % 3) * 1200;
    const timer = setInterval(() => {
      setCurrentIdx((prev) => (prev + 1) % images.length);
    }, delay);

    return () => clearInterval(timer);
  }, [isHovered, index, images.length]);

  const nextImg = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    if (images.length > 1) {
      setCurrentIdx((prev) => (prev + 1) % images.length);
    }
  };

  const prevImg = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    if (images.length > 1) {
      setCurrentIdx((prev) => (prev === 0 ? images.length - 1 : prev - 1));
    }
  };

  return (
    <div
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
      className="group relative rounded-2xl border border-stone-200/80 glass-panel overflow-hidden flex flex-col hover:border-[#14532D]/40 hover:shadow-2xl transition-all duration-500 hover:-translate-y-1.5"
    >
      {/* Dynamic Image Container */}
      <div className="relative h-52 sm:h-56 w-full bg-stone-900 overflow-hidden">
        {images.map((imgSrc, iIdx) => (
          <div
            key={imgSrc}
            className={`absolute inset-0 transition-all duration-700 ease-in-out ${
              iIdx === currentIdx
                ? "opacity-100 scale-100 z-10"
                : "opacity-0 scale-105 pointer-events-none z-0"
            }`}
          >
            <Image
              src={imgSrc}
              alt={`${event.title} - ${iIdx + 1}`}
              fill
              sizes="(max-width: 640px) 100vw, (max-width: 1024px) 50vw, 33vw"
              className="object-cover object-center group-hover:scale-105 transition-transform duration-700"
            />
          </div>
        ))}

        {/* Ambient Dark Scrim */}
        <div className="absolute inset-0 bg-gradient-to-t from-black/75 via-transparent to-black/30 z-20 pointer-events-none" />

        {/* Category Badge & Date */}
        <div className="absolute top-3 left-3 right-3 flex items-center justify-between z-30 pointer-events-none">
          <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-[11px] font-semibold bg-white/95 text-[#14532D] shadow-sm backdrop-blur-md border border-white/60">
            {categoryIcons[event.category]}
            <span>{event.category}</span>
          </span>

          <div className="flex items-center gap-1.5">
            {images.length > 1 && (
              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[10px] font-bold bg-black/60 text-[#EDE2D3] border border-white/20 backdrop-blur-md shadow-xs">
                <Layers className="w-3 h-3 text-[#C6E7CE]" />
                <span>
                  {currentIdx + 1}/{images.length}
                </span>
              </span>
            )}
            <span className="px-2.5 py-1 rounded-full text-[11px] font-semibold bg-black/65 text-white backdrop-blur-md border border-white/20">
              {event.date}
            </span>
          </div>
        </div>

        {/* Interactive Next/Prev on Hover */}
        {images.length > 1 && (
          <div className="absolute inset-x-2 top-1/2 -translate-y-1/2 flex items-center justify-between z-30 opacity-0 group-hover:opacity-100 transition-opacity duration-300">
            <button
              type="button"
              onClick={prevImg}
              aria-label="Previous image"
              className="p-1 rounded-full bg-black/60 text-white hover:bg-black/90 backdrop-blur-md border border-white/20 transition-transform active:scale-95 cursor-pointer"
            >
              <ChevronLeft className="w-3.5 h-3.5" />
            </button>
            <button
              type="button"
              onClick={nextImg}
              aria-label="Next image"
              className="p-1 rounded-full bg-black/60 text-white hover:bg-black/90 backdrop-blur-md border border-white/20 transition-transform active:scale-95 cursor-pointer"
            >
              <ChevronRight className="w-3.5 h-3.5" />
            </button>
          </div>
        )}

        {/* Progress dots */}
        {images.length > 1 && (
          <div className="absolute bottom-2.5 left-3 right-3 flex items-center justify-between z-30 pointer-events-none">
            <div className="flex items-center gap-1">
              {images.map((_, dotIdx) => (
                <span
                  key={dotIdx}
                  className={`h-1.5 rounded-full transition-all duration-300 ${
                    dotIdx === currentIdx
                      ? "w-4 bg-[#C6E7CE]"
                      : "w-1.5 bg-white/40"
                  }`}
                />
              ))}
            </div>
            <span className="text-[10px] text-white/80 font-medium">
              {isHovered ? "Auto-cycling" : "Hover to cycle"}
            </span>
          </div>
        )}
      </div>

      {/* Content */}
      <div className="p-5 flex-1 flex flex-col justify-between bg-white/90 backdrop-blur-sm">
        <div className="space-y-2">
          <h4 className="font-heading font-bold text-base sm:text-lg text-[#14532D] group-hover:text-[#0B3B20] transition-colors leading-snug">
            {event.title}
          </h4>
          <p className="text-stone-600 text-xs sm:text-sm leading-relaxed line-clamp-3">
            {event.description}
          </p>
        </div>

        <div className="mt-4 pt-3 border-t border-stone-100 flex items-center justify-between text-xs text-stone-500">
          <span className="text-[11px] font-medium text-stone-500">
            {event.citation || "School Archive"}
          </span>
          <Link
            href="/gallery"
            className="text-[#14532D] font-bold inline-flex items-center gap-1 group-hover:translate-x-1 transition-transform"
          >
            <span>Photos</span>
            <span>→</span>
          </Link>
        </div>
      </div>
    </div>
  );
}

export default function SchoolLifeEvents() {
  const leadImages = [
    "/images/school/achievements/rotary-shiksha-ratna-award.jpg",
    "/images/school/achievements/annual-exam-merit-shield.jpg",
    "/images/school/achievements/star-student-trophy-ceremony.jpg",
    "/images/school/achievements/annual-exam-merit-medal.jpg",
  ];
  const [leadImgIdx, setLeadImgIdx] = useState(0);
  const [leadHovered, setLeadHovered] = useState(false);

  // Hover auto-cycle lead card
  useEffect(() => {
    if (!leadHovered) return;
    const timer = setInterval(() => {
      setLeadImgIdx((prev) => (prev + 1) % leadImages.length);
    }, 1800);
    return () => clearInterval(timer);
  }, [leadHovered, leadImages.length]);

  return (
    <section className="relative py-16 sm:py-20 lg:py-24 bg-[#FAF8F2] border-b border-[#EDE2D3] overflow-hidden">
      {/* Ambient background depth blurs */}
      <div className="absolute top-10 left-1/4 w-96 h-96 rounded-full bg-emerald-500/10 blur-3xl pointer-events-none -z-10 animate-ambient-orb" />
      <div className="absolute bottom-10 right-1/4 w-96 h-96 rounded-full bg-[#D9C2B0]/25 blur-3xl pointer-events-none -z-10" />

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Header */}
        <div className="flex flex-col md:flex-row md:items-end justify-between gap-4 mb-12 sm:mb-14">
          <div className="space-y-3">
            <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-full bg-white border border-[#EDE2D3] text-[#6B4226] text-xs font-semibold uppercase tracking-wider shadow-xs">
              <Calendar className="w-3.5 h-3.5 text-[#14532D]" />
              <span>Campus Activities &amp; Highlights</span>
            </div>
            <h2 className="font-heading font-black text-2xl sm:text-3xl lg:text-4xl text-[#14532D] tracking-tight">
              School Life, Honors &amp; Annual Events
            </h2>
            <p className="text-stone-600 text-sm sm:text-base max-w-2xl leading-relaxed">
              Curated record of academic competitions, study excursions, cultural celebrations, and state honors earned by the students and administration of Al-Qalam Public School.
            </p>
          </div>

          <Link
            href="/gallery"
            className="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-xs font-semibold text-[#14532D] bg-white hover:bg-[#E8F3EA] border border-[#EDE2D3] transition-all hover:scale-105 shrink-0 shadow-xs active:scale-95"
          >
            <span>Explore 25+ Photos Gallery</span>
            <ArrowRight className="w-3.5 h-3.5 text-[#6B4226]" />
          </Link>
        </div>

        {/* Highlighted Lead Event: Rotary Shiksha Ratna State Recognition with Dynamic Photo Cycle */}
        <div
          onMouseEnter={() => setLeadHovered(true)}
          onMouseLeave={() => setLeadHovered(false)}
          className="relative group rounded-3xl border border-[#EDE2D3] p-6 sm:p-8 lg:p-10 mb-10 shadow-lg glass-panel hover:border-[#14532D]/40 transition-all duration-500 overflow-hidden"
        >
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-center">
            {/* Dynamic Photo Container */}
            <div className="lg:col-span-5 relative h-72 sm:h-96 w-full rounded-2xl overflow-hidden border border-stone-200/80 bg-stone-900 shadow-md">
              {leadImages.map((src, idx) => (
                <div
                  key={src}
                  className={`absolute inset-0 transition-all duration-700 ease-in-out ${
                    idx === leadImgIdx
                      ? "opacity-100 scale-100 z-10"
                      : "opacity-0 scale-105 pointer-events-none z-0"
                  }`}
                >
                  <Image
                    src={src}
                    alt={`Director Rahat Jahan State Honor - Photo ${idx + 1}`}
                    fill
                    sizes="(max-width: 1024px) 100vw, 40vw"
                    priority
                    className="object-cover object-center group-hover:scale-105 transition-transform duration-700"
                  />
                </div>
              ))}

              <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-transparent to-black/20 z-20 pointer-events-none" />

              <div className="absolute top-3 left-3 z-30 pointer-events-none">
                <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold bg-[#14532D] text-white shadow-xs backdrop-blur-md border border-white/20">
                  <Award className="w-3.5 h-3.5 text-[#EDE2D3]" />
                  <span>State Level Honor</span>
                </span>
              </div>

              {/* Progress Dots */}
              <div className="absolute bottom-3 left-3 right-3 flex items-center justify-between z-30 pointer-events-none">
                <div className="flex items-center gap-1.5">
                  {leadImages.map((_, dIdx) => (
                    <span
                      key={dIdx}
                      className={`h-1.5 rounded-full transition-all duration-300 ${
                        dIdx === leadImgIdx ? "w-5 bg-[#C6E7CE]" : "w-1.5 bg-white/40"
                      }`}
                    />
                  ))}
                </div>
                <span className="text-[10px] text-white/80 font-medium">
                  {leadHovered ? "Auto-cycling" : "Hover to cycle photos"}
                </span>
              </div>
            </div>

            <div className="lg:col-span-7 space-y-4">
              <div className="flex flex-wrap items-center gap-3 text-xs text-stone-500 font-medium">
                <span className="px-3 py-1 rounded-full bg-[#E8F3EA] text-[#14532D] font-bold border border-[#2F7D4A]/20">
                  Institutional Recognition
                </span>
                <span>•</span>
                <span className="inline-flex items-center gap-1.5 text-stone-700 font-semibold">
                  <Calendar className="w-3.5 h-3.5 text-[#6B4226]" />
                  <span>5 September 2014 (Teachers&apos; Day)</span>
                </span>
              </div>

              <h3 className="font-heading font-black text-xl sm:text-2xl lg:text-3xl text-[#14532D] leading-snug">
                Rotary Shiksha Ratna Samman Presented by Chief Minister Nitish Kumar
              </h3>

              <p className="text-stone-700 text-sm sm:text-base leading-relaxed">
                Director Rahat Jahan was conferred with the prestigious <strong>Rotary Shiksha Ratna Samman</strong> by <strong>Shri Nitish Kumar</strong>, Hon&apos;ble Chief Minister of Bihar, organized by Rotary Club Patna City on the occasion of Teachers&apos; Day. This honor formally acknowledged Al-Qalam Public School&apos;s devoted service to primary and foundational education in the Gulzarbagh and Patna City region.
              </p>

              <div className="pt-2 flex flex-wrap items-center justify-between gap-4 text-xs text-stone-500">
                <div className="flex items-center gap-2">
                  <span className="font-semibold text-[#6B4226]">Conferred by:</span>
                  <span>Rotary Club Patna City &amp; Govt. of Bihar dignitaries</span>
                </div>
                <Link
                  href="/gallery"
                  className="font-bold text-[#14532D] inline-flex items-center gap-1 hover:underline"
                >
                  <span>View in Gallery</span>
                  <span>→</span>
                </Link>
              </div>
            </div>
          </div>
        </div>

        {/* Grid of Other Verified Events */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {VERIFIED_SCHOOL_EVENTS.slice(1).map((event, idx) => (
            <DynamicEventCard key={event.id} event={event} index={idx} />
          ))}
        </div>
      </div>
    </section>
  );
}
