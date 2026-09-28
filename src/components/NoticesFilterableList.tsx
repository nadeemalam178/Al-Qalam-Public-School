"use client";

import React, { useState } from "react";
import { Search } from "lucide-react";
import NoticeCard from "@/components/NoticeCard";
import { SCHOOL_DATA } from "@/data/schoolData";

const categories = ["All", "Admissions", "Academic", "Safety", "General"] as const;

export default function NoticesFilterableList() {
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
    <div>
      {/* Controls Bar: Search & Category Filter */}
      <div className="flex flex-col md:flex-row items-center justify-between gap-4 mb-10 pb-6 border-b border-[#E7E5E4]">
        {/* Category Filter Tabs */}
        <div className="flex flex-wrap items-center gap-2 w-full md:w-auto" role="tablist" aria-label="Notice categories">
          <span className="text-xs font-bold uppercase text-[#6B4226] mr-1 hidden sm:inline">
            Category:
          </span>
          {categories.map((cat) => {
            const isActive = selectedCategory === cat;
            return (
              <button
                key={cat}
                role="tab"
                aria-selected={isActive}
                onClick={() => setSelectedCategory(cat)}
                className={`px-3.5 py-1.5 rounded-lg text-xs font-semibold transition-colors cursor-pointer ${
                  isActive
                    ? "bg-[#14532D] text-white shadow-xs"
                    : "bg-[#FAF8F2] text-stone-700 hover:bg-[#E8F3EA] border border-[#EDE2D3]"
                }`}
              >
                {cat}
              </button>
            );
          })}
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
            placeholder="Search school circulars..."
            aria-label="Search school circulars"
            className="w-full pl-9 pr-4 py-2 rounded-lg text-xs sm:text-sm bg-[#FAF8F2] border border-stone-300 focus:bg-white focus:outline-none focus:ring-2 focus:ring-[#14532D] text-stone-900"
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
        <div className="text-center py-12 bg-[#FAF8F2] rounded-xl border border-[#EDE2D3] text-stone-500 text-sm">
          No circulars found matching &quot;{searchQuery}&quot;. Please adjust your search criteria or category filter.
        </div>
      )}
    </div>
  );
}
