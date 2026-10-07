import React from "react";
import Image from "next/image";
import Link from "next/link";
import {
  MonitorPlay,
  ShieldCheck,
  Bus,
  Droplets,
  CheckCircle2,
  ArrowRight,
  Sparkles,
} from "lucide-react";
import { schoolImages } from "@/data/schoolImages";

interface FacilityItem {
  id: string;
  title: string;
  badge: string;
  badgeBg: string;
  description: string;
  image: string;
  alt: string;
  icon: React.ComponentType<{ className?: string }>;
  specs: string[];
}

const FACILITIES: FacilityItem[] = [
  {
    id: "smart-classes",
    title: "Interactive Smart Classrooms",
    badge: "Digital Learning",
    badgeBg: "#166534",
    description:
      "High-definition multimedia screens and digital audio-visual teaching aids help primary children understand abstract concepts in mathematics, sciences, and phonetics with visual delight.",
    image: schoolImages.smartClass.src,
    alt: schoolImages.smartClass.alt,
    icon: MonitorPlay,
    specs: [
      "Audio-visual multimedia lessons & animated modules",
      "Interactive digital display boards in every section",
      "Ergonomic child-safe desks and visual charts",
      "Optimum daylight ventilation and acoustic balance",
      "Teacher digital workstations with curriculum content",
      "Visual storytelling for foundational English & Urdu",
    ],
  },
  {
    id: "campus-safety",
    title: "24x7 Monitored Campus Surveillance",
    badge: "Safety Standard",
    badgeBg: "#14532D",
    description:
      "High-definition CCTV cameras actively cover the entrance gate, corridors, stairwells, and assembly areas to ensure uninterrupted child protection and disciplined movement throughout school hours.",
    image: schoolImages.cctv.src,
    alt: schoolImages.cctv.alt,
    icon: ShieldCheck,
    specs: [
      "HD CCTV surveillance covering all corridors & gates",
      "Mandatory visitor registration at front security desk",
      "Attentive female support staff for pre-primary care",
      "Anti-skid floor surfaces and child-height stair handrails",
      "Certified fire safety extinguishers on all floors",
      "Strict zero-tolerance policy against bullying or negligence",
    ],
  },
  {
    id: "school-transport",
    title: "Safe Supervised Transport Network",
    badge: "GPS Monitored",
    badgeBg: "#B45309",
    description:
      "A dedicated, reliable fleet covering key localities of Patna City, Sultanganj, Gulzarbagh, and surrounding neighborhoods with trained drivers and verified escort attendants.",
    image: schoolImages.educationalTrip.src, // Educational field trip bus asset
    alt: "Al-Qalam School Transport Fleet",
    icon: Bus,
    specs: [
      "Dedicated route coverage across Gulzarbagh & Patna City",
      "Experienced, police-verified drivers and bus attendants",
      "Supervised boarding and deboarding protocols",
      "Emergency first-aid medical kit equipped in each vehicle",
      "Direct driver-office telephonic coordination",
      "Timely SMS alerts for route delays or road closures",
    ],
  },
  {
    id: "hygiene-health",
    title: "Clean RO Water & Child-Friendly Hygiene",
    badge: "Health First",
    badgeBg: "#166534",
    description:
      "Child welfare begins with hygiene. We provide multi-stage RO purified drinking water, sanitized separate restrooms for boys and girls, and emergency first-aid care.",
    image: schoolImages.hero.src,
    alt: "Clean and Hygienic Campus Facilities",
    icon: Droplets,
    specs: [
      "Multi-stage Reverse Osmosis (RO) purified drinking water",
      "Daily sanitized separate washrooms for boys and girls",
      "Handwash stations with soap dispensers at child height",
      "Dedicated first-aid and medical emergency cot",
      "Clean, pest-controlled campus environment",
      "Regular health check-ups and immunization advisories",
      "Spacious outdoor prayer & assembly grounds",
      "Indoor activity corner with building blocks & art tools",
    ],
  },
];

export default function FacilitiesSection() {
  return (
    <section className="py-16 sm:py-20 lg:py-24 bg-stone-50/60 border-b border-stone-200">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Heading */}
        <div className="max-w-3xl mx-auto text-center mb-12 sm:mb-14 space-y-3">
          <div className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-md bg-[#E8F3EA] text-[#14532D] text-xs font-bold uppercase tracking-wider">
            <Sparkles className="w-3.5 h-3.5 text-[#B45309]" />
            <span>Infrastructure & Student Welfare</span>
          </div>
          <h2 className="font-heading font-bold text-2xl sm:text-3xl lg:text-4xl tracking-tight text-stone-900">
            Safe, Modern & Technology-Enabled Campus
          </h2>
          <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
            Our campus at Ashok Rajpath Rd, Gulzarbagh features 26 institutional safety and educational specifications designed for child security and scholastic growth.
          </p>
        </div>

        {/* 4 Facility Pillar Cards Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 lg:gap-10">
          {FACILITIES.map((facility) => {
            const Icon = facility.icon;
            return (
              <div
                key={facility.id}
                className="bg-white rounded-xl border border-stone-200/90 shadow-xs overflow-hidden flex flex-col justify-between hover:shadow-md transition-shadow"
              >
                <div>
                  {/* Image with overlay badge */}
                  <div className="img-zoom-box relative h-56 sm:h-64 w-full bg-stone-900 border-b border-stone-200">
                    <Image
                      src={facility.image}
                      alt={facility.alt}
                      fill
                      sizes="(max-width: 768px) 100vw, 50vw"
                      className="img-zoom-target object-cover object-center"
                    />
                    <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent pointer-events-none" />

                    <div className="absolute top-3 left-3">
                      <span
                        className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-md text-xs font-bold text-white shadow-xs"
                        style={{ backgroundColor: facility.badgeBg }}
                      >
                        <Icon className="w-3.5 h-3.5" />
                        <span>{facility.badge}</span>
                      </span>
                    </div>
                  </div>

                  {/* Body Content */}
                  <div className="p-6 sm:p-7 space-y-4">
                    <h3 className="font-heading font-bold text-xl sm:text-2xl tracking-tight text-stone-900">
                      {facility.title}
                    </h3>

                    <p className="text-stone-600 text-sm leading-relaxed">
                      {facility.description}
                    </p>

                    {/* 6 Structured Checklist Specifications */}
                    <div className="pt-3 border-t border-stone-200/80">
                      <p className="text-xs font-bold uppercase tracking-wider text-stone-500 mb-3">
                        Verified Facility Specifications:
                      </p>
                      <ul className="grid grid-cols-1 sm:grid-cols-2 gap-2">
                        {facility.specs.map((spec, sIdx) => (
                          <li
                            key={sIdx}
                            className="flex items-start gap-2 text-xs text-stone-700 leading-snug"
                          >
                            <CheckCircle2 className="w-3.5 h-3.5 text-[#166534] shrink-0 mt-0.5" />
                            <span>{spec}</span>
                          </li>
                        ))}
                      </ul>
                    </div>
                  </div>
                </div>

                <div className="p-4 sm:p-5 bg-stone-50/80 border-t border-stone-200/80 flex items-center justify-between">
                  <span className="text-xs font-semibold text-stone-500">
                    Verified Campus Standard
                  </span>
                  <Link
                    href="/contact"
                    className="text-xs font-bold text-[#14532D] hover:text-[#0B3B20] hover:underline flex items-center gap-1"
                  >
                    <span>Inspect Campus Facilities</span>
                    <ArrowRight className="w-3.5 h-3.5" />
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
