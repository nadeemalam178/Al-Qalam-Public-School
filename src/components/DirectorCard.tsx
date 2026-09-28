import React from "react";
import Image from "next/image";
import { UserCheck } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function DirectorCard() {
  return (
    <div className="bg-gradient-to-br from-[#0B3B20] via-[#14532D] to-[#166534] text-white rounded-2xl p-7 sm:p-10 lg:p-12 shadow-md border border-[#14532D]">
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 lg:gap-12 items-center">
        {/* Left: Professional Portrait / Office Representation */}
        <div className="lg:col-span-4 flex flex-col items-center lg:items-start text-center lg:text-left space-y-4">
          <div className="relative w-44 h-44 sm:w-48 sm:h-48 rounded-2xl overflow-hidden shadow-lg border-2 border-[#EDE2D3]/30 bg-stone-900">
            <Image
              src="/images/school/achievements/rotary-shiksha-ratna-award.jpg"
              alt={`Director ${SCHOOL_DATA.director.name} receiving Rotary Shiksha Ratna from CM Nitish Kumar`}
              fill
              sizes="(max-width: 1024px) 200px, 220px"
              className="object-cover object-top"
            />
            <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent pointer-events-none" />

            <div className="absolute bottom-2 left-2 right-2 text-center">
              <span className="text-[10px] font-semibold uppercase tracking-wider text-[#FAF8F2] bg-[#14532D]/90 px-2 py-0.5 rounded border border-white/20 backdrop-blur-xs">
                State Honor Awardee
              </span>
            </div>
          </div>

          <div>
            <div className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded bg-[#FAF8F2]/10 text-[#EDE2D3] text-xs font-semibold uppercase tracking-wider mb-1.5 border border-[#EDE2D3]/20">
              <UserCheck className="w-3.5 h-3.5" />
              <span>School Leadership</span>
            </div>
            <h3 className="font-heading font-black text-2xl text-white tracking-tight">
              {SCHOOL_DATA.director.name}
            </h3>
            <p className="text-xs sm:text-sm font-medium text-[#EDE2D3] mt-0.5">
              {SCHOOL_DATA.director.title}, {SCHOOL_DATA.name}
            </p>
            <p className="text-xs text-stone-300 mt-1">Gulzarbagh, Patna, Bihar</p>
          </div>
        </div>

        {/* Right: Institutional Statement (No Fake Quotes) */}
        <div className="lg:col-span-8 space-y-4 border-t lg:border-t-0 lg:border-l border-[#2F7D4A]/40 pt-6 lg:pt-0 lg:pl-10">
          <div className="inline-flex items-center gap-2 text-xs font-bold uppercase tracking-widest text-[#EDE2D3]">
            <span>Administrative Stewardship</span>
          </div>

          <h4 className="font-heading font-bold text-xl sm:text-2xl text-white">
            Nurturing Disciplined Growth & Foundational Clarity
          </h4>

          <div className="bg-[#072413]/70 rounded-xl p-5 sm:p-6 border border-[#2F7D4A]/40 space-y-3">
            <p className="text-[#FAF8F2] text-sm sm:text-base leading-relaxed">
              {SCHOOL_DATA.director.institutionalStatement}
            </p>
            <div className="border-t border-[#2F7D4A]/30 pt-3 space-y-1.5 text-xs text-stone-300">
              <p className="text-[#EDE2D3] font-semibold flex items-center gap-1.5">
                <span>★</span>
                <span>Rotary Shiksha Ratna Samman Conferred by Chief Minister Nitish Kumar</span>
              </p>
              <p className="leading-relaxed">
                Director Rahat Jahan was honored with the Rotary Shiksha Ratna Samman by Shri Nitish Kumar, Chief Minister of Bihar, organized by Rotary Club Patna City on Teachers&apos; Day, acknowledging dedicated service to primary schooling in Patna.
              </p>
            </div>
          </div>

          <div className="flex flex-wrap items-center justify-between text-xs text-[#EDE2D3] pt-1">
            <span>Al-Qalam Public School • Established in Patna</span>
            <span className="font-semibold italic">&ldquo;{SCHOOL_DATA.tagline}&rdquo;</span>
          </div>
        </div>
      </div>
    </div>
  );
}
