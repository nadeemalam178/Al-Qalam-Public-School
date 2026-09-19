import React from "react";
import Image from "next/image";
import { Quote, UserCheck } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";
import { schoolImages } from "@/data/schoolImages";

export default function DirectorCard() {
  return (
    <div className="card-interactive relative overflow-hidden rounded-3xl bg-gradient-to-br from-[#0d3b1f] via-[#14532D] to-[#166534] text-white p-8 sm:p-12 shadow-lg border border-[#2F7D4A]/40">
      {/* Subtle warm earthy ambient glow */}
      <div className="absolute -top-24 -right-24 w-72 h-72 rounded-full bg-[#EDE2D3]/10 blur-3xl pointer-events-none" />
      <div className="absolute -bottom-24 -left-24 w-72 h-72 rounded-full bg-[#E8F3EA]/10 blur-3xl pointer-events-none" />

      {/* Decorative Crest Watermark in Corner */}
      <div className="absolute -right-10 -bottom-10 w-60 h-60 opacity-[0.035] pointer-events-none select-none hidden lg:block">
        <Image
          src={schoolImages.branding.lightSvg}
          alt=""
          width={240}
          height={240}
          className="w-full h-full object-contain"
        />
      </div>

      <div className="relative z-10 grid grid-cols-1 lg:grid-cols-12 gap-8 items-center">
        {/* Left: Director Details & Temporary Leadership Office Placeholder */}
        <div className="lg:col-span-4 flex flex-col items-center lg:items-start text-center lg:text-left space-y-4 border-b lg:border-b-0 lg:border-r border-[#2F7D4A]/40 pb-6 lg:pb-0 lg:pr-8">
          <div className="relative w-32 h-32 sm:w-36 sm:h-36 rounded-2xl overflow-hidden ring-4 ring-[#EDE2D3]/35 shadow-xl bg-stone-900 flex items-center justify-center group">
            <Image
              src={schoolImages.director.src}
              alt={schoolImages.director.alt}
              fill
              className="object-cover object-center transition-transform duration-500 group-hover:scale-105"
            />
            <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent" />
            
            {/* Embedded Crest Badge */}
            <div className="absolute bottom-2.5 left-2.5 right-2.5 flex items-center justify-between">
              <span className="text-[10px] font-bold uppercase tracking-wider text-white bg-black/60 px-2 py-0.5 rounded backdrop-blur-xs">
                Desk Placeholder
              </span>
              <div className="w-8 h-8 rounded-full bg-white p-1 shadow-md">
                <Image
                  src={schoolImages.branding.primarySvg}
                  alt="Al-Qalam Crest"
                  width={24}
                  height={24}
                  className="w-full h-full object-contain"
                />
              </div>
            </div>
          </div>

          <div>
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-[#E8F3EA]/15 text-[#EDE2D3] text-xs font-bold uppercase tracking-wider mb-2 border border-[#EDE2D3]/20">
              <UserCheck className="w-3.5 h-3.5 text-[#EDE2D3]" />
              <span>Leadership Desk</span>
            </div>
            <h3 className="text-2xl font-black text-white tracking-tight">
              {SCHOOL_DATA.director.name}
            </h3>
            <p className="text-sm font-semibold text-[#EDE2D3] mt-0.5">
              {SCHOOL_DATA.director.title}, {SCHOOL_DATA.name}
            </p>
            <p className="text-xs text-stone-300 mt-1">Gulzarbagh, Patna, Bihar</p>
          </div>
        </div>

        {/* Right: Message Placeholder Block */}
        <div className="lg:col-span-8 flex flex-col justify-center space-y-4">
          <div className="flex items-center gap-3 text-[#EDE2D3]">
            <Quote className="w-8 h-8 opacity-70" />
            <span className="text-xs font-bold uppercase tracking-widest text-[#FAF8F2]">
              Message from the Director
            </span>
          </div>

          {/* Strictly placeholder per prompt instructions */}
          <div className="bg-[#0a2916]/60 rounded-2xl p-6 border border-[#2F7D4A]/40 shadow-inner">
            <p className="text-[#FAF8F2] text-base sm:text-lg italic leading-relaxed">
              &ldquo;{SCHOOL_DATA.director.messagePlaceholder}&rdquo;
            </p>
            <p className="mt-4 text-xs text-[#EDE2D3]">
              Note: The official personal address from Director {SCHOOL_DATA.director.name} will be published upon confirmation.
            </p>
          </div>

          <div className="pt-2 flex items-center justify-between text-xs text-[#EDE2D3]">
            <span>Al-Qalam Public School • Gulzarbagh</span>
            <span className="font-semibold text-white">&ldquo;{SCHOOL_DATA.tagline}&rdquo;</span>
          </div>
        </div>
      </div>
    </div>
  );
}
