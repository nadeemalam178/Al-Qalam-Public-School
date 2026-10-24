import React from "react";
import type { Metadata } from "next";
import Image from "next/image";
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
          <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-md bg-white/10 border border-white/20 text-emerald-200 text-xs font-bold uppercase tracking-wider backdrop-blur-xs">
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
            <h2 className="font-heading font-bold text-2xl sm:text-3xl text-stone-900 tracking-tight">
              School Address & Inquiries
            </h2>
            <p className="text-stone-600 text-sm leading-relaxed">
              Visit our campus located on Ashok Rajpath Road or submit your query directly to our school desk.
            </p>
          </div>

          <ContactSection />

          {/* Campus Building Landmark Card */}
          <div className="mt-12 bg-white rounded-2xl border border-stone-200 overflow-hidden shadow-xs">
            <div className="grid grid-cols-1 md:grid-cols-12 gap-0 items-center">
              <div className="md:col-span-5 relative h-72 sm:h-80 md:h-full min-h-[300px] bg-stone-100">
                <Image
                  src="/images/school/campus/school-building.png"
                  alt="Al-Qalam Public School Building - Hashmi Manzil in Loharwa Ghat Lane"
                  fill
                  className="object-cover object-center"
                  sizes="(max-width: 768px) 100vw, 40vw"
                />
                <div className="absolute top-3 left-3 bg-[#14532D] text-white text-[11px] font-bold px-3 py-1 rounded-full shadow-xs">
                  Campus Landmark
                </div>
              </div>
              <div className="md:col-span-7 p-6 sm:p-8 space-y-4">
                <div className="space-y-1">
                  <span className="text-xs font-bold uppercase tracking-wider text-[#14532D]">
                    How to Recognize Our Building
                  </span>
                  <h3 className="font-heading font-bold text-xl sm:text-2xl text-stone-900">
                    Hashmi Manzil • Primary Learning Wing
                  </h3>
                  <p className="text-xs text-stone-500">
                    Loharwa Ghat Lane, Alamganj, Patna – 800007
                  </p>
                </div>
                <p className="text-stone-600 text-xs sm:text-sm leading-relaxed">
                  Our school operates from this multi-story building located inside Loharwa Ghat Lane. When walking or driving down from Ashok Rajpath Road (directly opposite Jashn Palace Marriage Hall), look for this distinctive building featuring the yellow <strong>Al-Qalam Public School</strong> board.
                </p>
                <div className="grid grid-cols-2 gap-3 pt-2">
                  <div className="p-3 rounded-lg bg-stone-50 border border-stone-200/80 text-xs text-stone-700">
                    <span className="font-bold block text-stone-900 mb-0.5">Building Name</span>
                    <span>Hashmi Manzil</span>
                  </div>
                  <div className="p-3 rounded-lg bg-stone-50 border border-stone-200/80 text-xs text-stone-700">
                    <span className="font-bold block text-stone-900 mb-0.5">Main Landmark</span>
                    <span>Opp. Jashn Palace</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* Detailed Transit, Landmark, and Visitor Cards */}
          <div className="mt-14 bg-stone-50/70 border border-stone-200 rounded-xl p-6 sm:p-8">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div className="space-y-2">
                <div className="flex items-center gap-2 text-stone-900 font-bold text-sm">
                  <MapPin className="w-4 h-4 text-[#14532D]" />
                  <span>Prominent Landmark</span>
                </div>
                <p className="text-xs text-stone-600 leading-relaxed">
                  Located directly opposite <strong>Jashn Palace Marriage Hall</strong> on Ashok Rajpath Rd, Agarwal Tola, Loharwa Ghat.
                </p>
              </div>

              <div className="space-y-2">
                <div className="flex items-center gap-2 text-stone-900 font-bold text-sm">
                  <Navigation className="w-4 h-4 text-[#14532D]" />
                  <span>Postal Locality</span>
                </div>
                <p className="text-xs text-stone-600 leading-relaxed">
                  Gulzarbagh / Alamganj area, Patna, Bihar, PIN: <strong>800007</strong>. Accessible via all major Ashok Rajpath transport corridors.
                </p>
              </div>

              <div className="space-y-2">
                <div className="flex items-center gap-2 text-stone-900 font-bold text-sm">
                  <ShieldCheck className="w-4 h-4 text-[#14532D]" />
                  <span>Visitor Check-In</span>
                </div>
                <p className="text-xs text-stone-600 leading-relaxed">
                  For student safety and campus discipline, all visiting parents are kindly requested to sign in at the main gate.
                </p>
              </div>
            </div>

            <div className="mt-6 pt-5 border-t border-stone-200/80 flex flex-col sm:flex-row items-center justify-between gap-4">
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
