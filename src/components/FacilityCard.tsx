import React from "react";
import Image from "next/image";
import { Camera, MonitorPlay, CheckCircle2, ShieldCheck } from "lucide-react";
import { FacilityItem } from "@/data/schoolData";
import { schoolImages } from "@/data/schoolImages";

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

  const getFacilityImage = () => {
    if (facility.id === "smart-classes") {
      return schoolImages.smartClass;
    }
    return schoolImages.cctv;
  };

  const imageObj = getFacilityImage();

  return (
    <div
      className={`card-interactive group rounded-3xl bg-white border overflow-hidden flex flex-col justify-between shadow-xs ${
        featured ? "border-[#2F7D4A]/40 ring-1 ring-[#166534]/10" : "border-stone-200"
      }`}
    >
      <div>
        {/* Visual Sample Image with Smooth Hover Zoom */}
        <div className="img-zoom-parent relative h-52 sm:h-56 w-full bg-stone-100">
          <Image
            src={imageObj.src}
            alt={imageObj.alt}
            fill
            sizes="(max-width: 768px) 100vw, 50vw"
            className="img-zoom-child object-cover object-center"
          />
          <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-black/10" />

          {/* Floating Badge on Image */}
          <div className="absolute top-4 right-4 z-10">
            <span className="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider bg-white/95 text-[#6B4226] border border-[#EDE2D3] shadow-xs backdrop-blur-xs">
              {facility.badge}
            </span>
          </div>

          {/* Floating Icon */}
          <div className="absolute bottom-4 left-4 z-10 flex items-center gap-3">
            <div className="w-12 h-12 rounded-2xl flex items-center justify-center bg-white/95 text-[#166534] border border-[#2F7D4A]/25 shadow-md backdrop-blur-xs transition-transform duration-300 group-hover:scale-105">
              {renderIcon(facility.iconName)}
            </div>
            <div>
              <span className="text-[11px] font-bold text-white uppercase tracking-wider drop-shadow-xs">
                Confirmed Facility
              </span>
              <h3 className="text-lg font-bold text-white leading-tight drop-shadow-sm">
                {facility.title}
              </h3>
            </div>
          </div>
        </div>

        {/* Content Body */}
        <div className="p-6 sm:p-8">
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
      </div>

      {/* Confirmed Status Pill */}
      <div className="mx-6 sm:mx-8 mb-6 pt-4 border-t border-stone-100 flex items-center justify-between text-xs text-stone-500">
        <span className="flex items-center gap-1.5 font-semibold text-[#14532D]">
          <span className="w-2 h-2 rounded-full bg-[#166534] animate-pulse" />
          Verified Campus Facility
        </span>
        <span className="text-stone-400">Gulzarbagh Campus</span>
      </div>
    </div>
  );
}
