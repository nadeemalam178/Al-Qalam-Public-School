"use client";

import React, { useState } from "react";
import { Calendar, AlertCircle, ChevronRight, X, Bell } from "lucide-react";
import { NoticeItem } from "@/data/schoolData";

interface NoticeCardProps {
  notice: NoticeItem;
}

export default function NoticeCard({ notice }: NoticeCardProps) {
  const [showModal, setShowModal] = useState(false);

  const getCategoryColor = (category: NoticeItem["category"]) => {
    switch (category) {
      case "Admissions":
        return "bg-[#FAF8F2] text-[#6B4226] border-[#EDE2D3]";
      case "Academic":
        return "bg-[#E8F3EA] text-[#14532D] border-[#2F7D4A]/30";
      case "Safety":
        return "bg-[#E8F3EA] text-[#166534] border-[#2F7D4A]/30";
      default:
        return "bg-stone-100 text-stone-800 border-stone-300";
    }
  };

  return (
    <>
      <div className="card-interactive bg-white rounded-2xl border border-stone-200 p-5 sm:p-6 shadow-xs flex flex-col justify-between group">
        <div>
          <div className="flex items-center justify-between gap-3 mb-3">
            <span
              className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-bold border ${getCategoryColor(
                notice.category
              )}`}
            >
              {notice.category}
            </span>
            <div className="flex items-center gap-1 text-xs text-stone-400 font-medium">
              <Calendar className="w-3.5 h-3.5 text-[#6B4226]" />
              <span>{notice.date}</span>
            </div>
          </div>

          <h3 className="text-base sm:text-lg font-bold text-[#14532D] group-hover:text-[#166534] transition-colors leading-snug mb-2">
            {notice.title}
          </h3>

          <p className="text-xs sm:text-sm text-stone-600 leading-relaxed line-clamp-3">
            {notice.summary}
          </p>
        </div>

        <div className="mt-4 pt-3 border-t border-stone-100 flex items-center justify-between">
          <button
            onClick={() => setShowModal(true)}
            className="text-xs font-bold text-[#166534] hover:text-[#14532D] flex items-center gap-1 group-hover:underline cursor-pointer"
          >
            <span>Read Full Circular</span>
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
          className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-stone-900/60 backdrop-blur-xs"
          onClick={() => setShowModal(false)}
        >
          <div
            className="bg-white rounded-2xl max-w-lg w-full p-6 sm:p-8 shadow-xl border border-stone-200 relative animate-in fade-in zoom-in-95 duration-150"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="flex items-center justify-between border-b border-stone-100 pb-4 mb-4">
              <div className="flex items-center gap-2">
                <div className="w-8 h-8 rounded-lg bg-[#E8F3EA] flex items-center justify-center text-[#166534]">
                  <Bell className="w-4 h-4" />
                </div>
                <div>
                  <span className="text-xs font-bold uppercase text-[#6B4226]">School Circular</span>
                  <p className="text-xs text-stone-600">{notice.date}</p>
                </div>
              </div>
              <button
                onClick={() => setShowModal(false)}
                className="p-1.5 text-stone-400 hover:text-stone-700 rounded-lg hover:bg-stone-100 transition cursor-pointer"
                aria-label="Close dialog"
              >
                <X className="w-5 h-5 text-stone-600" />
              </button>
            </div>

            <div className="mb-4">
              <span
                className={`inline-block px-2.5 py-0.5 rounded-full text-xs font-bold border mb-2 ${getCategoryColor(
                  notice.category
                )}`}
              >
                {notice.category}
              </span>
              <h2 className="text-lg sm:text-xl font-bold text-[#14532D] leading-snug">
                {notice.title}
              </h2>
            </div>

            <div className="text-sm text-stone-700 leading-relaxed bg-[#FAF8F2] p-4 rounded-xl border border-[#EDE2D3] mb-6">
              {notice.details}
            </div>

            <div className="flex justify-end">
              <button
                onClick={() => setShowModal(false)}
                className="px-5 py-2 text-sm font-semibold rounded-lg bg-[#14532D] text-white hover:bg-[#166534] transition cursor-pointer"
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
