import React from "react";
import Link from "next/link";
import { ArrowRight, GraduationCap } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function AcademicsSection() {
  const [foundational, primary] = SCHOOL_DATA.academicStages;

  return (
    <section className="py-16 sm:py-20 lg:py-24 bg-white border-b border-[#E7E5E4]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Heading with Right Link */}
        <div className="flex flex-col md:flex-row md:items-end justify-between gap-4 mb-12 sm:mb-14">
          <div className="space-y-3">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#FAF8F2] border border-[#EDE2D3] text-[#6B4226] text-xs font-semibold uppercase tracking-wider">
              <GraduationCap className="w-3.5 h-3.5 text-[#14532D]" />
              <span>Academic Curriculum</span>
            </div>
            <h2 className="font-heading font-black text-2xl sm:text-3xl lg:text-4xl text-[#14532D] tracking-tight">
              Foundational & Primary Learning
            </h2>
            <p className="text-stone-600 text-sm sm:text-base max-w-2xl leading-relaxed">
              Structured academic pathways designed to transition children smoothly from playful early readiness to confident primary school literacy and numeracy.
            </p>
          </div>

          <Link
            href="/academics"
            className="btn-primary inline-flex items-center gap-2 px-5 py-2.5 rounded-lg text-xs font-semibold text-[#14532D] bg-[#FAF8F2] hover:bg-[#E8F3EA] border border-[#EDE2D3] transition-colors shrink-0"
          >
            <span>Explore Academics</span>
            <ArrowRight className="w-3.5 h-3.5 text-[#6B4226]" />
          </Link>
        </div>

        {/* Two-Column Editorial Layout */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 lg:gap-10">
          {/* Stage 1: Foundational Learning */}
          <div className="bg-[#FAF8F2] rounded-2xl p-6 sm:p-8 border border-[#EDE2D3] flex flex-col justify-between">
            <div className="space-y-4">
              <div className="flex items-center justify-between border-b border-[#EDE2D3] pb-3">
                <span className="text-xs font-bold uppercase tracking-wider text-[#14532D] bg-[#E8F3EA] px-2.5 py-1 rounded-md border border-[#2F7D4A]/20">
                  {foundational.grades}
                </span>
                <span className="text-xs font-medium text-[#6B4226]">Stage 01</span>
              </div>

              <h3 className="font-heading font-bold text-xl sm:text-2xl text-[#14532D]">
                {foundational.stageName}
              </h3>

              <p className="text-stone-700 text-sm leading-relaxed">
                {foundational.description}
              </p>

              <div className="pt-2">
                <p className="text-xs font-bold uppercase tracking-wider text-[#6B4226] mb-3">
                  Core Developmental Areas:
                </p>
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5">
                  <div className="p-3 bg-white rounded-lg border border-[#E7E5E4] text-xs">
                    <p className="font-semibold text-[#14532D]">Language Readiness</p>
                    <p className="text-stone-500 mt-0.5">Phonetic sound recognition, rhymes, and active listening</p>
                  </div>
                  <div className="p-3 bg-white rounded-lg border border-[#E7E5E4] text-xs">
                    <p className="font-semibold text-[#14532D]">Early Numeracy</p>
                    <p className="text-stone-500 mt-0.5">Counting sense, shape sorting, and visual patterns</p>
                  </div>
                  <div className="p-3 bg-white rounded-lg border border-[#E7E5E4] text-xs">
                    <p className="font-semibold text-[#14532D]">Motor Development</p>
                    <p className="text-stone-500 mt-0.5">Pencil grip, coloring, and tactile coordination</p>
                  </div>
                  <div className="p-3 bg-white rounded-lg border border-[#E7E5E4] text-xs">
                    <p className="font-semibold text-[#14532D]">Social Development</p>
                    <p className="text-stone-500 mt-0.5">Respectful interaction, sharing, and routine building</p>
                  </div>
                </div>
              </div>
            </div>

            <div className="mt-6 pt-4 border-t border-[#EDE2D3] flex items-center justify-between text-xs">
              <span className="text-stone-500 font-medium">Focus: {foundational.focus}</span>
              <Link
                href="/admissions"
                className="font-semibold text-[#14532D] hover:underline"
              >
                Inquire for Pre-Primary →
              </Link>
            </div>
          </div>

          {/* Stage 2: Primary Education */}
          <div className="bg-[#FAF8F2] rounded-2xl p-6 sm:p-8 border border-[#EDE2D3] flex flex-col justify-between">
            <div className="space-y-4">
              <div className="flex items-center justify-between border-b border-[#EDE2D3] pb-3">
                <span className="text-xs font-bold uppercase tracking-wider text-[#14532D] bg-[#E8F3EA] px-2.5 py-1 rounded-md border border-[#2F7D4A]/20">
                  {primary.grades}
                </span>
                <span className="text-xs font-medium text-[#6B4226]">Stage 02</span>
              </div>

              <h3 className="font-heading font-bold text-xl sm:text-2xl text-[#14532D]">
                {primary.stageName}
              </h3>

              <p className="text-stone-700 text-sm leading-relaxed">
                {primary.description}
              </p>

              <div className="pt-2">
                <p className="text-xs font-bold uppercase tracking-wider text-[#6B4226] mb-3">
                  Core Subject Learning:
                </p>
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5">
                  <div className="p-3 bg-white rounded-lg border border-[#E7E5E4] text-xs">
                    <p className="font-semibold text-[#14532D]">Mathematics</p>
                    <p className="text-stone-500 mt-0.5">Arithmetic fluency, tables, problem solving, and logic</p>
                  </div>
                  <div className="p-3 bg-white rounded-lg border border-[#E7E5E4] text-xs">
                    <p className="font-semibold text-[#14532D]">Languages</p>
                    <p className="text-stone-500 mt-0.5">Reading comprehension, neat penmanship, and grammar</p>
                  </div>
                  <div className="p-3 bg-white rounded-lg border border-[#E7E5E4] text-xs">
                    <p className="font-semibold text-[#14532D]">Environmental Studies</p>
                    <p className="text-stone-500 mt-0.5">Nature, health, hygiene, and community observation</p>
                  </div>
                  <div className="p-3 bg-white rounded-lg border border-[#E7E5E4] text-xs">
                    <p className="font-semibold text-[#14532D]">Smart Class Learning</p>
                    <p className="text-stone-500 mt-0.5">Audio-visual reinforcement of complex textbook topics</p>
                  </div>
                </div>
              </div>
            </div>

            <div className="mt-6 pt-4 border-t border-[#EDE2D3] flex items-center justify-between text-xs">
              <span className="text-stone-500 font-medium">Focus: {primary.focus}</span>
              <Link
                href="/admissions"
                className="font-semibold text-[#14532D] hover:underline"
              >
                Inquire for Primary →
              </Link>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
