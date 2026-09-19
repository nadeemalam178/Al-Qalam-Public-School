import React from "react";
import Link from "next/link";
import Image from "next/image";
import { GraduationCap, ArrowRight } from "lucide-react";

interface CTAProps {
  title?: string;
  subtitle?: string;
  primaryBtnText?: string;
  primaryBtnHref?: string;
}

export default function CTA({
  title = "Ready to Begin Your Child's Journey at Al-Qalam?",
  subtitle = "Our admissions desk welcomes enquiries for foundational and primary classes. Visit our campus in Gulzarbagh or send an online enquiry.",
  primaryBtnText = "Submit Admission Enquiry",
  primaryBtnHref = "/admissions",
}: CTAProps) {
  return (
    <section className="relative overflow-hidden rounded-3xl bg-gradient-to-r from-[#0d3b1f] via-[#14532D] to-[#166534] text-white p-8 sm:p-12 shadow-lg border border-[#2F7D4A]/40 my-12">
      {/* Subtle Brand Crest Watermark Accent */}
      <div className="absolute -right-12 -bottom-12 w-64 h-64 opacity-[0.04] pointer-events-none select-none hidden sm:block">
        <Image
          src="/branding/al-qalam-logo-light.svg"
          alt=""
          width={256}
          height={256}
          className="w-full h-full object-contain"
        />
      </div>

      <div className="relative z-10 max-w-3xl mx-auto text-center space-y-6">
        <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#E8F3EA]/15 border border-[#EDE2D3]/20 text-[#EDE2D3] text-xs font-bold uppercase tracking-wider">
          <Image
            src="/branding/al-qalam-icon.svg"
            alt=""
            width={18}
            height={18}
            className="w-4.5 h-4.5 rounded-full object-contain"
          />
          <span>Admissions Notice</span>
        </div>

        <h3 className="text-2xl sm:text-3xl lg:text-4xl font-black text-white tracking-tight">
          {title}
        </h3>

        <p className="text-sm sm:text-base text-[#EDE2D3] leading-relaxed max-w-2xl mx-auto">
          {subtitle}
        </p>

        <div className="pt-2 flex flex-col sm:flex-row items-center justify-center gap-4">
          <Link
            href={primaryBtnHref}
            className="w-full sm:w-auto inline-flex items-center justify-center gap-2.5 px-8 py-3.5 rounded-xl font-bold text-[#14532D] bg-[#FAF8F2] hover:bg-white shadow-md active:scale-98 transition-all text-sm sm:text-base"
          >
            <GraduationCap className="w-5 h-5 text-[#14532D]" />
            <span>{primaryBtnText}</span>
          </Link>

          <Link
            href="/contact"
            className="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-6 py-3.5 rounded-xl font-bold text-white bg-[#0d3b1f]/80 hover:bg-[#0d3b1f] border border-[#2F7D4A]/60 backdrop-blur-xs active:scale-98 transition-all text-sm sm:text-base"
          >
            <span>Visit Campus</span>
            <ArrowRight className="w-4 h-4 text-[#EDE2D3]" />
          </Link>
        </div>
      </div>
    </section>
  );
}
