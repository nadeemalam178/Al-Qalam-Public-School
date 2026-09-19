import React from "react";
import type { Metadata } from "next";
import Image from "next/image";
import {
  GraduationCap,
  ClipboardList,
  FileCheck,
  UserCheck,
  CheckCircle2,
  HelpCircle,
  MapPin,
  Sparkles,
} from "lucide-react";
import AdmissionForm from "@/components/AdmissionForm";
import ScrollReveal from "@/components/ScrollReveal";
import { SCHOOL_DATA } from "@/data/schoolData";
import { schoolImages } from "@/data/schoolImages";

export const metadata: Metadata = {
  title: "Admissions",
  description:
    "Admissions enquiry for Al-Qalam Public School, Gulzarbagh, Patna. Information on the admission process, documentation, classes, and online admission enquiry form.",
};

export default function AdmissionsPage() {
  const steps = [
    {
      num: "01",
      title: "Enquiry & Registration",
      desc: "Fill out our online Admission Enquiry form or collect the registration brochure directly from the campus desk.",
      icon: ClipboardList,
    },
    {
      num: "02",
      title: "Friendly Interaction",
      desc: "A warm, informal conversation with the student and parents to understand the child's interests and learning readiness.",
      icon: UserCheck,
    },
    {
      num: "03",
      title: "Document Verification",
      desc: "Submission of standard foundational documents including birth certificate, photographs, and address proof.",
      icon: FileCheck,
    },
    {
      num: "04",
      title: "Enrolment Confirmation",
      desc: "Formal admission completion, class section assignment, and orientation details provided for the academic session.",
      icon: GraduationCap,
    },
  ];

  const requiredDocuments = [
    "Original & photocopy of Student's Birth Certificate (issued by Municipal authority)",
    "Recent passport-sized photographs of the student (4 copies)",
    "Recent passport-sized photographs of parents/guardians (2 copies each)",
    "Photocopy of Parent's / Guardian's Government ID & Residential Address Proof",
    "Previous class report card or Transfer Certificate (if applicable for higher primary classes)",
    "Immunization / basic medical record summary (if requested for early learners)",
  ];

  return (
    <div className="bg-white">
      {/* Banner */}
      <section className="bg-forest-hero text-white py-16 sm:py-20 border-b border-[#0d3b1f]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <ScrollReveal variant="fade-up">
            <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#0d3b1f]/60 border border-[#2F7D4A]/40 text-[#EDE2D3] text-xs font-bold uppercase tracking-wider mb-4">
              <GraduationCap className="w-4 h-4 text-[#E8F3EA]" />
              <span>Admissions Desk</span>
            </div>
            <h1 className="text-3xl sm:text-4xl lg:text-5xl font-black tracking-tight text-white">
              Admissions at Al-Qalam Public School
            </h1>
            <p className="mt-3 text-base sm:text-lg text-[#EDE2D3] max-w-2xl mx-auto">
              Welcoming young learners into a nurturing, disciplined environment in Gulzarbagh, Patna.
            </p>
          </ScrollReveal>
        </div>
      </section>

      {/* Main Admission Section: Process + Form */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 items-start">
            {/* Left Column: Process & Documents */}
            <div className="lg:col-span-6 space-y-10">
              <ScrollReveal variant="fade-up">
                <div>
                  <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-full bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/25 text-xs font-bold uppercase tracking-wider mb-3">
                    <span>How to Apply</span>
                  </div>
                  <h2 className="text-2xl sm:text-3xl font-extrabold text-[#14532D] tracking-tight leading-tight">
                    Simple, Transparent Admission Process
                  </h2>
                  <p className="text-stone-600 text-sm sm:text-base leading-relaxed mt-2">
                    We strive to make the admission experience supportive and welcoming for parents and children alike.
                  </p>
                </div>
              </ScrollReveal>

              {/* 4 Steps */}
              <div className="space-y-4">
                {steps.map((step, idx) => {
                  return (
                    <ScrollReveal key={step.num} variant="fade-up" delay={idx * 75}>
                      <div
                        className="card-interactive bg-[#FAF8F2] rounded-2xl p-5 border border-[#EDE2D3] flex items-start gap-4 shadow-xs"
                      >
                        <div className="w-11 h-11 rounded-xl bg-[#14532D] text-white flex items-center justify-center font-bold text-sm shrink-0 shadow-xs">
                          {step.num}
                        </div>
                        <div className="space-y-1">
                          <h3 className="text-base font-bold text-[#14532D]">
                            {step.title}
                          </h3>
                          <p className="text-xs sm:text-sm text-stone-600 leading-relaxed">
                            {step.desc}
                          </p>
                        </div>
                      </div>
                    </ScrollReveal>
                  );
                })}
              </div>

              {/* Welcoming Admission Visual Feature */}
              <ScrollReveal variant="fade-up" delay={120}>
                <div className="card-interactive rounded-2xl overflow-hidden border border-[#EDE2D3] bg-[#FAF8F2] shadow-xs">
                  <div className="img-zoom-parent relative h-48 sm:h-56 w-full overflow-hidden">
                    <Image
                      src={schoolImages.admission.src}
                      alt={schoolImages.admission.alt}
                      fill
                      sizes="(max-width: 1024px) 100vw, 50vw"
                      className="img-zoom-child object-cover"
                    />
                    <div className="absolute inset-0 bg-gradient-to-t from-[#14532D]/40 via-transparent to-transparent pointer-events-none" />
                    <div className="absolute bottom-3 left-3 bg-[#14532D]/90 backdrop-blur-xs text-white text-[11px] font-bold px-3 py-1 rounded-full border border-white/20 flex items-center gap-1.5">
                      <Sparkles className="w-3 h-3 text-[#EDE2D3]" />
                      <span>Welcoming Counseling Desk</span>
                    </div>
                  </div>
                  <div className="p-4 text-xs text-stone-600 leading-relaxed">
                    Our admissions staff assists parents with document verification, class placements, and campus walkthroughs during official hours.
                  </div>
                </div>
              </ScrollReveal>

              {/* Required Documents Checklist */}
              <ScrollReveal variant="fade-up" delay={150}>
                <div className="card-interactive bg-[#FAF8F2] rounded-3xl p-6 sm:p-8 border border-[#EDE2D3] space-y-4 shadow-xs">
                  <div className="flex items-center gap-2.5 text-[#14532D]">
                    <FileCheck className="w-6 h-6 text-[#166534]" />
                    <h3 className="text-lg font-bold text-[#14532D]">
                      Required Documents Checklist
                    </h3>
                  </div>
                  <p className="text-xs text-stone-500">
                    Parents are requested to prepare the following documents during campus registration:
                  </p>
                  <ul className="space-y-2.5 pt-2">
                    {requiredDocuments.map((doc, idx) => (
                      <li key={idx} className="flex items-start gap-2.5 text-xs sm:text-sm text-stone-700">
                        <CheckCircle2 className="w-4 h-4 text-[#166534] shrink-0 mt-0.5" />
                        <span>{doc}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              </ScrollReveal>

              {/* Important Placeholder Notice */}
              <ScrollReveal variant="fade-up" delay={180}>
                <div className="bg-[#FAF8F2] border border-[#EDE2D3] rounded-2xl p-5 flex items-start gap-3 text-xs text-stone-700 shadow-xs">
                  <HelpCircle className="w-5 h-5 text-[#6B4226] shrink-0 mt-0.5" />
                  <div className="leading-relaxed">
                    <span className="font-bold text-[#14532D]">Fee Structure & Exact Dates:</span> Fee schedules, age criteria, and uniform guidelines are provided directly by the school administration desk. Please submit an enquiry below or visit the campus desk for verified official documentation.
                  </div>
                </div>
              </ScrollReveal>
            </div>

            {/* Right Column: Admission Enquiry Form */}
            <div className="lg:col-span-6 sticky top-24">
              <ScrollReveal variant="fade-up" delay={150}>
                <AdmissionForm />
              </ScrollReveal>
            </div>
          </div>
        </div>
      </section>

      {/* Campus Desk Help & Location Note */}
      <section className="py-12 bg-[#FAF8F2]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
            <div className="bg-gradient-to-br from-[#0d3b1f] via-[#14532D] to-[#166534] rounded-3xl p-8 sm:p-10 text-white shadow-md flex flex-col md:flex-row items-center justify-between gap-6">
              <div className="space-y-2 text-center md:text-left">
                <span className="text-xs font-bold uppercase tracking-wider text-[#EDE2D3]">
                  Prefer Visiting in Person?
                </span>
                <h3 className="text-xl sm:text-2xl font-black text-white">
                  Visit our Campus Admissions Office
                </h3>
                <p className="text-xs sm:text-sm text-[#EDE2D3] max-w-xl">
                  Opposite Jashn Palace Marriage Hall, Ashok Rajpath Rd, Gulzarbagh, Alamganj, Patna.
                </p>
              </div>
              <a
                href={SCHOOL_DATA.address.googleMapsUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="btn-interactive shrink-0 inline-flex items-center gap-2 px-6 py-3 rounded-xl font-bold text-[#14532D] bg-[#FAF8F2] hover:bg-white shadow-xs transition text-sm"
              >
                <MapPin className="w-4 h-4 text-[#14532D]" />
                <span>Get Directions to School</span>
              </a>
            </div>
          </ScrollReveal>
        </div>
      </section>
    </div>
  );
}
