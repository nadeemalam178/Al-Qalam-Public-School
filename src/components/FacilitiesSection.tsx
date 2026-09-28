import React from "react";
import Image from "next/image";
import Link from "next/link";
import { ArrowRight, MonitorPlay, ShieldCheck, Check } from "lucide-react";
import { schoolImages } from "@/data/schoolImages";

export default function FacilitiesSection() {
  const facilities = [
    {
      id: "smart-classes",
      title: "Interactive Smart Classes",
      badge: "Modern Learning",
      description:
        "Audio-visual learning modules and digital teaching aids help primary students understand concepts in mathematics, sciences, and languages with visual clarity and interest.",
      image: schoolImages.smartClass.src,
      alt: schoolImages.smartClass.alt,
      icon: MonitorPlay,
      points: [
        "Audio-visual multimedia lessons",
        "Visual storytelling for foundational subjects",
        "Clear demonstration of abstract concepts",
        "Promotes attentive classroom interaction",
      ],
    },
    {
      id: "campus-safety",
      title: "Campus Safety & Supervised Corridors",
      badge: "Campus Oversight",
      description:
        "Monitored security cameras safeguard school gates and primary corridors. CCTV is maintained as part of overall campus discipline and child welfare alongside attentive staff supervision.",
      image: schoolImages.cctv.src,
      alt: schoolImages.cctv.alt,
      icon: ShieldCheck,
      points: [
        "Monitored surveillance covering gates and corridors",
        "Assists in maintaining an orderly learning environment",
        "Supports child safety and supervised movement",
        "Gate registration protocol for visitors",
      ],
    },
  ];

  return (
    <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Heading */}
        <div className="max-w-3xl mx-auto text-center mb-12 sm:mb-14 space-y-3">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/25 text-xs font-semibold uppercase tracking-wider">
            <span>Campus Infrastructure</span>
          </div>
          <h2 className="font-heading font-black text-2xl sm:text-3xl lg:text-4xl text-[#14532D] tracking-tight">
            Learning in a Safe, Technology-Enabled Environment
          </h2>
          <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
            Our campus at Ashok Rajpath Rd, Gulzarbagh combines modern audio-visual teaching aids with reliable safety oversight for student well-being.
          </p>
        </div>

        {/* Side-by-Side Facility Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 lg:gap-10">
          {facilities.map((facility) => {
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
                        Key Aspects:
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

                <div className="p-6 sm:p-7 pt-0 border-t border-stone-100 flex items-center justify-between text-xs">
                  <span className="text-stone-400">Verified Campus Feature</span>
                  <Link
                    href="/facilities"
                    className="font-semibold text-[#14532D] hover:underline flex items-center gap-1"
                  >
                    <span>More details</span>
                    <ArrowRight className="w-3 h-3 text-[#6B4226]" />
                  </Link>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
