import React from "react";
import type { Metadata } from "next";
import { Image as ImageIcon, Info } from "lucide-react";
import SectionHeading from "@/components/SectionHeading";
import GalleryGrid from "@/components/GalleryGrid";
import CTA from "@/components/CTA";
import ScrollReveal from "@/components/ScrollReveal";

export const metadata: Metadata = {
  title: "School Gallery",
  description:
    "Explore photos and visual highlights of Al-Qalam Public School, Gulzarbagh, Patna. Classrooms, activities, smart learning, and campus environment.",
};

export default function GalleryPage() {
  return (
    <div className="bg-white">
      {/* Banner */}
      <section className="bg-forest-hero text-white py-16 sm:py-20 border-b border-[#0d3b1f]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <ScrollReveal variant="fade-up">
            <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#0d3b1f]/60 border border-[#2F7D4A]/40 text-[#EDE2D3] text-xs font-bold uppercase tracking-wider mb-4">
              <ImageIcon className="w-4 h-4 text-[#E8F3EA]" />
              <span>Campus Moments</span>
            </div>
            <h1 className="text-3xl sm:text-4xl lg:text-5xl font-black tracking-tight text-white">
              School Gallery
            </h1>
            <p className="mt-3 text-base sm:text-lg text-[#EDE2D3] max-w-2xl mx-auto">
              A visual overview of student activities, learning spaces, and campus life at Al-Qalam Public School.
            </p>
          </ScrollReveal>
        </div>
      </section>

      {/* Main Gallery Area */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
            <SectionHeading
              badge="Categories"
              title="Life & Learning at Al-Qalam"
              subtitle="Click on any card to view detailed description and preview. Official photo updates are added regularly by the administration."
              center
            />
          </ScrollReveal>

          <ScrollReveal variant="fade-up" delay={100}>
            <GalleryGrid />
          </ScrollReveal>

          {/* Admin Notice on Image Uploads */}
          <ScrollReveal variant="fade-up" delay={150}>
            <div className="max-w-3xl mx-auto mt-16 bg-[#FAF8F2] border border-[#EDE2D3] rounded-2xl p-5 flex items-start gap-3 text-xs text-stone-600 shadow-xs">
              <Info className="w-5 h-5 text-[#6B4226] shrink-0 mt-0.5" />
              <div className="leading-relaxed">
                <span className="font-bold text-[#14532D]">Photography Notice:</span> Authentic photographs of campus activities, events, and classrooms are being compiled for publication. In accordance with student privacy guidelines, event photo albums will be updated sequentially.
              </div>
            </div>
          </ScrollReveal>
        </div>
      </section>

      {/* CTA */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <ScrollReveal variant="fade-up">
          <CTA
            title="Experience Al-Qalam in Person"
            subtitle="We warmly welcome parents to visit our campus at Ashok Rajpath Rd, Gulzarbagh, Alamganj, Patna."
            primaryBtnText="Plan a Campus Visit"
            primaryBtnHref="/contact"
          />
        </ScrollReveal>
      </section>
    </div>
  );
}
