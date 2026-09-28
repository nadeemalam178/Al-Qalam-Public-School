import React from "react";
import type { Metadata } from "next";
import Link from "next/link";
import { Bell, Info } from "lucide-react";
import NoticesFilterableList from "@/components/NoticesFilterableList";

export const metadata: Metadata = {
  title: "School Notices & Circulars",
  description:
    "Official school notice board for Al-Qalam Public School, Gulzarbagh, Patna. Announcements on admissions, academic modules, holidays, and campus guidelines.",
};

export default function NoticesPage() {
  return (
    <div className="bg-white">
      {/* Banner */}
      <section className="bg-forest-hero text-white py-14 sm:py-18 lg:py-20 border-b border-[#0B3B20]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-3">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#072413] border border-[#2F7D4A]/40 text-[#EDE2D3] text-xs font-semibold uppercase tracking-wider">
            <Bell className="w-3.5 h-3.5" />
            <span>Official Communications</span>
          </div>
          <h1 className="font-heading font-black text-3xl sm:text-4xl lg:text-5xl text-white tracking-tight">
            School Notices
          </h1>
          <p className="text-base sm:text-lg text-stone-200 max-w-2xl mx-auto leading-relaxed">
            Stay updated with official school announcements, academic schedules, and admission circulars.
          </p>
        </div>
      </section>

      {/* Main Notice Board Section */}
      <section className="py-16 sm:py-20 bg-white border-b border-[#E7E5E4]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <NoticesFilterableList />

          {/* School Notice Protocol Card */}
          <div className="max-w-3xl mx-auto mt-14 bg-[#FAF8F2] border border-[#EDE2D3] rounded-xl p-5 flex items-start gap-3.5 text-xs text-stone-700">
            <Info className="w-5 h-5 text-[#14532D] shrink-0 mt-0.5" />
            <div className="leading-relaxed">
              <span className="font-bold text-[#14532D]">Notice Board Verification:</span> Official paper circulars are also posted on the physical bulletin board at the school entrance gate on Ashok Rajpath Rd, Gulzarbagh. For queries regarding any circular, parents are requested to contact the campus office.
            </div>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2]">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-5">
          <h2 className="font-heading font-black text-2xl sm:text-3xl text-[#14532D] tracking-tight">
            Have Questions Regarding Any Notice?
          </h2>
          <p className="text-stone-600 text-sm sm:text-base leading-relaxed max-w-2xl mx-auto">
            Our school administration is available during office hours at our Gulzarbagh campus to assist with circulars, syllabus queries, and fee schedules.
          </p>
          <div className="pt-2">
            <Link
              href="/contact"
              className="btn-primary px-6 py-3 rounded-lg text-sm font-semibold text-white bg-[#14532D] hover:bg-[#0B3B20] shadow-xs transition-colors"
            >
              <span>Contact Campus Desk</span>
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}
