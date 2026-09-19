"use client";

import React, { useState } from "react";
import { Bell, Search, Info } from "lucide-react";
import NoticeCard from "@/components/NoticeCard";
import CTA from "@/components/CTA";
import { SCHOOL_DATA } from "@/data/schoolData";

const categories = ["All", "Admissions", "Academic", "Safety", "General"] as const;

export default function NoticesPage() {
  const [selectedCategory, setSelectedCategory] = useState<string>("All");
  const [searchQuery, setSearchQuery] = useState("");

  const filteredNotices = SCHOOL_DATA.notices.filter((n) => {
    const matchesCategory =
      selectedCategory === "All" || n.category === selectedCategory;
    const matchesSearch =
      n.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      n.summary.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesCategory && matchesSearch;
  });

  return (
    <div className="bg-white">
      {/* Banner */}
      <section className="bg-forest-hero text-white py-16 sm:py-20 border-b border-[#0d3b1f]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#0d3b1f]/60 border border-[#2F7D4A]/40 text-[#EDE2D3] text-xs font-bold uppercase tracking-wider mb-4">
            <Bell className="w-4 h-4 text-[#E8F3EA]" />
            <span>Official Communications</span>
          </div>
          <h1 className="text-3xl sm:text-4xl lg:text-5xl font-black tracking-tight text-white">
            School Notice Board & Circulars
          </h1>
          <p className="mt-3 text-base sm:text-lg text-[#EDE2D3] max-w-2xl mx-auto">
            Stay updated with official school announcements, academic schedules, and admission circulars.
          </p>
        </div>
      </section>

      {/* Main Notice Board Section */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          {/* Controls Bar: Search & Category Filter */}
          <div className="flex flex-col md:flex-row items-center justify-between gap-4 mb-10 pb-6 border-b border-stone-200">
            {/* Category Filter Pills */}
            <div className="flex flex-wrap items-center gap-2 w-full md:w-auto">
              <span className="text-xs font-bold uppercase text-[#6B4226] mr-1 hidden sm:inline">
                Category:
              </span>
              {categories.map((cat) => (
                <button
                  key={cat}
                  onClick={() => setSelectedCategory(cat)}
                  className={`px-3.5 py-1.5 rounded-xl text-xs font-bold transition cursor-pointer ${
                    selectedCategory === cat
                      ? "bg-[#14532D] text-white shadow-xs border border-[#166534]"
                      : "bg-[#FAF8F2] text-stone-600 hover:bg-[#E8F3EA] border border-[#EDE2D3]"
                  }`}
                >
                  {cat}
                </button>
              ))}
            </div>

            {/* Search Input */}
            <div className="relative w-full md:w-72">
              <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-stone-400">
                <Search className="w-4 h-4" />
              </div>
              <input
                type="text"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                placeholder="Search circulars..."
                className="w-full pl-9 pr-4 py-2 rounded-xl text-xs sm:text-sm bg-[#FAF8F2] border border-stone-300 focus:bg-white focus:outline-none focus:ring-2 focus:ring-[#166534] text-stone-900"
              />
            </div>
          </div>

          {/* Notices Grid */}
          {filteredNotices.length > 0 ? (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {filteredNotices.map((notice) => (
                <NoticeCard key={notice.id} notice={notice} />
              ))}
            </div>
          ) : (
            <div className="text-center py-12 bg-[#FAF8F2] rounded-2xl border border-[#EDE2D3] text-stone-500 text-sm">
              No circulars found matching &quot;{searchQuery}&quot;.
            </div>
          )}

          {/* Transparency Disclaimer */}
          <div className="max-w-3xl mx-auto mt-14 bg-[#FAF8F2] border border-[#EDE2D3] rounded-2xl p-5 flex items-start gap-3 text-xs text-stone-700">
            <Info className="w-5 h-5 text-[#6B4226] shrink-0 mt-0.5" />
            <div className="leading-relaxed">
              <span className="font-bold text-[#14532D]">Notice Board Protocol:</span> Official circulars and holiday notifications are also physically displayed on the school administrative board at our Gulzarbagh campus. For real-time confirmation on any urgent circular, parents may contact the school desk.
            </div>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <CTA
          title="Have Questions Regarding Announcements?"
          subtitle="Feel free to contact the school administration or visit our office at Ashok Rajpath Rd, Gulzarbagh."
          primaryBtnText="Contact Administration"
          primaryBtnHref="/contact"
        />
      </section>
    </div>
  );
}
