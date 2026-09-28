"use client";

import React from "react";
import Link from "next/link";
import { Award, Sparkles, BookOpen, MapPin, Compass } from "lucide-react";

const announcements = [
  {
    icon: Award,
    text: "Rotary Shiksha Ratna Samman conferred upon Director Rahat Jahan by Hon'ble CM Nitish Kumar",
    link: "/gallery",
  },
  {
    icon: Sparkles,
    text: "Admissions Open for Foundational & Primary Sessions (Pre-Nursery to Class 5)",
    link: "/admissions",
  },
  {
    icon: BookOpen,
    text: "Annual Computer & Knowledge Quiz Competition successfully held on campus",
    link: "/gallery",
  },
  {
    icon: Compass,
    text: "Educational Study Tours to Bapu Tower & Eco Park completed",
    link: "/gallery",
  },
  {
    icon: MapPin,
    text: "Campus Desk: Ashok Rajpath Rd, Opp. Jashn Palace, Loharwa Ghat, Gulzarbagh, Patna",
    link: "/contact",
  },
];

export default function AnnouncementMarquee() {
  return (
    <div className="relative overflow-hidden bg-gradient-to-r from-[#0B3B20] via-[#14532D] to-[#0B3B20] text-[#EDE2D3] border-y border-[#2F7D4A]/30 py-2.5 shadow-xs select-none">
      {/* Ambient gradient glow edges */}
      <div className="absolute left-0 top-0 bottom-0 w-12 bg-gradient-to-r from-[#0B3B20] to-transparent z-10 pointer-events-none" />
      <div className="absolute right-0 top-0 bottom-0 w-12 bg-gradient-to-l from-[#0B3B20] to-transparent z-10 pointer-events-none" />

      <div className="animate-marquee items-center gap-8 text-xs font-medium">
        {/* First repetition */}
        {announcements.map((item, idx) => {
          const Icon = item.icon;
          return (
            <Link
              key={`ann-1-${idx}`}
              href={item.link}
              className="inline-flex items-center gap-2 hover:text-white transition-colors shrink-0 group"
            >
              <span className="p-1 rounded-full bg-[#166534] text-[#C6E7CE] group-hover:scale-110 transition-transform">
                <Icon className="w-3.5 h-3.5" />
              </span>
              <span>{item.text}</span>
              <span className="text-[#C6E7CE]/40 ml-4">•</span>
            </Link>
          );
        })}

        {/* Second repetition for seamless infinite loop */}
        {announcements.map((item, idx) => {
          const Icon = item.icon;
          return (
            <Link
              key={`ann-2-${idx}`}
              href={item.link}
              className="inline-flex items-center gap-2 hover:text-white transition-colors shrink-0 group"
            >
              <span className="p-1 rounded-full bg-[#166534] text-[#C6E7CE] group-hover:scale-110 transition-transform">
                <Icon className="w-3.5 h-3.5" />
              </span>
              <span>{item.text}</span>
              <span className="text-[#C6E7CE]/40 ml-4">•</span>
            </Link>
          );
        })}
      </div>
    </div>
  );
}
