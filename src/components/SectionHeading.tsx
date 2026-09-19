import React from "react";

interface SectionHeadingProps {
  badge?: string;
  title: string;
  subtitle?: string;
  center?: boolean;
  dark?: boolean;
}

export default function SectionHeading({
  badge,
  title,
  subtitle,
  center = false,
  dark = false,
}: SectionHeadingProps) {
  return (
    <div className={`mb-10 sm:mb-14 ${center ? "text-center mx-auto max-w-3xl" : "max-w-3xl"}`}>
      {badge && (
        <div
          className={`inline-flex items-center gap-2 px-3.5 py-1 rounded-full text-xs font-bold uppercase tracking-wider mb-3.5 border ${
            dark
              ? "bg-[#166534]/40 text-[#FAF8F2] border-[#2F7D4A]/60"
              : "bg-[#E8F3EA] text-[#14532D] border-[#2F7D4A]/25"
          }`}
        >
          <span className="w-1.5 h-1.5 rounded-full bg-[#6B4226]" />
          <span>{badge}</span>
        </div>
      )}

      <h2
        className={`text-2xl sm:text-3xl lg:text-4xl font-extrabold tracking-tight leading-tight ${
          dark ? "text-white" : "text-[#14532D]"
        }`}
      >
        {title}
      </h2>

      {/* Subtle dual-color decorative accent line below heading */}
      <div className={`flex items-center gap-1.5 my-3.5 ${center ? "justify-center" : ""}`}>
        <span className="h-1 w-10 rounded-full bg-[#166534]" />
        <span className="h-1 w-3.5 rounded-full bg-[#6B4226]" />
        <span className="h-1 w-1.5 rounded-full bg-[#EDE2D3]" />
      </div>

      {subtitle && (
        <p
          className={`text-sm sm:text-base leading-relaxed ${
            dark ? "text-[#EDE2D3]" : "text-stone-600"
          }`}
        >
          {subtitle}
        </p>
      )}
    </div>
  );
}
