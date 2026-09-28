import React from "react";
import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import { ShieldCheck, MonitorPlay, Check, MapPin, ArrowRight } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";
import { schoolImages } from "@/data/schoolImages";

export const metadata: Metadata = {
  title: "School Facilities & Campus Infrastructure",
  description:
    "Confirmed campus infrastructure at Al-Qalam Public School, Gulzarbagh, Patna. Interactive Smart Classes and monitored CCTV security oversight supporting student well-being.",
};

export default function FacilitiesPage() {
  const verifiedFacilities = [
    {
      id: "smart-classes",
      title: "Interactive Smart Classes",
      badge: "Modern Learning",
      description:
        "Classrooms are equipped with audio-visual smart teaching aids to help primary learners understand abstract scientific, mathematical, and linguistic topics through multimedia illustrations, diagrams, and educational stories.",
      image: schoolImages.smartClass.src,
      alt: schoolImages.smartClass.alt,
      icon: MonitorPlay,
      points: [
        "Audio-visual multimedia lessons reinforcing textbooks",
        "Visual storytelling for foundational subjects",
        "Clear step-by-step demonstrations of math patterns",
        "Encourages active student questions and interaction",
      ],
    },
    {
      id: "cctv-monitoring",
      title: "Campus Safety & CCTV Monitoring",
      badge: "Campus Oversight",
      description:
        "Student safety and orderly campus discipline are supported by closed-circuit cameras monitoring main school entrance gates, primary corridors, and communal spaces. CCTV surveillance is integrated into the school's overall care and supervision policy.",
      image: schoolImages.cctv.src,
      alt: schoolImages.cctv.alt,
      icon: ShieldCheck,
      points: [
        "Monitored surveillance covering gates and school corridors",
        "Assists in maintaining an orderly, disciplined environment",
        "Supports child safety and supervised movement",
        "Mandatory visitor registration at campus entrance gate",
      ],
    },
  ];

  return (
    <div className="bg-white">
      {/* Page Banner */}
      <section className="bg-forest-hero text-white py-14 sm:py-18 lg:py-20 border-b border-[#0B3B20]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-3">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#072413] border border-[#2F7D4A]/40 text-[#EDE2D3] text-xs font-semibold uppercase tracking-wider">
            <ShieldCheck className="w-3.5 h-3.5" />
            <span>Campus Infrastructure</span>
          </div>
          <h1 className="font-heading font-black text-3xl sm:text-4xl lg:text-5xl text-white tracking-tight">
            School Facilities
          </h1>
          <p className="text-base sm:text-lg text-stone-200 max-w-2xl mx-auto leading-relaxed">
            Prioritizing child safety, modern learning aids, and a disciplined educational environment at our Gulzarbagh campus.
          </p>
        </div>
      </section>

      {/* Main Facilities Section */}
      <section className="py-16 sm:py-20 bg-white border-b border-[#E7E5E4]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="max-w-3xl mx-auto text-center mb-12 sm:mb-14 space-y-3">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#FAF8F2] border border-[#EDE2D3] text-[#6B4226] text-xs font-semibold uppercase tracking-wider">
              <span>Verified Infrastructure</span>
            </div>
            <h2 className="font-heading font-black text-2xl sm:text-3xl lg:text-4xl text-[#14532D] tracking-tight">
              Learning in a Safe, Technology-Enabled Environment
            </h2>
            <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
              Explore the educational technology and campus security measures that support everyday learning at Al-Qalam Public School.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 lg:gap-10 max-w-5xl mx-auto">
            {verifiedFacilities.map((facility) => {
              const IconComp = facility.icon;
              return (
                <div
                  key={facility.id}
                  className="bg-white rounded-2xl overflow-hidden border border-[#E7E5E4] card-subtle flex flex-col justify-between"
                >
                  <div>
                    <div className="img-zoom-box relative h-56 sm:h-64 w-full bg-stone-900 border-b border-stone-200">
                      <Image
                        src={facility.image}
                        alt={facility.alt}
                        fill
                        sizes="(max-width: 768px) 100vw, 50vw"
                        className="img-zoom-target object-cover object-center"
                      />
                      <div className="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent pointer-events-none" />

                      <div className="absolute top-3 left-3">
                        <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-md text-xs font-semibold bg-white/95 text-[#14532D] shadow-xs backdrop-blur-xs">
                          <IconComp className="w-3.5 h-3.5" />
                          <span>{facility.badge}</span>
                        </span>
                      </div>
                    </div>

                    <div className="p-6 sm:p-7 space-y-4">
                      <h3 className="font-heading font-bold text-xl sm:text-2xl text-[#14532D]">
                        {facility.title}
                      </h3>

                      <p className="text-stone-600 text-sm leading-relaxed">
                        {facility.description}
                      </p>

                      <div className="pt-2 border-t border-stone-100">
                        <p className="text-xs font-bold text-stone-500 uppercase tracking-wider mb-2.5">
                          Key Features:
                        </p>
                        <ul className="space-y-2">
                          {facility.points.map((pt, i) => (
                            <li key={i} className="flex items-center gap-2 text-xs text-stone-700">
                              <span className="w-4 h-4 rounded-full bg-[#E8F3EA] text-[#14532D] flex items-center justify-center shrink-0">
                                <Check className="w-2.5 h-2.5" />
                              </span>
                              <span>{pt}</span>
                            </li>
                          ))}
                        </ul>
                      </div>
                    </div>
                  </div>

                  <div className="p-6 sm:p-7 pt-0 border-t border-stone-100 flex items-center justify-between text-xs text-stone-500">
                    <span>Verified Campus Amenity</span>
                    <span className="text-[#14532D] font-semibold">Gulzarbagh Campus</span>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      {/* Safety & Gate Protocol Card */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="bg-white rounded-2xl p-6 sm:p-8 border border-[#E7E5E4] space-y-4">
            <h3 className="font-heading font-bold text-xl text-[#14532D]">
              Campus Visitor & Safety Protocol
            </h3>
            <p className="text-stone-600 text-sm leading-relaxed">
              To preserve student focus and security during school operation hours, all parent visits, deliveries, and enquiries must be checked in at the main gate. The campus entrance and primary corridors remain continuously monitored.
            </p>
            <div className="flex items-center gap-2 text-xs text-stone-500 pt-2 border-t border-stone-100">
              <MapPin className="w-4 h-4 text-[#6B4226]" />
              <span>{SCHOOL_DATA.address.street}, {SCHOOL_DATA.address.landmark}, {SCHOOL_DATA.address.city}</span>
            </div>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-16 sm:py-20 bg-white">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-5">
          <h2 className="font-heading font-black text-2xl sm:text-3xl text-[#14532D] tracking-tight">
            Schedule a Campus Walkthrough
          </h2>
          <p className="text-stone-600 text-sm sm:text-base leading-relaxed max-w-2xl mx-auto">
            Parents seeking admission for their children are invited to visit the Al-Qalam Public School campus to review classrooms and speak with our admissions desk.
          </p>
          <div className="pt-2 flex flex-wrap items-center justify-center gap-4">
            <Link
              href="/admissions"
              className="btn-primary px-6 py-3 rounded-lg text-sm font-semibold text-white bg-[#14532D] hover:bg-[#0B3B20] shadow-xs transition-colors flex items-center gap-2"
            >
              <span>Submit Admission Enquiry</span>
              <ArrowRight className="w-4 h-4 text-[#EDE2D3]" />
            </Link>
            <Link
              href="/contact"
              className="btn-primary px-6 py-3 rounded-lg text-sm font-semibold text-stone-700 bg-[#FAF8F2] hover:bg-stone-100 border border-[#EDE2D3] transition-colors"
            >
              <span>View Location on Map</span>
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}
