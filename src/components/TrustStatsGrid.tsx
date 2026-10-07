import React from "react";
import { Users, ShieldCheck, MonitorPlay, GraduationCap, Award } from "lucide-react";

interface StatItem {
  id: string;
  metric: string;
  label: string;
  sublabel: string;
  badge: string;
  badgeBg: string;
  badgeColor: string;
  icon: React.ComponentType<{ className?: string }>;
}

const STATS: StatItem[] = [
  {
    id: "ratio",
    metric: "1 : 20",
    label: "Teacher-Student Ratio",
    sublabel: "Personalized care & attention",
    badge: "Student First",
    badgeBg: "#E8F3EA",
    badgeColor: "#14532D",
    icon: Users,
  },
  {
    id: "cctv",
    metric: "100%",
    label: "CCTV Monitored",
    sublabel: "24x7 camera surveillance",
    badge: "Campus Safety",
    badgeBg: "#FEF3C7",
    badgeColor: "#92400E",
    icon: ShieldCheck,
  },
  {
    id: "classes",
    metric: "Smart AV",
    label: "Digital Classrooms",
    sublabel: "Interactive audio-visual modules",
    badge: "Smart Tech",
    badgeBg: "#E8F3EA",
    badgeColor: "#14532D",
    icon: MonitorPlay,
  },
  {
    id: "grades",
    metric: "Pre-N to 5th",
    label: "Foundational Wing",
    sublabel: "CBSE aligned & Deeniyat",
    badge: "Holistic",
    badgeBg: "#F3F4F6",
    badgeColor: "#374151",
    icon: GraduationCap,
  },
];

export default function TrustStatsGrid() {
  return (
    <section
      className="py-10 bg-stone-50/70 border-b border-stone-200"
      aria-label="School Key Statistics"
    >
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-6">
          {STATS.map((item) => {
            const Icon = item.icon;
            return (
              <div
                key={item.id}
                className="p-5 sm:p-6 flex flex-col justify-between relative overflow-hidden bg-white rounded-xl border border-stone-200/90 shadow-xs hover:border-[#14532D]/40 transition-all hover:shadow-sm"
              >
                <div className="flex items-center justify-between mb-3">
                  <span
                    className="text-[11px] font-bold uppercase tracking-wider px-2 py-0.5 rounded-md"
                    style={{
                      backgroundColor: item.badgeBg,
                      color: item.badgeColor,
                    }}
                  >
                    {item.badge}
                  </span>
                  <div className="w-8 h-8 rounded-lg bg-[#E8F3EA] text-[#14532D] flex items-center justify-center">
                    <Icon className="w-4 h-4" />
                  </div>
                </div>

                <div>
                  <div className="font-heading font-bold text-2xl sm:text-3xl tracking-tight leading-none mb-1 text-[#14532D]">
                    {item.metric}
                  </div>
                  <div className="text-xs sm:text-sm font-bold text-stone-900 leading-snug">
                    {item.label}
                  </div>
                  <div className="text-[11px] text-stone-500 mt-0.5">
                    {item.sublabel}
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
