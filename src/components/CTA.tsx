import React from "react";
import Link from "next/link";
import { ArrowRight } from "lucide-react";

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
    <section className="relative overflow-hidden rounded-xl bg-gradient-to-r from-[#0B3B20] via-[#14532D] to-[#166534] text-white p-8 sm:p-12 shadow-md border border-[#14532D] my-12">
      <div className="relative z-10 max-w-3xl mx-auto text-center space-y-5">
        <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-md bg-white/10 border border-white/20 text-emerald-200 text-xs font-bold uppercase tracking-wider backdrop-blur-xs">
          <span>Admissions Desk</span>
        </div>

        <h3 className="font-heading font-black text-2xl sm:text-3xl lg:text-4xl text-white tracking-tight">
          {title}
        </h3>

        <p className="text-sm sm:text-base text-stone-200 leading-relaxed max-w-2xl mx-auto">
          {subtitle}
        </p>

        <div className="pt-2 flex flex-col sm:flex-row items-center justify-center gap-3.5">
          <Link
            href={primaryBtnHref}
            className="btn-primary w-full sm:w-auto px-6 py-3 rounded-lg font-semibold text-[#14532D] bg-white hover:bg-stone-50 shadow-xs text-sm flex items-center justify-center gap-2"
          >
            <span>{primaryBtnText}</span>
            <ArrowRight className="w-4 h-4 text-[#14532D]" />
          </Link>

          <Link
            href="/contact"
            className="btn-primary w-full sm:w-auto px-6 py-3 rounded-lg font-semibold text-white bg-white/10 hover:bg-white/20 border border-white/30 shadow-2xs text-sm flex items-center justify-center backdrop-blur-xs"
          >
            <span>Visit Campus</span>
          </Link>
        </div>
      </div>
    </section>
  );
}
