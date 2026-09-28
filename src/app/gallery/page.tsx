import React from "react";
import type { Metadata } from "next";
import Link from "next/link";
import { Image as ImageIcon, ArrowRight, Sparkles, Layers, Award } from "lucide-react";
import GalleryGrid from "@/components/GalleryGrid";

export const metadata: Metadata = {
  title: "School Life & Photo Gallery (25+ Authentic Photographs)",
  description:
    "Explore 25+ authentic photographs of students, classrooms, drawing competitions, educational excursions, and achievement awards at Al-Qalam Public School, Gulzarbagh, Patna.",
};

export default function GalleryPage() {
  return (
    <div className="bg-white min-h-screen">
      {/* Banner with Ambient Glowing Orbs */}
      <section className="relative bg-forest-hero text-white py-14 sm:py-20 lg:py-24 border-b border-[#0B3B20] overflow-hidden">
        {/* Ambient background depth blurs */}
        <div className="absolute -top-20 -left-20 w-96 h-96 rounded-full bg-emerald-400/15 blur-3xl pointer-events-none animate-ambient-orb" />
        <div className="absolute top-1/2 -right-20 w-96 h-96 rounded-full bg-amber-400/10 blur-3xl pointer-events-none" />

        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-4 relative z-10">
          <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-full bg-white/10 border border-white/20 text-[#EDE2D3] text-xs font-semibold uppercase tracking-wider backdrop-blur-md">
            <Sparkles className="w-3.5 h-3.5 text-[#C6E7CE]" />
            <span>Official Photo Archive</span>
          </div>

          <h1 className="font-heading font-black text-3xl sm:text-4xl lg:text-6xl text-white tracking-tight leading-tight">
            School Life &amp; Visual Gallery
          </h1>

          <p className="text-base sm:text-lg text-stone-200 max-w-2xl mx-auto leading-relaxed">
            Authentic photographs of classroom learning, creative arts, study excursions, and institutional honors at Al-Qalam Public School, Gulzarbagh, Patna.
          </p>

          {/* Quick Metrics Bar */}
          <div className="pt-4 flex flex-wrap items-center justify-center gap-4 sm:gap-6 text-xs text-stone-200">
            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-white/10 backdrop-blur-md border border-white/15">
              <ImageIcon className="w-4 h-4 text-[#C6E7CE]" />
              <span className="font-bold text-white">25+ Authentic Photos</span>
            </div>

            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-white/10 backdrop-blur-md border border-white/15">
              <Layers className="w-4 h-4 text-[#C6E7CE]" />
              <span>Dynamic Hover-Cycle Albums</span>
            </div>

            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-white/10 backdrop-blur-md border border-white/15">
              <Award className="w-4 h-4 text-[#C6E7CE]" />
              <span>Rotary Shiksha Ratna Milestone</span>
            </div>
          </div>
        </div>
      </section>

      {/* Main Gallery Grid with Depth Backdrops */}
      <section className="relative py-14 sm:py-20 bg-white border-b border-[#E7E5E4] overflow-hidden">
        {/* Soft atmospheric depth blurs */}
        <div className="absolute top-20 left-10 w-96 h-96 rounded-full bg-emerald-500/[0.04] blur-3xl pointer-events-none -z-10" />
        <div className="absolute bottom-20 right-10 w-96 h-96 rounded-full bg-amber-500/[0.04] blur-3xl pointer-events-none -z-10" />

        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="max-w-3xl mx-auto text-center mb-10 space-y-2">
            <h2 className="font-heading font-black text-2xl sm:text-3xl text-[#14532D] tracking-tight">
              Life and Learning at Al-Qalam
            </h2>
            <p className="text-stone-600 text-sm leading-relaxed">
              Hover over any card to automatically cycle through album photographs. Toggle the &ldquo;Auto-Cycle&rdquo; mode for continuous playback, or click any card for fullscreen preview.
            </p>
          </div>

          <GalleryGrid />
        </div>
      </section>

      {/* Campus Visit Invitation */}
      <section className="relative py-16 sm:py-20 bg-[#FAF8F2] overflow-hidden">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-5">
          <h2 className="font-heading font-black text-2xl sm:text-3xl text-[#14532D] tracking-tight">
            Experience Al-Qalam in Person
          </h2>
          <p className="text-stone-600 text-sm sm:text-base leading-relaxed max-w-2xl mx-auto">
            We warmly invite parents to visit our campus at Ashok Rajpath Rd, Gulzarbagh to witness our classrooms, smart learning systems, and educational atmosphere firsthand.
          </p>
          <div className="pt-2 flex flex-wrap items-center justify-center gap-4">
            <Link
              href="/admissions"
              className="btn-primary px-6 py-3 rounded-xl text-sm font-semibold text-white bg-[#14532D] hover:bg-[#0B3B20] shadow-md transition-all hover:scale-105 active:scale-95 flex items-center gap-2"
            >
              <span>Submit Admission Enquiry</span>
              <ArrowRight className="w-4 h-4 text-[#EDE2D3]" />
            </Link>
            <Link
              href="/contact"
              className="btn-primary px-6 py-3 rounded-xl text-sm font-semibold text-stone-700 bg-white hover:bg-stone-50 border border-[#EDE2D3] transition-all hover:scale-105 active:scale-95 shadow-xs"
            >
              <span>Campus Visit Directions</span>
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}
