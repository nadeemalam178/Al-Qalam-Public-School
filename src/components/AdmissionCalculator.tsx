"use client";

import React, { useState } from "react";
import { Calculator, CheckCircle2, AlertCircle, FileText, ArrowRight, Sparkles } from "lucide-react";

interface EligibilityResult {
  cutoffDate: string;
  ageCalculated: {
    years: number;
    months: number;
    totalYearsExact: number;
    display: string;
  };
  statusText: string;
  guidance: string;
  recommendedGrade: string;
  gradeDetails: {
    grade: string;
    category: string;
    monthlyTuition: string;
    annualCharges: string;
    documentsRequired: string[];
  } | null;
}

export default function AdmissionCalculator({ onSelectGrade }: { onSelectGrade?: (grade: string) => void }) {
  const [dob, setDob] = useState("");
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<EligibilityResult | null>(null);
  const [error, setError] = useState<string | null>(null);

  const handleCalculate = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!dob) {
      setError("Please select child's date of birth.");
      return;
    }

    setLoading(true);
    setError(null);

    try {
      const res = await fetch("/api/eligibility", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ dob, sessionYear: 2026 }),
      });
      const data = await res.json();
      if (!res.ok || !data.success) {
        setError(data.message || "Unable to check eligibility.");
      } else {
        setResult(data);
      }
    } catch {
      setError("Network error. Please try again or visit school administrative desk.");
    } finally {
      setLoading(false);
    }
  };

  const handleApplyClick = () => {
    if (result?.recommendedGrade) {
      if (onSelectGrade) {
        onSelectGrade(result.recommendedGrade);
      } else {
        const formEl = document.getElementById("admissions");
        if (formEl) {
          formEl.scrollIntoView({ behavior: "smooth" });
        }
      }
    }
  };

  return (
    <div className="bg-white rounded-2xl border border-stone-200/90 shadow-md p-6 sm:p-8 space-y-6">
      <div className="flex items-start justify-between gap-4">
        <div className="space-y-1">
          <div className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-md bg-[#E8F3EA] text-[#14532D] text-xs font-bold uppercase tracking-wider">
            <Calculator className="w-3.5 h-3.5" />
            <span>NEP 2020 Age Calculator</span>
          </div>
          <h3 className="font-heading font-bold text-xl sm:text-2xl text-stone-900 tracking-tight">
            Check Grade & Class Eligibility
          </h3>
          <p className="text-stone-600 text-xs sm:text-sm">
            Enter your child&apos;s date of birth to calculate exact age and find the eligible academic class as per National Education Policy norms.
          </p>
        </div>
      </div>

      <form onSubmit={handleCalculate} className="grid grid-cols-1 sm:grid-cols-12 gap-3 sm:gap-4 items-end">
        <div className="sm:col-span-8 space-y-1.5">
          <label htmlFor="dob-input" className="block text-xs font-semibold uppercase tracking-wider text-stone-700">
            Child&apos;s Date of Birth (DOB)
          </label>
          <input
            id="dob-input"
            type="date"
            value={dob}
            onChange={(e) => setDob(e.target.value)}
            max={new Date().toISOString().split("T")[0]}
            min="2012-01-01"
            className="w-full px-3.5 py-2.5 rounded-xl border border-stone-300 text-stone-800 text-sm focus:outline-none focus:ring-2 focus:ring-[#14532D]/30 focus:border-[#14532D] transition-colors"
            required
          />
        </div>

        <div className="sm:col-span-4">
          <button
            type="submit"
            disabled={loading}
            className="w-full inline-flex items-center justify-center gap-2 px-4 py-2.5 rounded-xl bg-[#14532D] hover:bg-[#0E3D1E] text-white text-sm font-semibold shadow-xs transition-all active:scale-[0.98] disabled:opacity-60 cursor-pointer"
          >
            {loading ? (
              <span className="inline-block w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
            ) : (
              <>
                <span>Check Eligibility</span>
                <Sparkles className="w-4 h-4 text-[#C5A059]" />
              </>
            )}
          </button>
        </div>
      </form>

      {error && (
        <div className="p-3.5 rounded-xl bg-amber-50 border border-amber-200 text-amber-900 text-xs flex items-center gap-2">
          <AlertCircle className="w-4 h-4 text-amber-600 shrink-0" />
          <span>{error}</span>
        </div>
      )}

      {result && (
        <div className="mt-4 p-5 rounded-xl bg-stone-50 border border-stone-200/80 space-y-4 animate-in fade-in duration-300">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-3 border-b border-stone-200">
            <div>
              <span className="text-xs font-medium text-stone-500 uppercase tracking-wide">Calculated Age (Cutoff: {result.cutoffDate})</span>
              <p className="font-heading font-bold text-lg text-stone-900">{result.ageCalculated.display}</p>
            </div>
            <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-lg bg-[#E8F3EA] text-[#14532D] font-bold text-sm">
              <CheckCircle2 className="w-4 h-4" />
              <span>Recommended: {result.recommendedGrade}</span>
            </div>
          </div>

          <p className="text-xs sm:text-sm text-stone-600 leading-relaxed">
            {result.guidance}
          </p>

          {result.gradeDetails && (
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3 pt-1">
              <div className="p-3 bg-white rounded-lg border border-stone-200/70 text-xs space-y-1">
                <span className="text-stone-400 font-semibold uppercase tracking-wider text-[10px]">Fee Estimate</span>
                <div className="flex items-center justify-between text-stone-700">
                  <span>Monthly Tuition:</span>
                  <span className="font-bold text-stone-900">{result.gradeDetails.monthlyTuition}</span>
                </div>
                <div className="flex items-center justify-between text-stone-700">
                  <span>Annual Development:</span>
                  <span className="font-bold text-stone-900">{result.gradeDetails.annualCharges}</span>
                </div>
              </div>

              <div className="p-3 bg-white rounded-lg border border-stone-200/70 text-xs space-y-1.5">
                <span className="text-stone-400 font-semibold uppercase tracking-wider text-[10px] flex items-center gap-1">
                  <FileText className="w-3 h-3 text-[#14532D]" />
                  Required Checklist
                </span>
                <ul className="text-stone-600 space-y-0.5 text-[11px] list-disc list-inside">
                  {result.gradeDetails.documentsRequired.slice(0, 2).map((doc, idx) => (
                    <li key={idx} className="truncate">{doc}</li>
                  ))}
                </ul>
              </div>
            </div>
          )}

          <div className="pt-2 flex flex-col sm:flex-row gap-2.5">
            <button
              type="button"
              onClick={handleApplyClick}
              className="inline-flex items-center justify-center gap-2 px-4 py-2 rounded-lg bg-[#14532D] hover:bg-[#0E3D1E] text-white text-xs font-semibold shadow-xs transition-colors cursor-pointer"
            >
              <span>Apply Online for {result.recommendedGrade}</span>
              <ArrowRight className="w-3.5 h-3.5" />
            </button>
            <a
              href="tel:+919308462418"
              className="inline-flex items-center justify-center gap-2 px-4 py-2 rounded-lg bg-white hover:bg-stone-100 text-stone-700 border border-stone-300 text-xs font-semibold transition-colors"
            >
              <span>Call Campus Helpline (+91 93084 62418)</span>
            </a>
          </div>
        </div>
      )}
    </div>
  );
}
