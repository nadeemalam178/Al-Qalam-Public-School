import React from "react";
import { Camera, MonitorPlay, CheckCircle2, ShieldCheck } from "lucide-react";
import { FacilityItem } from "@/data/schoolData";

interface FacilityCardProps {
  facility: FacilityItem;
  featured?: boolean;
}

export default function FacilityCard({ facility, featured = false }: FacilityCardProps) {
  const renderIcon = (name: FacilityItem["iconName"]) => {
    switch (name) {
      case "Camera":
        return <Camera className="w-6 h-6 text-[#166534]" />;
      case "MonitorPlay":
        return <MonitorPlay className="w-6 h-6 text-[#166534]" />;
      default:
        return <ShieldCheck className="w-6 h-6 text-[#166534]" />;
    }
  };

  return (
    <div
      className={`group rounded-2xl bg-white p-6 sm:p-8 border transition-all duration-200 flex flex-col justify-between shadow-xs hover:shadow-md ${
        featured ? "border-[#2F7D4A]/40 ring-1 ring-[#166534]/10" : "border-stone-200"
      }`}
    >
      <div>
        {/* Header with Icon and Badge */}
        <div className="flex items-start justify-between gap-4 mb-5">
          <div className="w-13 h-13 rounded-xl flex items-center justify-center border bg-[#E8F3EA] border-[#2F7D4A]/25 transition-transform duration-200 group-hover:scale-105">
            {renderIcon(facility.iconName)}
          </div>
          <span className="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider border bg-[#FAF8F2] text-[#6B4226] border-[#EDE2D3]">
            {facility.badge}
          </span>
        </div>

        {/* Title & Description */}
        <h3 className="text-xl sm:text-2xl font-bold text-[#14532D] tracking-tight mb-2.5 group-hover:text-[#166534] transition-colors">
          {facility.title}
        </h3>
        <p className="text-sm sm:text-base text-stone-600 leading-relaxed mb-6">
          {facility.fullDesc}
        </p>

        {/* Features Checklist */}
        <div className="border-t border-stone-100 pt-5 space-y-2.5">
          <p className="text-xs font-bold uppercase tracking-wider text-[#6B4226]">
            Key Highlights
          </p>
          <ul className="space-y-2">
            {facility.features.map((feat, idx) => (
              <li key={idx} className="flex items-start gap-2.5 text-xs sm:text-sm text-stone-700">
                <CheckCircle2 className="w-4 h-4 text-[#166534] shrink-0 mt-0.5" />
                <span>{feat}</span>
              </li>
            ))}
          </ul>
        </div>
      </div>

      {/* Confirmed Status Pill */}
      <div className="mt-6 pt-4 border-t border-stone-100 flex items-center justify-between text-xs text-stone-500">
        <span className="flex items-center gap-1.5 font-semibold text-[#14532D]">
          <span className="w-2 h-2 rounded-full bg-[#166534]" />
          Verified Campus Facility
        </span>
        <span className="text-stone-400">Gulzarbagh Campus</span>
      </div>
    </div>
  );
}
