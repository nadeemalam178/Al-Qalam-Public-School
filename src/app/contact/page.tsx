import React from "react";
import type { Metadata } from "next";
import { MapPin, Navigation, ShieldCheck } from "lucide-react";
import ContactSection from "@/components/ContactSection";
import { SCHOOL_DATA } from "@/data/schoolData";

export const metadata: Metadata = {
  title: "Contact & Campus Location",
  description:
    "Contact Al-Qalam Public School in Gulzarbagh, Patna. Address, directions, campus visiting guidelines, and administrative enquiry desk.",
};

export default function ContactPage() {
  return (
    <div className="bg-white">
      {/* Banner */}
      <section className="bg-forest-hero text-white py-14 sm:py-18 lg:py-20 border-b border-[#0B3B20]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-3">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#072413] border border-[#2F7D4A]/40 text-[#EDE2D3] text-xs font-semibold uppercase tracking-wider">
            <MapPin className="w-3.5 h-3.5" />
            <span>Campus Desk</span>
          </div>
          <h1 className="font-heading font-black text-3xl sm:text-4xl lg:text-5xl text-white tracking-tight">
            Contact Al-Qalam Public School
          </h1>
          <p className="text-base sm:text-lg text-stone-200 max-w-2xl mx-auto leading-relaxed">
            We are here to assist parents with admissions, academic queries, and campus appointments in Gulzarbagh, Patna.
          </p>
        </div>
      </section>

      {/* Main Contact Section */}
      <section className="py-16 sm:py-20 bg-white border-b border-[#E7E5E4]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="max-w-3xl mx-auto text-center mb-12 space-y-2">
            <h2 className="font-heading font-black text-2xl sm:text-3xl text-[#14532D] tracking-tight">
              School Address & Inquiries
            </h2>
            <p className="text-stone-600 text-sm leading-relaxed">
              Visit our campus located on Ashok Rajpath Road or submit your query directly to our school desk.
            </p>
          </div>

          <ContactSection />

          {/* Detailed Transit, Landmark, and Visitor Cards */}
          <div className="mt-14 bg-[#FAF8F2] border border-[#EDE2D3] rounded-2xl p-6 sm:p-8">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div className="space-y-2">
                <div className="flex items-center gap-2 text-[#14532D] font-bold text-sm">
                  <MapPin className="w-4 h-4 text-[#166534]" />
                  <span>Prominent Landmark</span>
                </div>
                <p className="text-xs text-stone-600 leading-relaxed">
                  Located directly opposite <strong>Jashn Palace Marriage Hall</strong> on Ashok Rajpath Rd, Agarwal Tola, Loharwa Ghat.
                </p>
              </div>

              <div className="space-y-2">
                <div className="flex items-center gap-2 text-[#14532D] font-bold text-sm">
                  <Navigation className="w-4 h-4 text-[#166534]" />
                  <span>Postal Locality</span>
                </div>
                <p className="text-xs text-stone-600 leading-relaxed">
                  Gulzarbagh / Alamganj area, Patna, Bihar, PIN: <strong>800007</strong>. Accessible via all major Ashok Rajpath transport corridors.
                </p>
              </div>

              <div className="space-y-2">
                <div className="flex items-center gap-2 text-[#14532D] font-bold text-sm">
                  <ShieldCheck className="w-4 h-4 text-[#166534]" />
                  <span>Visitor Check-In</span>
                </div>
                <p className="text-xs text-stone-600 leading-relaxed">
                  For student safety and campus discipline, all visiting parents are kindly requested to sign in at the main gate.
                </p>
              </div>
            </div>

            <div className="mt-6 pt-5 border-t border-[#EDE2D3] flex flex-col sm:flex-row items-center justify-between gap-4">
              <p className="text-xs text-stone-600">
                {SCHOOL_DATA.name} • {SCHOOL_DATA.address.fullAddress}
              </p>
              <a
                href={SCHOOL_DATA.address.googleMapsUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="btn-primary px-4 py-2 rounded-lg text-xs font-semibold text-white bg-[#14532D] hover:bg-[#0B3B20] transition-colors"
              >
                <span>Open Google Maps</span>
              </a>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
