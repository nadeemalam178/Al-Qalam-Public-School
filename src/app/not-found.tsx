import React from "react";
import Link from "next/link";
import { ArrowLeft, Home, Compass } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function NotFound() {
  return (
    <div className="min-h-[60vh] flex items-center justify-center py-20 px-4 sm:px-6 bg-stone-50/70">
      <div className="max-w-md w-full bg-white rounded-xl border border-stone-200/90 p-8 text-center shadow-xs space-y-5">
        <div className="w-14 h-14 rounded-full bg-[#E8F3EA] text-[#14532D] flex items-center justify-center mx-auto border border-[#2F7D4A]/25">
          <Compass className="w-7 h-7" />
        </div>

        <div>
          <span className="text-xs font-mono font-bold text-[#14532D] uppercase tracking-wider">
            Error 404
          </span>
          <h1 className="font-heading font-bold text-2xl text-stone-900 mt-1">
            Page Not Found
          </h1>
          <p className="text-stone-600 text-xs sm:text-sm mt-2 leading-relaxed">
            The page you are looking for may have been moved, updated, or is no longer available.
          </p>
        </div>

        <div className="pt-2 flex flex-col sm:flex-row items-center justify-center gap-3">
          <Link
            href="/"
            className="btn-primary w-full sm:w-auto px-5 py-2.5 rounded-lg text-xs font-semibold text-white bg-[#14532D] hover:bg-[#0B3B20] transition-colors flex items-center justify-center gap-1.5 shadow-xs"
          >
            <Home className="w-3.5 h-3.5" />
            <span>Return to Home</span>
          </Link>
          <Link
            href="/contact"
            className="btn-primary w-full sm:w-auto px-5 py-2.5 rounded-lg text-xs font-semibold text-stone-700 bg-white hover:bg-stone-50 border border-stone-200 transition-colors flex items-center justify-center gap-1.5 shadow-2xs"
          >
            <ArrowLeft className="w-3.5 h-3.5" />
            <span>Campus Desk</span>
          </Link>
        </div>

        <p className="text-[11px] text-stone-400 pt-3 border-t border-stone-100">
          {SCHOOL_DATA.name} • Gulzarbagh, Patna
        </p>
      </div>
    </div>
  );
}
