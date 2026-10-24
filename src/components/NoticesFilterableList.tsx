"use client";

import React, { useState, useEffect } from "react";
import { Search } from "lucide-react";
import NoticeCard from "@/components/NoticeCard";
import { SCHOOL_DATA, NoticeItem } from "@/data/schoolData";
import { fetchLiveNotices } from "@/lib/supabase";

const categories = ["All", "Admissions", "Academic", "Safety", "General"] as const;

export default function NoticesFilterableList() {
  const [selectedCategory, setSelectedCategory] = useState<string>("All");
  const [searchQuery, setSearchQuery] = useState("");
  const [notices, setNotices] = useState<NoticeItem[]>(SCHOOL_DATA.notices);
  const [isLiveConnected, setIsLiveConnected] = useState(false);

  useEffect(() => {
    let isMounted = true;
    fetchLiveNotices()
      .then((liveList) => {
        if (isMounted && liveList && liveList.length > 0) {
          // Merge Supabase notices with fallback notices (avoiding duplicate IDs)
          const liveIds = new Set(liveList.map((n) => n.id));
          const uniqueFallbacks = SCHOOL_DATA.notices.filter((n) => !liveIds.has(n.id));
          setNotices([...liveList, ...uniqueFallbacks]);
          setIsLiveConnected(true);
        }
      })
      .catch((err) => {
        console.warn("[NoticesFilterableList Live Sync]", err);
      });

    return () => {
      isMounted = false;
    };
  }, []);

  const filteredNotices = notices.filter((n) => {
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
      <div className="flex flex-col md:flex-row items-center justify-between gap-4 mb-10 pb-6 border-b border-stone-200">
        {/* Category Filter Tabs */}
        <div className="flex flex-wrap items-center gap-2 w-full md:w-auto" role="tablist" aria-label="Notice categories">
          {isLiveConnected && (
            <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-emerald-50 border border-emerald-200 text-emerald-700 text-[11px] font-semibold mr-1">
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse" />
              Live Sync
            </span>
          )}
          <span className="text-xs font-bold uppercase text-stone-600 mr-1 hidden sm:inline">
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
                    : "bg-white text-stone-700 hover:bg-[#E8F3EA] hover:text-[#14532D] border border-stone-200 shadow-2xs"
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
            id="notice-search"
            name="notice-search"
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Search school circulars..."
            aria-label="Search school circulars"
            className="w-full pl-9 pr-4 py-2 rounded-lg text-xs sm:text-sm bg-white border border-stone-300 focus:bg-white focus:outline-none focus:ring-2 focus:ring-[#14532D] text-stone-900 shadow-2xs"
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
        <div className="text-center py-12 bg-stone-50/70 rounded-xl border border-stone-200 text-stone-500 text-sm">
          No active circulars at this time. Official notices broadcasted from the school app will appear here.
        </div>
      )}
    </div>
  );
}
