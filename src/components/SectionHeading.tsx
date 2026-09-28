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
    <div className={`mb-10 sm:mb-12 ${center ? "text-center mx-auto max-w-3xl" : "max-w-3xl"} space-y-2.5`}>
      {badge && (
        <div>
          <span
            className={`inline-flex items-center px-3 py-1 rounded-md text-xs font-semibold uppercase tracking-wider border ${
              dark
                ? "bg-[#072413] text-[#EDE2D3] border-[#2F7D4A]/40"
                : "bg-[#E8F3EA] text-[#14532D] border-[#2F7D4A]/25"
            }`}
          >
            {badge}
          </span>
        </div>
      )}

      <h2
        className={`font-heading font-black text-2xl sm:text-3xl lg:text-4xl tracking-tight leading-tight ${
          dark ? "text-white" : "text-[#14532D]"
        }`}
      >
        {title}
      </h2>

      {subtitle && (
        <p
          className={`text-sm sm:text-base leading-relaxed ${
            dark ? "text-stone-300" : "text-stone-600"
          }`}
        >
          {subtitle}
        </p>
      )}
    </div>
  );
}
