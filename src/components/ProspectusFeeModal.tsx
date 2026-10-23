"use client";

import React, { useState } from "react";
import { X, Printer, CheckCircle, FileText, MapPin } from "lucide-react";

interface GradeFee {
  grade: string;
  category: "Foundational" | "Primary";
  ageBracket: string;
  monthlyTuition: string;
  admissionFee: string;
  annualCharges: string;
}

const FEE_SCHEDULE: GradeFee[] = [
  {
    grade: "Nursery / Pre-School",
    category: "Foundational",
    ageBracket: "3+ Years",
    monthlyTuition: "₹750",
    admissionFee: "₹1,500",
    annualCharges: "₹1,500",
  },
  {
    grade: "Lower Kindergarten (LKG)",
    category: "Foundational",
    ageBracket: "4+ Years",
    monthlyTuition: "₹850",
    admissionFee: "₹1,500",
    annualCharges: "₹1,500",
  },
  {
    grade: "Upper Kindergarten (UKG)",
    category: "Foundational",
    ageBracket: "5+ Years",
    monthlyTuition: "₹950",
    admissionFee: "₹1,800",
    annualCharges: "₹1,800",
  },
  {
    grade: "Class 1",
    category: "Primary",
    ageBracket: "6+ Years",
    monthlyTuition: "₹1,100",
    admissionFee: "₹2,000",
    annualCharges: "₹2,000",
  },
  {
    grade: "Class 2",
    category: "Primary",
    ageBracket: "7+ Years",
    monthlyTuition: "₹1,150",
    admissionFee: "₹2,000",
    annualCharges: "₹2,000",
  },
  {
    grade: "Class 3",
    category: "Primary",
    ageBracket: "8+ Years",
    monthlyTuition: "₹1,200",
    admissionFee: "₹2,200",
    annualCharges: "₹2,200",
  },
  {
    grade: "Class 4",
    category: "Primary",
    ageBracket: "9+ Years",
    monthlyTuition: "₹1,250",
    admissionFee: "₹2,200",
    annualCharges: "₹2,200",
  },
  {
    grade: "Class 5",
    category: "Primary",
    ageBracket: "10+ Years",
    monthlyTuition: "₹1,300",
    admissionFee: "₹2,200",
    annualCharges: "₹2,200",
  },
];

export default function ProspectusFeeModal({
  isOpen,
  onClose,
}: {
  isOpen: boolean;
  onClose: () => void;
}) {
  const [activeTab, setActiveTab] = useState<"fees" | "docs" | "guidelines">("fees");

  if (!isOpen) return null;

  const handlePrint = () => {
    window.print();
  };

  return (
    <div
      role="dialog"
      aria-modal="true"
      aria-labelledby="prospectus-title"
      className="fixed inset-0 z-50 flex items-center justify-center p-3 sm:p-6 bg-black/75 backdrop-blur-sm animate-fadeIn"
      onClick={onClose}
    >
      <div
        className="relative max-w-4xl w-full bg-white rounded-3xl overflow-hidden shadow-2xl flex flex-col max-h-[92vh] border border-stone-200"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header Bar */}
        <div className="flex items-center justify-between px-6 py-4 bg-gradient-to-r from-[#14532D] to-[#0A3018] text-white">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-white/10 flex items-center justify-center border border-white/20">
              <FileText className="w-5 h-5 text-amber-300" />
            </div>
            <div>
              <h3 id="prospectus-title" className="font-heading font-bold text-base sm:text-lg">
                Official Fee Structure &amp; Prospectus 2026–27
              </h3>
              <p className="text-[11px] text-emerald-200">
                Al-Qalam Public School • Gulzarbagh, Patna
              </p>
            </div>
          </div>

          <div className="flex items-center gap-2">
            <button
              onClick={handlePrint}
              title="Print Prospectus"
              className="p-2 rounded-xl bg-white/10 hover:bg-white/20 text-white transition-colors cursor-pointer text-xs flex items-center gap-1.5"
            >
              <Printer className="w-4 h-4" />
              <span className="hidden sm:inline font-semibold">Print</span>
            </button>
            <button
              onClick={onClose}
              className="p-2 rounded-xl bg-white/10 hover:bg-white/20 text-white transition-colors cursor-pointer"
              aria-label="Close modal"
            >
              <X className="w-5 h-5" />
            </button>
          </div>
        </div>

        {/* Tab Navigation */}
        <div className="flex items-center border-b border-stone-200 px-6 bg-stone-50 text-xs font-semibold">
          <button
            onClick={() => setActiveTab("fees")}
            className={`py-3 px-4 border-b-2 transition-colors cursor-pointer ${
              activeTab === "fees"
                ? "border-[#14532D] text-[#14532D] bg-white font-bold"
                : "border-transparent text-stone-600 hover:text-stone-900"
            }`}
          >
            Fee Schedule (Nursery – Class 5)
          </button>
          <button
            onClick={() => setActiveTab("docs")}
            className={`py-3 px-4 border-b-2 transition-colors cursor-pointer ${
              activeTab === "docs"
                ? "border-[#14532D] text-[#14532D] bg-white font-bold"
                : "border-transparent text-stone-600 hover:text-stone-900"
            }`}
          >
            Documents &amp; Age Criteria
          </button>
          <button
            onClick={() => setActiveTab("guidelines")}
            className={`py-3 px-4 border-b-2 transition-colors cursor-pointer ${
              activeTab === "guidelines"
                ? "border-[#14532D] text-[#14532D] bg-white font-bold"
                : "border-transparent text-stone-600 hover:text-stone-900"
            }`}
          >
            School Rules &amp; Timings
          </button>
        </div>

        {/* Content Body */}
        <div className="p-6 overflow-y-auto space-y-6">
          {activeTab === "fees" && (
            <div className="space-y-4">
              <div className="flex items-center justify-between text-xs text-stone-600 pb-2">
                <span className="font-semibold text-stone-900">
                  Affordable &amp; Transparent Primary Schooling
                </span>
                <span className="text-[11px] bg-emerald-50 text-emerald-800 px-2.5 py-0.5 rounded-full border border-emerald-200 font-medium">
                  Session 2026–2027
                </span>
              </div>

              {/* Responsive Table */}
              <div className="border border-stone-200 rounded-xl overflow-hidden shadow-2xs">
                <table className="w-full text-left text-xs">
                  <thead className="bg-[#14532D]/5 text-stone-800 font-bold border-b border-stone-200 uppercase text-[10px] tracking-wider">
                    <tr>
                      <th className="py-3 px-4">Class / Wing</th>
                      <th className="py-3 px-3">Age Criterion</th>
                      <th className="py-3 px-3">Monthly Tuition</th>
                      <th className="py-3 px-3">Admission Fee</th>
                      <th className="py-3 px-4 text-right">Annual Exam / Dev.</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-stone-100">
                    {FEE_SCHEDULE.map((row) => (
                      <tr key={row.grade} className="hover:bg-stone-50/70 transition-colors">
                        <td className="py-3 px-4 font-bold text-stone-900">
                          {row.grade}
                          <span className="block text-[10px] font-normal text-stone-500">
                            {row.category}
                          </span>
                        </td>
                        <td className="py-3 px-3 text-stone-600">{row.ageBracket}</td>
                        <td className="py-3 px-3 font-semibold text-[#14532D]">
                          {row.monthlyTuition}
                          <span className="text-[10px] text-stone-400 font-normal"> / mo</span>
                        </td>
                        <td className="py-3 px-3 text-stone-700">{row.admissionFee}</td>
                        <td className="py-3 px-4 text-right font-medium text-stone-700">
                          {row.annualCharges}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>

              <div className="p-4 rounded-xl bg-stone-50 border border-stone-200 text-xs text-stone-600 space-y-1">
                <p className="font-bold text-stone-900">Fee Payment Notes:</p>
                <ul className="list-disc list-inside space-y-0.5 text-[11px]">
                  <li>Monthly fees are due by the 10th of each calendar month.</li>
                  <li>Fee concessions may be requested for siblings enrolled concurrently.</li>
                  <li>Payment accepted via cash at administrative counter or online UPI scan desk.</li>
                </ul>
              </div>
            </div>
          )}

          {activeTab === "docs" && (
            <div className="space-y-4">
              <h4 className="font-heading font-bold text-sm text-stone-900">
                Required Verification Documents for Admission
              </h4>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {[
                  {
                    title: "Birth Certificate",
                    desc: "Issued by Municipal Corporation or authorized hospital (original for verification + 1 photocopy).",
                  },
                  {
                    title: "Aadhaar Card Copy",
                    desc: "Photocopy of Child's Aadhaar (if made) and Parents' / Guardian's Aadhaar cards for address verification.",
                  },
                  {
                    title: "4 Passport-size Photographs",
                    desc: "Recent color photographs of the student in formal posture with white/light background.",
                  },
                  {
                    title: "Previous Report Card / TC",
                    desc: "Applicable for Class 1 to 5: previous school progress card and Transfer Certificate.",
                  },
                ].map((doc, idx) => (
                  <div
                    key={idx}
                    className="p-4 rounded-xl border border-stone-200 bg-stone-50/50 space-y-1.5"
                  >
                    <div className="flex items-center gap-2 font-bold text-stone-900 text-xs">
                      <CheckCircle className="w-4 h-4 text-emerald-600" />
                      <span>{doc.title}</span>
                    </div>
                    <p className="text-xs text-stone-600 leading-relaxed">{doc.desc}</p>
                  </div>
                ))}
              </div>
            </div>
          )}

          {activeTab === "guidelines" && (
            <div className="space-y-4 text-xs text-stone-700 leading-relaxed">
              <h4 className="font-heading font-bold text-sm text-stone-900">
                School Norms &amp; Operational Conduct
              </h4>
              <div className="space-y-3">
                <div className="p-3.5 rounded-xl border border-stone-200 bg-white">
                  <span className="font-bold text-[#14532D]">School Hours:</span>
                  <p className="mt-0.5 text-stone-600">
                    7:30 AM to 1:30 PM (Monday to Saturday). Students must arrive in complete uniform by 7:25 AM for morning assembly.
                  </p>
                </div>
                <div className="p-3.5 rounded-xl border border-stone-200 bg-white">
                  <span className="font-bold text-[#14532D]">Uniform &amp; Neatness:</span>
                  <p className="mt-0.5 text-stone-600">
                    Designated school uniform with clean polished shoes, ID card badge, and trimmed nails/hair.
                  </p>
                </div>
                <div className="p-3.5 rounded-xl border border-stone-200 bg-white">
                  <span className="font-bold text-[#14532D]">Attendance &amp; Diary:</span>
                  <p className="mt-0.5 text-stone-600">
                    Minimum 75% attendance is required for term exams. Daily homework diary must be countersigned by parents each evening.
                  </p>
                </div>
              </div>
            </div>
          )}
        </div>

        {/* Footer Actions */}
        <div className="px-6 py-4 bg-stone-50 border-t border-stone-200 flex flex-col sm:flex-row items-center justify-between gap-4">
          <div className="flex items-center gap-2 text-xs text-stone-600">
            <MapPin className="w-3.5 h-3.5 text-[#14532D]" />
            <span>Opp. Jashn Palace, Ashok Rajpath Rd, Gulzarbagh, Patna</span>
          </div>

          <div className="flex items-center gap-3">
            <button
              onClick={handlePrint}
              className="px-4 py-2 rounded-xl border border-stone-300 text-stone-700 font-semibold text-xs hover:bg-stone-100 transition-colors flex items-center gap-1.5 cursor-pointer"
            >
              <Printer className="w-3.5 h-3.5" />
              <span>Print Prospectus</span>
            </button>
            <button
              onClick={onClose}
              className="px-5 py-2 rounded-xl bg-[#14532D] text-white font-bold text-xs hover:bg-[#0E3D1E] transition-colors cursor-pointer"
            >
              Close
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
