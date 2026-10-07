import React from "react";
import Link from "next/link";
import Image from "next/image";
import {
  MapPin,
  Phone,
  Mail,
  Clock,
  ArrowRight,
  ShieldCheck,
  Smartphone,
  ExternalLink,
} from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function Footer() {
  const currentYear = new Date().getFullYear();

  return (
    <footer
      className="text-stone-300 border-t"
      style={{
        backgroundColor: "#0B3B20",
        borderColor: "#14532D",
      }}
      aria-label="Institutional Directory and Footer"
    >
      {/* Top Pre-Footer Call to Action Banner */}
      <div
        className="py-10 px-4 sm:px-6 lg:px-8 border-b"
        style={{
          backgroundColor: "#082F19",
          borderColor: "#052212",
        }}
      >
        <div className="max-w-7xl mx-auto flex flex-col md:flex-row items-center justify-between gap-6 text-center md:text-left">
          <div className="space-y-1.5">
            <div className="inline-flex items-center gap-2 px-2.5 py-1 rounded-md bg-amber-50 text-amber-900 border border-amber-200/60 text-xs font-bold uppercase tracking-wider">
              <span className="w-1.5 h-1.5 rounded-full bg-amber-600 animate-pulse" />
              <span>Admissions Open for Session 2026-27</span>
            </div>
            <h2 className="font-heading font-black text-2xl sm:text-3xl text-white tracking-tight">
              Begin Your Child&apos;s Educational Journey at Al-Qalam
            </h2>
            <p className="text-stone-200 text-xs sm:text-sm max-w-xl">
              Equipping young students with strong English-medium CBSE foundations, values-first moral education, and modern Smart Classrooms.
            </p>
          </div>
          <div className="flex flex-wrap items-center gap-3">
            <Link
              href="/admissions"
              className="text-xs py-3 px-6 rounded-md font-bold flex items-center gap-2 text-stone-900 bg-[#E5A93C] hover:bg-[#D4982B] shadow-md hover:shadow-lg transition-all"
            >
              <span>Online Admission Enquiry</span>
              <ArrowRight className="w-3.5 h-3.5" />
            </Link>
            <a
              href="tel:+919334112345"
              className="text-xs py-3 px-5 rounded-md font-bold flex items-center gap-2 text-white bg-[#166534] hover:bg-[#14532D] shadow-xs border border-white/20 transition-all"
            >
              <Phone className="w-3.5 h-3.5" />
              <span>Call Campus Desk</span>
            </a>
          </div>
        </div>
      </div>

      {/* Main 5-Column High-Density Mega Directory */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-14 lg:py-16">
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-12 gap-8 lg:gap-10">
          {/* Col 1: Identity & Credentials */}
          <div className="lg:col-span-4 space-y-4">
            <div className="flex items-center gap-3">
              <div className="relative w-12 h-12 shrink-0 bg-white rounded-md p-1 shadow-sm">
                <Image
                  src="/logo.png"
                  alt="Al-Qalam Public School Crest"
                  width={44}
                  height={44}
                  className="w-full h-full object-contain"
                />
              </div>
              <div>
                <span className="font-heading font-bold text-lg text-white tracking-tight block">
                  {SCHOOL_DATA.name}
                </span>
                <span className="text-[11px] text-[#E5A93C] uppercase tracking-wider font-semibold">
                  Gulzarbagh, Patna • Estd. Primary Institution
                </span>
              </div>
            </div>

            <p className="text-white/90 text-xs font-serif italic">
              {SCHOOL_DATA.mottoArabic} • &ldquo;{SCHOOL_DATA.mottoTranslation}&rdquo;
            </p>

            <p className="text-stone-300 text-xs leading-relaxed">
              Al-Qalam Public School is an established English-medium primary institution nurturing students from Pre-Nursery to Class 5 in Sultanganj, Gulzarbagh, Patna.
            </p>

            <div className="space-y-1.5 text-xs text-stone-300 pt-1">
              <div className="flex items-start gap-2">
                <MapPin className="w-4 h-4 text-[#E5A93C] shrink-0 mt-0.5" />
                <span>Opp. Jashn Palace, Ashok Rajpath Rd, Dargah Road, Sultanganj, Gulzarbagh, Patna 800007</span>
              </div>
              <div className="flex items-center gap-2">
                <Phone className="w-4 h-4 text-[#E5A93C] shrink-0" />
                <span>+91 93341 12345 / 0612-2630000</span>
              </div>
              <div className="flex items-center gap-2">
                <Clock className="w-4 h-4 text-[#E5A93C] shrink-0" />
                <span>Office Hours: 7:30 AM – 1:30 PM (Mon – Sat)</span>
              </div>
            </div>

            <div className="pt-2">
              <span className="inline-flex items-center gap-1.5 text-[11px] font-semibold px-2.5 py-1 rounded-sm bg-white/10 text-white border border-white/15">
                <ShieldCheck className="w-3.5 h-3.5 text-[#E5A93C]" />
                <span>Director: {SCHOOL_DATA.director.name}</span>
              </span>
            </div>
          </div>

          {/* Col 2: Academic Wings */}
          <div className="lg:col-span-2 space-y-3">
            <h3 className="font-heading font-bold text-white text-xs tracking-wider uppercase border-b border-white/15 pb-2">
              Academic Wings
            </h3>
            <ul className="space-y-1.5 text-xs">
              <li>
                <Link href="/academics" className="text-stone-300 hover:text-white transition-colors">
                  Pre-Nursery (Age 3+)
                </Link>
              </li>
              <li>
                <Link href="/academics" className="text-stone-300 hover:text-white transition-colors">
                  Nursery Readiness
                </Link>
              </li>
              <li>
                <Link href="/academics" className="text-stone-300 hover:text-white transition-colors">
                  LKG Kindergarten
                </Link>
              </li>
              <li>
                <Link href="/academics" className="text-stone-300 hover:text-white transition-colors">
                  UKG Senior KG
                </Link>
              </li>
              <li>
                <Link href="/academics" className="text-stone-300 hover:text-white transition-colors">
                  Class 1 (Foundational)
                </Link>
              </li>
              <li>
                <Link href="/academics" className="text-stone-300 hover:text-white transition-colors">
                  Class 2 Scholastic
                </Link>
              </li>
              <li>
                <Link href="/academics" className="text-stone-300 hover:text-white transition-colors">
                  Class 3 Scholastic
                </Link>
              </li>
              <li>
                <Link href="/academics" className="text-stone-300 hover:text-white transition-colors">
                  Class 4 Scholastic
                </Link>
              </li>
              <li>
                <Link href="/academics" className="text-stone-300 hover:text-white transition-colors">
                  Class 5 Primary Wing
                </Link>
              </li>
              <li>
                <Link href="/academics" className="text-[#E5A93C] hover:text-white font-medium transition-colors">
                  Deeniyat & Tajweed
                </Link>
              </li>
            </ul>
          </div>

          {/* Col 3: Admissions & Guidelines */}
          <div className="lg:col-span-2 space-y-3">
            <h3 className="font-heading font-bold text-white text-xs tracking-wider uppercase border-b border-white/15 pb-2">
              Admissions Desk
            </h3>
            <ul className="space-y-1.5 text-xs">
              <li>
                <Link href="/admissions" className="text-stone-300 hover:text-white transition-colors">
                  Admissions Process
                </Link>
              </li>
              <li>
                <Link href="/admissions" className="text-stone-300 hover:text-white transition-colors">
                  Fee Structure Guidelines
                </Link>
              </li>
              <li>
                <Link href="/admissions" className="text-stone-300 hover:text-white transition-colors">
                  Age Eligibility Criteria
                </Link>
              </li>
              <li>
                <Link href="/admissions" className="text-stone-300 hover:text-white transition-colors">
                  Required Documents
                </Link>
              </li>
              <li>
                <Link href="/contact" className="text-stone-300 hover:text-white transition-colors">
                  Campus Visit Booking
                </Link>
              </li>
              <li>
                <Link href="/notices" className="text-stone-300 hover:text-white transition-colors">
                  Admission Circulars
                </Link>
              </li>
              <li>
                <Link href="/contact" className="text-stone-300 hover:text-white transition-colors">
                  Transport Enquiries
                </Link>
              </li>
              <li>
                <Link href="/admissions" className="text-[#E5A93C] hover:text-white font-semibold transition-colors">
                  Enquiry Form 2026-27
                </Link>
              </li>
            </ul>
          </div>

          {/* Col 4: Campus Facilities & Activities */}
          <div className="lg:col-span-2 space-y-3">
            <h3 className="font-heading font-bold text-white text-xs tracking-wider uppercase border-b border-white/15 pb-2">
              Campus & Activities
            </h3>
            <ul className="space-y-1.5 text-xs">
              <li>
                <Link href="/facilities" className="text-stone-300 hover:text-white transition-colors">
                  Interactive Smart Classes
                </Link>
              </li>
              <li>
                <Link href="/facilities" className="text-stone-300 hover:text-white transition-colors">
                  24x7 CCTV Surveillance
                </Link>
              </li>
              <li>
                <Link href="/facilities" className="text-stone-300 hover:text-white transition-colors">
                  Supervised Transport
                </Link>
              </li>
              <li>
                <Link href="/facilities" className="text-stone-300 hover:text-white transition-colors">
                  RO Purified Water
                </Link>
              </li>
              <li>
                <Link href="/gallery" className="text-stone-300 hover:text-white transition-colors">
                  Drawing Competitions
                </Link>
              </li>
              <li>
                <Link href="/gallery" className="text-stone-300 hover:text-white transition-colors">
                  Educational Field Excursions
                </Link>
              </li>
              <li>
                <Link href="/gallery" className="text-stone-300 hover:text-white transition-colors">
                  Annual Sports Day
                </Link>
              </li>
              <li>
                <Link href="/gallery" className="text-stone-300 hover:text-white transition-colors">
                  Star Student Felicitations
                </Link>
              </li>
            </ul>
          </div>

          {/* Col 5: Portals, Disclosures & Mobile App */}
          <div className="lg:col-span-2 space-y-3">
            <h3 className="font-heading font-bold text-white text-xs tracking-wider uppercase border-b border-white/15 pb-2">
              Portals & App
            </h3>
            <ul className="space-y-1.5 text-xs">
              <li>
                <Link href="/notices" className="text-stone-300 hover:text-white transition-colors">
                  Notice Board / Circulars
                </Link>
              </li>
              <li>
                <Link href="/about" className="text-stone-300 hover:text-white transition-colors">
                  Director Desk Address
                </Link>
              </li>
              <li>
                <Link href="/contact" className="text-stone-300 hover:text-white transition-colors">
                  Grievance & Campus Desk
                </Link>
              </li>
              <li>
                <span className="text-stone-400 block pt-2 text-[11px] uppercase tracking-wider font-bold">
                  Official Mobile App:
                </span>
              </li>
            </ul>

            {/* Mobile App Download Card */}
            <div className="p-3 rounded-sm bg-white/10 border border-white/20 space-y-2">
              <div className="flex items-center gap-1.5 text-xs font-bold text-white">
                <Smartphone className="w-3.5 h-3.5 text-[#E5A93C]" />
                <span>Al-Qalam App</span>
              </div>
              <p className="text-[11px] text-stone-300 leading-tight">
                Triple-role app for Admins, Teachers & Parents. Attendance, fees & timetable tracking.
              </p>
              <a
                href="/Al-Qalam-Public-School-Release.apk"
                download
                className="text-[10px] py-2 px-2.5 rounded-md font-bold flex items-center justify-center gap-1.5 text-stone-900 bg-[#E5A93C] hover:bg-[#D4982B] shadow-xs w-full transition-colors"
              >
                <span>Download Android APK</span>
                <ArrowRight className="w-3 h-3" />
              </a>
            </div>
          </div>
        </div>
      </div>

      {/* Bottom Bar: Copyright & Location Verification (pb-24 on mobile ensures no overlap with MobileAppNav) */}
      <div
        className="py-5 pb-24 md:pb-5 px-4 sm:px-6 lg:px-8 border-t text-xs text-stone-400"
        style={{
          backgroundColor: "#062313",
          borderColor: "#04180D",
        }}
      >
        <div className="max-w-7xl mx-auto flex flex-col md:flex-row items-center justify-between gap-3 text-center md:text-left">
          <p>
            © {currentYear} <strong>Al-Qalam Public School</strong>, Gulzarbagh, Patna. All rights reserved.
          </p>
          <div className="flex flex-wrap items-center gap-4 text-[11px]">
            <span className="text-stone-400">Ashok Rajpath Rd, Opp. Jashn Palace, Patna, Bihar 800007</span>
            <span>•</span>
            <Link href="/admissions" className="hover:text-white transition-colors">
              Admissions
            </Link>
            <span>•</span>
            <Link href="/notices" className="hover:text-white transition-colors">
              Notices
            </Link>
            <span>•</span>
            <Link href="/contact" className="hover:text-white transition-colors">
              Contact Desk
            </Link>
          </div>
        </div>
      </div>
    </footer>
  );
}
