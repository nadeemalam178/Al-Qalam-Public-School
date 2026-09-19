import React from "react";
import Link from "next/link";
import Image from "next/image";
import { MapPin, Shield, Monitor, GraduationCap, ChevronRight } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function Footer() {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="bg-[#0d361c] text-[#EDE2D3] border-t border-[#14532D]" aria-label="School Footer">
      {/* Top CTA Banner in Footer */}
      <div className="bg-[#14532D] border-b border-[#0d361c] py-10 px-4 sm:px-6 lg:px-8">
        <div className="max-w-7xl mx-auto flex flex-col md:flex-row items-center justify-between gap-6 text-center md:text-left">
          <div>
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[#E8F3EA]/10 border border-[#E8F3EA]/20 text-[#EDE2D3] text-xs font-semibold mb-2">
              <span className="w-1.5 h-1.5 rounded-full bg-[#E8F3EA]" />
              <span>Nurturing Foundational Minds</span>
            </div>
            <h2 className="text-xl sm:text-2xl font-black text-white tracking-tight">
              Begin Your Child&apos;s Educational Journey at Al-Qalam
            </h2>
            <p className="text-[#EDE2D3]/80 text-sm mt-1 max-w-2xl">
              Equipped with modern Smart Classes and proactive CCTV security surveillance in Gulzarbagh, Patna.
            </p>
          </div>
          <Link
            href="/admissions"
            className="shrink-0 inline-flex items-center gap-2 px-6 py-3 rounded-xl font-bold text-[#14532D] bg-[#FAF8F2] hover:bg-white shadow-md hover:shadow-lg active:scale-98 transition-all text-sm"
          >
            <GraduationCap className="w-5 h-5 text-[#14532D]" />
            <span>Submit Admission Enquiry</span>
          </Link>
        </div>
      </div>

      {/* Main Footer Grid */}
      <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 lg:py-16 overflow-hidden">
        {/* Subtle Decorative Crest Watermark */}
        <div className="absolute -right-12 bottom-0 w-80 h-80 opacity-[0.03] pointer-events-none select-none hidden lg:block">
          <Image
            src="/logo.png"
            alt=""
            width={320}
            height={320}
            className="w-full h-full object-contain"
          />
        </div>

        <div className="relative z-10 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-10">
          {/* Col 1: School Identity & Crest */}
          <div className="lg:col-span-4 space-y-4">
            <div className="flex items-center gap-3">
              <div className="w-13 h-13 shrink-0 drop-shadow-md">
                <Image
                  src="/logo.png"
                  alt="Al-Qalam Public School Emblem"
                  width={52}
                  height={52}
                  className="w-full h-full object-contain"
                />
              </div>
              <div>
                <span className="text-lg font-bold text-white tracking-tight block">
                  {SCHOOL_DATA.name}
                </span>
                <span className="text-xs text-[#EDE2D3] font-semibold tracking-wide uppercase">
                  Patna, Bihar
                </span>
              </div>
            </div>

            <p className="text-[#FAF8F2] font-medium italic text-sm">
              &ldquo;{SCHOOL_DATA.tagline}&rdquo;
            </p>

            <p className="text-stone-300 text-sm leading-relaxed">
              Committed to balanced foundational learning, moral character, and a safe, modern school environment for every child.
            </p>

            <div className="pt-2">
              <p className="text-xs text-stone-300">
                <span className="font-semibold text-white">Director:</span> {SCHOOL_DATA.director.name}
              </p>
            </div>
          </div>

          {/* Col 2: Quick Links */}
          <div className="lg:col-span-3 space-y-4">
            <h3 className="text-white font-bold text-sm tracking-wider uppercase border-b border-[#1b7a3f]/40 pb-2">
              Quick Navigation
            </h3>
            <ul className="space-y-2 text-sm">
              {SCHOOL_DATA.navLinks.map((link) => (
                <li key={link.href}>
                  <Link
                    href={link.href}
                    className="flex items-center gap-2 text-stone-300 hover:text-white transition-colors py-0.5"
                  >
                    <ChevronRight className="w-3.5 h-3.5 text-[#EDE2D3]" />
                    <span>{link.label}</span>
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Col 3: Confirmed Facilities */}
          <div className="lg:col-span-2 space-y-4">
            <h3 className="text-white font-bold text-sm tracking-wider uppercase border-b border-[#1b7a3f]/40 pb-2">
              Our Facilities
            </h3>
            <div className="space-y-3">
              <div className="bg-[#14532D]/80 p-3 rounded-lg border border-[#2F7D4A]/40">
                <div className="flex items-center gap-2 text-white font-semibold text-xs mb-1">
                  <Monitor className="w-4 h-4 text-[#EDE2D3] shrink-0" />
                  <span>Smart Classes</span>
                </div>
                <p className="text-xs text-stone-300 leading-normal">
                  Interactive audio-visual learning for conceptual understanding.
                </p>
              </div>

              <div className="bg-[#14532D]/80 p-3 rounded-lg border border-[#2F7D4A]/40">
                <div className="flex items-center gap-2 text-white font-semibold text-xs mb-1">
                  <Shield className="w-4 h-4 text-[#EDE2D3] shrink-0" />
                  <span>CCTV Monitoring</span>
                </div>
                <p className="text-xs text-stone-300 leading-normal">
                  Active security surveillance across campus corridors.
                </p>
              </div>
            </div>
          </div>

          {/* Col 4: Campus Location & Address */}
          <div className="lg:col-span-3 space-y-4">
            <h3 className="text-white font-bold text-sm tracking-wider uppercase border-b border-[#1b7a3f]/40 pb-2">
              Campus Location
            </h3>
            <div className="space-y-3 text-sm text-stone-300">
              <div className="flex items-start gap-3">
                <MapPin className="w-5 h-5 text-[#EDE2D3] shrink-0 mt-0.5" />
                <div className="text-xs leading-relaxed">
                  <p className="font-semibold text-white">{SCHOOL_DATA.name}</p>
                  <p>{SCHOOL_DATA.address.line1},</p>
                  <p>{SCHOOL_DATA.address.line2},</p>
                  <p>{SCHOOL_DATA.address.street},</p>
                  <p>
                    {SCHOOL_DATA.address.locality}, {SCHOOL_DATA.address.city}, {SCHOOL_DATA.address.state} – {SCHOOL_DATA.address.pincode}
                  </p>
                </div>
              </div>

              <div className="pt-2">
                <a
                  href={SCHOOL_DATA.address.googleMapsUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-[#14532D] border border-[#2F7D4A]/60 text-xs text-[#FAF8F2] hover:bg-[#166534] transition"
                >
                  <MapPin className="w-3.5 h-3.5" />
                  <span>View on Google Maps</span>
                </a>
              </div>
            </div>
          </div>
        </div>

        {/* Bottom Legal strip */}
        <div className="mt-12 pt-6 border-t border-[#1b7a3f]/30 flex flex-col sm:flex-row items-center justify-between text-xs text-stone-400 gap-4">
          <p>© {currentYear} {SCHOOL_DATA.name}. All rights reserved.</p>
          <p className="text-center sm:text-right text-stone-400">
            Official Public Portal • Patna, Bihar 800007
          </p>
        </div>
      </div>
    </footer>
  );
}
