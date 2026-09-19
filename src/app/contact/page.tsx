import React from "react";
import type { Metadata } from "next";
import { MapPin, Navigation, ShieldCheck } from "lucide-react";
import SectionHeading from "@/components/SectionHeading";
import ContactSection from "@/components/ContactSection";
import CTA from "@/components/CTA";

export const metadata: Metadata = {
  title: "Contact Us",
  description:
    "Contact Al-Qalam Public School in Gulzarbagh, Patna. Address, directions, campus visit information, and enquiry desk.",
};

export default function ContactPage() {
  return (
    <div className="bg-white">
      {/* Banner */}
      <section className="bg-forest-hero text-white py-16 sm:py-20 border-b border-[#0d3b1f]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#0d3b1f]/60 border border-[#2F7D4A]/40 text-[#EDE2D3] text-xs font-bold uppercase tracking-wider mb-4">
            <MapPin className="w-4 h-4 text-[#E8F3EA]" />
            <span>Campus Desk</span>
          </div>
          <h1 className="text-3xl sm:text-4xl lg:text-5xl font-black tracking-tight text-white">
            Contact Al-Qalam Public School
          </h1>
          <p className="mt-3 text-base sm:text-lg text-[#EDE2D3] max-w-2xl mx-auto">
            We are here to assist parents with admissions, academic queries, and campus appointments.
          </p>
        </div>
      </section>

      {/* Main Contact Section - White */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <SectionHeading
            badge="Get in Touch"
            title="School Address & Inquiries"
            subtitle="Visit our campus located on Ashok Rajpath Road or submit your query online."
            center
          />

          <ContactSection />

          {/* Detailed Landmark & Transit Card - Light Cream (#FAF8F2) */}
          <div className="mt-12 bg-[#FAF8F2] border border-[#EDE2D3] rounded-3xl p-6 sm:p-8">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div className="space-y-2">
                <div className="flex items-center gap-2 text-[#14532D] font-bold text-sm">
                  <MapPin className="w-4 h-4 text-[#166534]" />
                  <span>Key Landmark</span>
                </div>
                <p className="text-xs text-stone-600 leading-relaxed">
                  Located directly opposite <strong>Jashn Palace Marriage Hall</strong> on Ashok Rajpath Rd, Agarwal Tola, Loharwa Ghat.
                </p>
              </div>

              <div className="space-y-2">
                <div className="flex items-center gap-2 text-[#14532D] font-bold text-sm">
                  <Navigation className="w-4 h-4 text-[#166534]" />
                  <span>Locality & Postal Area</span>
                </div>
                <p className="text-xs text-stone-600 leading-relaxed">
                  Gulzarbagh / Alamganj locality, Patna, Bihar, PIN: <strong>800007</strong>. Accessible via major Ashok Rajpath transit lines.
                </p>
              </div>

              <div className="space-y-2">
                <div className="flex items-center gap-2 text-[#14532D] font-bold text-sm">
                  <ShieldCheck className="w-4 h-4 text-[#166534]" />
                  <span>Campus Visitor Protocol</span>
                </div>
                <p className="text-xs text-stone-600 leading-relaxed">
                  For student safety, all visitors are requested to sign in at the campus security gate monitored by CCTV.
                </p>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <CTA
          title="Interested in Enrolling Your Child?"
          subtitle="Explore our admissions procedure and submit an enquiry online."
          primaryBtnText="Go to Admissions Page"
          primaryBtnHref="/admissions"
        />
      </section>
    </div>
  );
}
