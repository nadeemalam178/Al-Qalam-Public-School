"use client";

import React, { useState, useEffect } from "react";
import { Calendar, AlertCircle, ChevronRight, X, Bell } from "lucide-react";
import { NoticeItem } from "@/data/schoolData";

interface NoticeCardProps {
  notice: NoticeItem;
}

export default function NoticeCard({ notice }: NoticeCardProps) {
  const [showModal, setShowModal] = useState(false);

  useEffect(() => {
    if (!showModal) return;
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === "Escape") setShowModal(false);
    };
    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [showModal]);

  const getCategoryBadge = (category: NoticeItem["category"]) => {
    switch (category) {
      case "Admissions":
        return "bg-[#FAF8F2] text-[#6B4226] border-[#EDE2D3]";
      case "Academic":
        return "bg-[#E8F3EA] text-[#14532D] border-[#2F7D4A]/30";
      case "Safety":
        return "bg-[#E8F3EA] text-[#166534] border-[#2F7D4A]/30";
      default:
        return "bg-stone-100 text-stone-800 border-stone-200";
    }
  };

  return (
    <>
      <div className="bg-white rounded-xl border border-[#E7E5E4] p-5 sm:p-6 card-subtle flex flex-col justify-between group">
        <div>
          <div className="flex items-center justify-between gap-3 mb-3">
            <span
              className={`inline-flex items-center px-2.5 py-0.5 rounded text-xs font-semibold border ${getCategoryBadge(
                notice.category
              )}`}
            >
              {notice.category}
            </span>
            <div className="flex items-center gap-1.5 text-xs text-stone-500 font-medium">
              <Calendar className="w-3.5 h-3.5 text-[#6B4226]" />
              <span>{notice.date}</span>
            </div>
          </div>

          <h3 className="font-heading font-bold text-base sm:text-lg text-[#14532D] group-hover:text-[#0B3B20] transition-colors leading-snug mb-2">
            {notice.title}
          </h3>

          <p className="text-xs sm:text-sm text-stone-600 leading-relaxed line-clamp-3">
            {notice.summary}
          </p>
        </div>

        <div className="mt-5 pt-3.5 border-t border-stone-100 flex items-center justify-between text-xs">
          <button
            onClick={() => setShowModal(true)}
            className="font-semibold text-[#14532D] hover:text-[#0B3B20] flex items-center gap-1 group-hover:underline cursor-pointer"
          >
            <span>Read Notice</span>
            <ChevronRight className="w-3.5 h-3.5 text-[#6B4226]" />
          </button>

          {notice.isImportant && (
            <span className="flex items-center gap-1 text-[11px] font-semibold text-[#6B4226] bg-[#FAF8F2] px-2 py-0.5 rounded border border-[#EDE2D3]">
              <AlertCircle className="w-3 h-3 text-[#6B4226]" />
              <span>Important</span>
            </span>
          )}
        </div>
      </div>

      {/* Notice Detail Modal */}
      {showModal && (
        <div
          role="dialog"
          aria-modal="true"
          aria-label={notice.title}
          className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-stone-950/70 backdrop-blur-xs"
          onClick={() => setShowModal(false)}
        >
          <div
            className="bg-white rounded-2xl max-w-lg w-full p-6 sm:p-8 shadow-2xl border border-stone-200 relative"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center justify-between border-b border-stone-100 pb-4 mb-4">
              <div className="flex items-center gap-2.5">
                <div className="w-8 h-8 rounded-lg bg-[#E8F3EA] flex items-center justify-center text-[#14532D]">
                  <Bell className="w-4 h-4" />
                </div>
                <div>
                  <span className="text-xs font-bold uppercase tracking-wider text-[#6B4226]">
                    School Circular
                  </span>
                  <p className="text-xs text-stone-500">{notice.date}</p>
                </div>
              </div>
              <button
                onClick={() => setShowModal(false)}
                className="p-1.5 text-stone-400 hover:text-stone-700 rounded-lg hover:bg-stone-100 transition-colors cursor-pointer"
                aria-label="Close notice dialog"
              >
                <X className="w-5 h-5 text-stone-600" />
              </button>
            </div>

            <div className="mb-4">
              <span
                className={`inline-block px-2.5 py-0.5 rounded text-xs font-semibold border mb-2 ${getCategoryBadge(
                  notice.category
                )}`}
              >
                {notice.category}
              </span>
              <h4 className="font-heading font-bold text-lg sm:text-xl text-[#14532D] leading-snug">
                {notice.title}
              </h4>
            </div>

            <div className="text-sm text-stone-700 leading-relaxed bg-[#FAF8F2] p-4 sm:p-5 rounded-xl border border-[#EDE2D3] mb-6">
              {notice.details}
            </div>

            <div className="flex items-center justify-between pt-2 border-t border-stone-100 text-xs">
              <span className="text-stone-500">Al-Qalam Public School • Notice Desk</span>
              <button
                onClick={() => setShowModal(false)}
                className="btn-primary px-4 py-2 text-xs font-semibold rounded-lg bg-[#14532D] text-white hover:bg-[#0B3B20] transition-colors cursor-pointer"
              >
                Close
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
