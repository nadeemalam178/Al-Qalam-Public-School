import React from "react";
import { BookOpen, Sparkles, MonitorPlay, ShieldCheck } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function WhyAlQalam() {
  const iconMap = {
    BookOpen: BookOpen,
    Sparkles: Sparkles,
    MonitorPlay: MonitorPlay,
    ShieldCheck: ShieldCheck,
  };

  return (
    <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Heading */}
        <div className="max-w-3xl mx-auto text-center mb-12 sm:mb-16 space-y-3">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/25 text-xs font-semibold uppercase tracking-wider">
            <span>Our Educational Principles</span>
          </div>
          <h2 className="font-heading font-black text-2xl sm:text-3xl lg:text-4xl text-[#14532D] tracking-tight">
            Why Choose Al-Qalam Public School
          </h2>
          <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
            Our educational approach is anchored in four core principles designed to nurture capable, respectful, and curious young minds.
          </p>
        </div>

        {/* 4 Principles in a Clean 4-Column Row */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 sm:gap-8">
          {SCHOOL_DATA.whyAlQalam.map((principle, index) => {
            const IconComponent = iconMap[principle.icon];
            return (
              <div
                key={principle.id}
                className="bg-white p-6 sm:p-7 rounded-xl border border-[#E7E5E4] card-subtle flex flex-col justify-between"
              >
                <div>
                  <div className="flex items-center justify-between mb-4">
                    <div className="w-10 h-10 rounded-lg bg-[#E8F3EA] text-[#14532D] flex items-center justify-center border border-[#2F7D4A]/20">
                      <IconComponent className="w-5 h-5" />
                    </div>
                    <span className="font-mono text-xs font-semibold text-stone-400">
                      0{index + 1}
                    </span>
                  </div>

                  <h3 className="font-heading font-bold text-lg text-[#14532D] mb-2 leading-snug">
                    {principle.title}
                  </h3>

                  <p className="text-stone-600 text-xs sm:text-sm leading-relaxed">
                    {principle.desc}
                  </p>
                </div>

                <div className="mt-6 pt-3 border-t border-stone-100 text-[11px] font-medium text-[#6B4226]">
                  Verified Campus Standard
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
