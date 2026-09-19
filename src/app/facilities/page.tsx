import React from "react";
import type { Metadata } from "next";
import { ShieldCheck, Lock, CheckCircle, Info } from "lucide-react";
import SectionHeading from "@/components/SectionHeading";
import FacilityCard from "@/components/FacilityCard";
import CTA from "@/components/CTA";
import ScrollReveal from "@/components/ScrollReveal";
import { SCHOOL_DATA } from "@/data/schoolData";

export const metadata: Metadata = {
  title: "Facilities",
  description:
    "Confirmed campus facilities at Al-Qalam Public School, Gulzarbagh, Patna. Featuring active CCTV security surveillance and interactive Smart Classes.",
};

export default function FacilitiesPage() {
  return (
    <div className="bg-white">
      {/* Page Banner */}
      <section className="bg-forest-hero text-white py-16 sm:py-20 border-b border-[#0d3b1f]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <ScrollReveal variant="fade-up">
            <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#0d3b1f]/60 border border-[#2F7D4A]/40 text-[#EDE2D3] text-xs font-bold uppercase tracking-wider mb-4">
              <ShieldCheck className="w-4 h-4 text-[#E8F3EA]" />
              <span>Campus Infrastructure</span>
            </div>
            <h1 className="text-3xl sm:text-4xl lg:text-5xl font-black tracking-tight text-white">
              School Facilities
            </h1>
            <p className="mt-3 text-base sm:text-lg text-[#EDE2D3] max-w-2xl mx-auto">
              Prioritizing child safety and modern learning through verified, high-quality infrastructure at our Gulzarbagh campus.
            </p>
          </ScrollReveal>
        </div>
      </section>

      {/* Confirmed Facilities Detailed Section - White */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
            <SectionHeading
              badge="Confirmed Facilities"
              title="Essential Amenities for Student Development"
              subtitle="Explore our active security and educational technology facilities."
              center
            />
          </ScrollReveal>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-5xl mx-auto">
            {SCHOOL_DATA.confirmedFacilities.map((facility, idx) => (
              <ScrollReveal key={facility.id} variant="fade-up" delay={idx * 120}>
                <FacilityCard facility={facility} featured />
              </ScrollReveal>
            ))}
          </div>

          {/* Extensibility & Transparency Notice */}
          <ScrollReveal variant="fade-up" delay={150}>
            <div className="max-w-3xl mx-auto mt-12 bg-[#FAF8F2] border border-[#EDE2D3] rounded-2xl p-5 flex items-start gap-3 text-xs text-stone-600 shadow-xs">
              <Info className="w-5 h-5 text-[#14532D] shrink-0 mt-0.5" />
              <div className="leading-relaxed">
                <span className="font-bold text-[#14532D]">Campus Infrastructure Note:</span> Al-Qalam Public School continually enhances learning spaces. Additional confirmed facilities and infrastructural updates will be listed here as verified by the administration.
              </div>
            </div>
          </ScrollReveal>
        </div>
      </section>

      {/* Safety & Learning Standards - Deep Forest Green */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="scale-in">
            <div className="bg-gradient-to-br from-[#0d3b1f] via-[#14532D] to-[#166534] rounded-3xl p-8 sm:p-12 text-white shadow-md border border-[#2F7D4A]/40">
              <div className="max-w-3xl mx-auto text-center space-y-4">
                <div className="w-14 h-14 rounded-2xl bg-[#E8F3EA]/15 text-[#EDE2D3] flex items-center justify-center mx-auto border border-[#EDE2D3]/20">
                  <Lock className="w-7 h-7" />
                </div>
                <h3 className="text-2xl sm:text-3xl font-black text-white">
                  Our Campus Safety Commitment
                </h3>
                <p className="text-[#EDE2D3] text-sm sm:text-base leading-relaxed">
                  Parents entrust us with what is most precious to them. Through strict gate verification, continuous CCTV camera surveillance across corridors, and attentive staff supervision, we strive to maintain a disciplined, peaceful learning haven for every boy and girl.
                </p>
                <div className="pt-4 flex flex-wrap items-center justify-center gap-4 text-xs font-semibold text-[#EDE2D3]">
                  <span className="flex items-center gap-1.5 bg-[#0a2916]/60 px-3 py-1.5 rounded-lg border border-[#2F7D4A]/30">
                    <CheckCircle className="w-3.5 h-3.5 text-[#E8F3EA]" />
                    Monitored Gate Access
                  </span>
                  <span className="flex items-center gap-1.5 bg-[#0a2916]/60 px-3 py-1.5 rounded-lg border border-[#2F7D4A]/30">
                    <CheckCircle className="w-3.5 h-3.5 text-[#E8F3EA]" />
                    Corridor CCTV Coverage
                  </span>
                  <span className="flex items-center gap-1.5 bg-[#0a2916]/60 px-3 py-1.5 rounded-lg border border-[#2F7D4A]/30">
                    <CheckCircle className="w-3.5 h-3.5 text-[#E8F3EA]" />
                    Staff Accompanied Movement
                  </span>
                </div>
              </div>
            </div>
          </ScrollReveal>
        </div>
      </section>

      {/* CTA */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <ScrollReveal variant="fade-up">
          <CTA
            title="Schedule a Campus Visit"
            subtitle="Parents are invited to visit the Al-Qalam Public School campus at Ashok Rajpath Rd, Gulzarbagh to witness our facilities in person."
            primaryBtnText="Contact Admissions Desk"
            primaryBtnHref="/contact"
          />
        </ScrollReveal>
      </section>
    </div>
  );
}
