import React from "react";
import Link from "next/link";
import Image from "next/image";
import { MapPin, Navigation, ArrowRight, Share2 } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function Footer() {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="bg-[#0B3B20] text-[#EDE2D3] border-t border-[#14532D]" aria-label="School Footer">
      {/* Top Pre-Footer Call to Action Banner */}
      <div className="bg-[#14532D] border-b border-[#0B3B20] py-10 px-4 sm:px-6 lg:px-8">
        <div className="max-w-7xl mx-auto flex flex-col md:flex-row items-center justify-between gap-6 text-center md:text-left">
          <div className="space-y-1.5">
            <span className="text-xs uppercase tracking-wider text-[#EDE2D3] font-semibold">
              Admissions Open for the Academic Session
            </span>
            <h2 className="font-heading font-black text-2xl sm:text-3xl text-white tracking-tight">
              Begin Your Child&apos;s Educational Journey
            </h2>
            <p className="text-stone-300 text-xs sm:text-sm max-w-xl">
              Foundational and primary schooling with modern Smart Classes and attentive mentorship in Gulzarbagh, Patna.
            </p>
          </div>
          <Link
            href="/admissions"
            className="btn-primary shrink-0 px-6 py-3 rounded-lg text-xs font-semibold text-[#14532D] bg-[#FAF8F2] hover:bg-white shadow-sm transition-colors flex items-center gap-2"
          >
            <span>Admission Enquiry</span>
            <ArrowRight className="w-3.5 h-3.5 text-[#14532D]" />
          </Link>
        </div>
      </div>

      {/* Main 4-Column Footer */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 lg:py-16">
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-12 gap-8 lg:gap-10">
          {/* Col 1: School Identity */}
          <div className="lg:col-span-4 space-y-4">
            <div className="flex items-center gap-3">
              <div className="relative w-12 h-12 shrink-0">
                <Image
                  src="/logo.png"
                  alt="Al-Qalam Public School Crest"
                  width={48}
                  height={48}
                  className="w-full h-full object-contain"
                />
              </div>
              <div>
                <span className="font-heading font-bold text-lg text-white tracking-tight block">
                  {SCHOOL_DATA.name}
                </span>
                <span className="text-xs text-[#EDE2D3] uppercase tracking-wider">
                  Patna, Bihar
                </span>
              </div>
            </div>

            <p className="text-[#FAF8F2] text-xs font-serif italic">
              {SCHOOL_DATA.mottoArabic} • &ldquo;{SCHOOL_DATA.mottoTranslation}&rdquo;
            </p>

            <p className="text-stone-300 text-xs sm:text-sm leading-relaxed">
              Committed to structured foundational learning, moral character, and a safe, modern school environment for every student.
            </p>

            <div className="pt-1 text-xs text-stone-300">
              <span className="font-semibold text-white">Director:</span> {SCHOOL_DATA.director.name}
            </div>
          </div>

          {/* Col 2: School */}
          <div className="lg:col-span-2 space-y-3">
            <h3 className="font-heading font-bold text-white text-sm tracking-wider uppercase border-b border-[#14532D] pb-2">
              School
            </h3>
            <ul className="space-y-2 text-xs sm:text-sm">
              <li>
                <Link href="/about" className="text-stone-300 hover:text-white transition-colors">
                  About
                </Link>
              </li>
              <li>
                <Link href="/academics" className="text-stone-300 hover:text-white transition-colors">
                  Academics
                </Link>
              </li>
              <li>
                <Link href="/facilities" className="text-stone-300 hover:text-white transition-colors">
                  Facilities
                </Link>
              </li>
              <li>
                <Link href="/gallery" className="text-stone-300 hover:text-white transition-colors">
                  Gallery
                </Link>
              </li>
            </ul>
          </div>

          {/* Col 3: Admissions */}
          <div className="lg:col-span-2 space-y-3">
            <h3 className="font-heading font-bold text-white text-sm tracking-wider uppercase border-b border-[#14532D] pb-2">
              Admissions
            </h3>
            <ul className="space-y-2 text-xs sm:text-sm">
              <li>
                <Link href="/admissions" className="text-stone-300 hover:text-white transition-colors">
                  Admission Enquiry
                </Link>
              </li>
              <li>
                <Link href="/admissions#process" className="text-stone-300 hover:text-white transition-colors">
                  Process
                </Link>
              </li>
              <li>
                <Link href="/notices" className="text-stone-300 hover:text-white transition-colors">
                  Notices
                </Link>
              </li>
            </ul>
          </div>

          {/* Col 4: Contact & Directions */}
          <div className="lg:col-span-4 space-y-3">
            <h3 className="font-heading font-bold text-white text-sm tracking-wider uppercase border-b border-[#14532D] pb-2">
              Contact & Campus
            </h3>
            <div className="space-y-2.5 text-xs text-stone-300">
              <div className="flex items-start gap-2.5">
                <MapPin className="w-4 h-4 text-[#EDE2D3] shrink-0 mt-0.5" />
                <div className="leading-relaxed">
                  <p className="font-medium text-white">{SCHOOL_DATA.name}</p>
                  <p>{SCHOOL_DATA.address.line1},</p>
                  <p>{SCHOOL_DATA.address.line2}, {SCHOOL_DATA.address.street},</p>
                  <p>{SCHOOL_DATA.address.locality}, {SCHOOL_DATA.address.city}, {SCHOOL_DATA.address.state} 800007</p>
                </div>
              </div>

              <div className="pt-2 flex flex-wrap items-center gap-2">
                <a
                  href={SCHOOL_DATA.address.googleMapsUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="btn-primary inline-flex items-center gap-1.5 px-3 py-1.5 rounded-md bg-[#14532D] text-xs text-white hover:bg-[#166534] border border-[#2F7D4A]/50 transition-colors"
                >
                  <Navigation className="w-3 h-3 text-[#EDE2D3]" />
                  <span>Get Directions on Google Maps</span>
                </a>

                {SCHOOL_DATA.social?.facebook && (
                  <a
                    href={SCHOOL_DATA.social.facebook}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-md bg-[#072413] text-xs text-[#EDE2D3] hover:text-white hover:bg-[#14532D] border border-[#2F7D4A]/50 transition-colors"
                  >
                    <Share2 className="w-3 h-3 text-[#EDE2D3]" />
                    <span>Official Facebook Page</span>
                  </a>
                )}
              </div>
            </div>
          </div>
        </div>

        {/* Bottom Bar: Copyright & Location */}
        <div className="mt-12 pt-6 border-t border-[#14532D] flex flex-col sm:flex-row items-center justify-between text-xs text-stone-400 gap-3">
          <p>© {currentYear} {SCHOOL_DATA.name}. All rights reserved.</p>
          <p className="text-stone-400">Patna, Bihar 800007</p>
        </div>
      </div>
    </footer>
  );
}
