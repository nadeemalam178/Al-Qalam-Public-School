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
        return <Camera className="w-5 h-5 text-[#14532D]" />;
      case "MonitorPlay":
        return <MonitorPlay className="w-5 h-5 text-[#14532D]" />;
      default:
        return <ShieldCheck className="w-5 h-5 text-[#14532D]" />;
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
      className={`card-subtle group rounded-2xl bg-white border overflow-hidden flex flex-col justify-between shadow-xs ${
        featured ? "border-[#2F7D4A]/40" : "border-stone-200"
      }`}
    >
      <div>
        {/* Facility Image with Subtle Zoom */}
        <div className="img-zoom-box relative h-52 sm:h-60 w-full bg-stone-900 border-b border-stone-200">
          <Image
            src={imageObj.src}
            alt={imageObj.alt}
            fill
            sizes="(max-width: 768px) 100vw, 50vw"
            className="img-zoom-target object-cover object-center"
          />
          <div className="absolute inset-0 bg-gradient-to-t from-black/65 via-transparent to-black/10" />

          {/* Floating Badge */}
          <div className="absolute top-3.5 right-3.5 z-10">
            <span className="inline-flex items-center px-3 py-1 rounded-md text-xs font-semibold bg-white/95 text-[#14532D] shadow-xs backdrop-blur-xs">
              {facility.badge}
            </span>
          </div>

          {/* Floating Title & Icon */}
          <div className="absolute bottom-3.5 left-3.5 right-3.5 z-10 flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl flex items-center justify-center bg-white/95 text-[#14532D] border border-[#2F7D4A]/25 shadow-sm shrink-0">
              {renderIcon(facility.iconName)}
            </div>
            <div>
              <span className="text-[10px] font-semibold text-stone-300 uppercase tracking-wider block">
                Verified Campus Facility
              </span>
              <h3 className="font-heading font-bold text-base sm:text-lg text-white leading-tight drop-shadow-sm">
                {facility.title}
              </h3>
            </div>
          </div>
        </div>

        {/* Content Body */}
        <div className="p-6 sm:p-7 space-y-4">
          <p className="text-sm text-stone-600 leading-relaxed">
            {facility.fullDesc}
          </p>

          <div className="border-t border-stone-100 pt-4 space-y-2">
            <p className="text-xs font-bold uppercase tracking-wider text-[#6B4226]">
              Key Highlights
            </p>
            <ul className="space-y-2">
              {facility.features.map((feat, idx) => (
                <li key={idx} className="flex items-start gap-2.5 text-xs text-stone-700">
                  <CheckCircle2 className="w-4 h-4 text-[#166534] shrink-0 mt-0.5" />
                  <span>{feat}</span>
                </li>
              ))}
            </ul>
          </div>
        </div>
      </div>

      <div className="mx-6 sm:mx-7 mb-6 pt-3.5 border-t border-stone-100 flex items-center justify-between text-xs text-stone-500">
        <span className="font-medium text-[#14532D]">Verified Amenity</span>
        <span>Gulzarbagh, Patna</span>
      </div>
    </div>
  );
}
