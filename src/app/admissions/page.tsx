import React from "react";
import type { Metadata } from "next";
import { GraduationCap, FileCheck, CheckCircle2, HelpCircle, MapPin } from "lucide-react";
import AdmissionForm from "@/components/AdmissionForm";
import { SCHOOL_DATA } from "@/data/schoolData";

export const metadata: Metadata = {
  title: "Admissions & Enrollment Process",
  description:
    "Admissions at Al-Qalam Public School, Gulzarbagh, Patna. Learn about the 4-step admission process, required documentation, class eligibility, and submit an online enquiry.",
};

export default function AdmissionsPage() {
  const requiredDocuments = [
    "Original and photocopy of Student's Birth Certificate (issued by Municipal authority)",
    "Recent passport-sized photographs of the student (4 copies)",
    "Recent passport-sized photographs of parents / guardian (2 copies each)",
    "Photocopy of Parent's / Guardian's Government ID and Residential Address Proof",
    "Previous class report card or Transfer Certificate (if applicable for higher primary classes)",
    "Basic immunization / health record copy for pre-primary learners",
  ];

  return (
    <div className="bg-white">
      {/* 1. Hero Banner */}
      <section className="bg-forest-hero text-white py-14 sm:py-18 lg:py-20 border-b border-[#0B3B20]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-3">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#072413] border border-[#2F7D4A]/40 text-[#EDE2D3] text-xs font-semibold uppercase tracking-wider">
            <GraduationCap className="w-3.5 h-3.5" />
            <span>Admissions Desk</span>
          </div>
          <h1 className="font-heading font-black text-3xl sm:text-4xl lg:text-5xl text-white tracking-tight">
            Admissions at Al-Qalam Public School
          </h1>
          <p className="text-base sm:text-lg text-stone-200 max-w-2xl mx-auto leading-relaxed">
            Welcoming foundational and primary learners into a disciplined, caring, and values-centered school in Gulzarbagh, Patna.
          </p>
        </div>
      </section>

      {/* 2. Main Admissions Content: Process + Form */}
      <section className="py-16 sm:py-20 bg-white border-b border-[#E7E5E4]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 items-start">
            {/* Left Column: Who Can Apply, Timeline & Documents */}
            <div className="lg:col-span-6 space-y-10">
              <div className="space-y-4">
                <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#FAF8F2] border border-[#EDE2D3] text-[#6B4226] text-xs font-semibold uppercase tracking-wider">
                  <span>Eligibility & Enrollment</span>
                </div>
                <h2 className="font-heading font-black text-2xl sm:text-3xl text-[#14532D] tracking-tight">
                  Who Can Enquire & How the Process Works
                </h2>
                <p className="text-stone-700 text-sm sm:text-base leading-relaxed">
                  Al-Qalam Public School invites enquiries for children entering <strong>Foundational Education</strong> (Pre-School, LKG, UKG) and <strong>Primary Education</strong> (Classes 1 through 5). We seek to make admissions transparent, straightforward, and supportive for parents.
                </p>
              </div>

              {/* Clean Vertical Process Timeline (Section 13) */}
              <div id="process" className="space-y-4">
                <h3 className="font-heading font-bold text-lg text-[#14532D]">
                  Admission Steps:
                </h3>
                <div className="space-y-3.5">
                  {SCHOOL_DATA.admissionProcess.map((step) => (
                    <div
                      key={step.step}
                      className="bg-[#FAF8F2] rounded-xl p-5 border border-[#EDE2D3] flex items-start gap-4 card-subtle"
                    >
                      <div className="w-10 h-10 rounded-lg bg-[#14532D] text-white flex items-center justify-center font-mono font-bold text-sm shrink-0">
                        {step.step}
                      </div>
                      <div className="space-y-1">
                        <h4 className="font-heading font-bold text-base text-[#14532D]">
                          {step.title}
                        </h4>
                        <p className="text-xs text-[#6B4226] font-medium">
                          {step.subtitle}
                        </p>
                        <p className="text-xs sm:text-sm text-stone-600 leading-relaxed pt-0.5">
                          {step.description}
                        </p>
                      </div>
                    </div>
                  ))}
                </div>
              </div>

              {/* Required Documents Checklist */}
              <div className="bg-white rounded-xl p-6 border border-[#E7E5E4] space-y-4">
                <div className="flex items-center gap-2.5 text-[#14532D]">
                  <FileCheck className="w-5 h-5 text-[#166534]" />
                  <h3 className="font-heading font-bold text-base sm:text-lg text-[#14532D]">
                    Required Documents Checklist
                  </h3>
                </div>
                <p className="text-xs text-stone-500">
                  Please prepare the following items when completing verification at the campus desk:
                </p>
                <ul className="space-y-2 pt-1">
                  {requiredDocuments.map((doc, idx) => (
                    <li key={idx} className="flex items-start gap-2.5 text-xs text-stone-700">
                      <CheckCircle2 className="w-4 h-4 text-[#166534] shrink-0 mt-0.5" />
                      <span>{doc}</span>
                    </li>
                  ))}
                </ul>
              </div>

              {/* Campus Desk Help Note */}
              <div className="bg-[#FAF8F2] border border-[#EDE2D3] rounded-xl p-4 sm:p-5 flex items-start gap-3.5 text-xs text-stone-700">
                <HelpCircle className="w-5 h-5 text-[#6B4226] shrink-0 mt-0.5" />
                <div className="leading-relaxed">
                  <span className="font-bold text-[#14532D]">Fee Schedules & Class Placements:</span> Official fee details, age guidelines, and uniform requirements are provided directly by our campus desk during school office hours.
                </div>
              </div>
            </div>

            {/* Right Column: Lead Generation Form */}
            <div className="lg:col-span-6 lg:sticky lg:top-24">
              <AdmissionForm />
            </div>
          </div>
        </div>
      </section>

      {/* Campus Visit Note */}
      <section className="py-12 bg-[#FAF8F2]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="bg-white rounded-xl p-6 sm:p-8 border border-[#E7E5E4] flex flex-col md:flex-row items-center justify-between gap-6">
            <div className="space-y-1.5 text-center md:text-left">
              <span className="text-xs uppercase tracking-wider text-[#6B4226] font-semibold">
                In-Person Campus Visits
              </span>
              <h3 className="font-heading font-bold text-xl text-[#14532D]">
                Visit our Admissions Office
              </h3>
              <p className="text-xs sm:text-sm text-stone-600 max-w-xl">
                Opposite Jashn Palace Marriage Hall, Ashok Rajpath Rd, Gulzarbagh, Alamganj, Patna.
              </p>
            </div>
            <a
              href={SCHOOL_DATA.address.googleMapsUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="btn-primary shrink-0 px-5 py-2.5 rounded-lg text-xs font-semibold text-white bg-[#14532D] hover:bg-[#0B3B20] shadow-xs flex items-center gap-2"
            >
              <MapPin className="w-3.5 h-3.5 text-[#EDE2D3]" />
              <span>Get Directions to School</span>
            </a>
          </div>
        </div>
      </section>
    </div>
  );
}
