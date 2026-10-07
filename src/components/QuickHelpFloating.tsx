"use client";

import React, { useState } from "react";
import { Phone, MessageCircle, MapPin, X, HelpCircle } from "lucide-react";

export default function QuickHelpFloating() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div className="fixed bottom-20 md:bottom-6 right-4 sm:right-6 z-40 flex flex-col items-end">
      {/* Expanded Quick Options Menu */}
      {isOpen && (
        <div className="mb-3 w-64 bg-white rounded-2xl shadow-2xl border border-stone-200/90 p-4 space-y-3 animate-in fade-in slide-in-from-bottom-2 duration-200">
          <div className="flex items-center justify-between pb-2 border-b border-stone-100">
            <div>
              <p className="text-xs font-bold text-stone-900">Al-Qalam Desk</p>
              <p className="text-[10px] text-emerald-600 font-medium">● Admissions Active</p>
            </div>
            <button
              onClick={() => setIsOpen(false)}
              className="p-1 rounded-full text-stone-400 hover:text-stone-700 hover:bg-stone-100 transition-colors"
              aria-label="Close Quick Actions"
            >
              <X className="w-3.5 h-3.5" />
            </button>
          </div>

          <div className="space-y-2">
            {/* WhatsApp */}
            <a
              href="https://wa.me/919308462418?text=Hello%20Al-Qalam%20Public%20School,%20I%20would%20like%20to%20inquire%20about%20admissions."
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-3 p-2.5 rounded-xl bg-emerald-50 hover:bg-emerald-100/80 border border-emerald-200/70 text-[#14532D] text-xs font-semibold transition-all group"
            >
              <div className="w-7 h-7 rounded-lg bg-[#25D366] text-white flex items-center justify-center shrink-0 shadow-xs">
                <MessageCircle className="w-4 h-4" />
              </div>
              <div className="text-left">
                <p className="leading-tight font-bold text-stone-900">WhatsApp Desk</p>
                <p className="text-[10px] text-stone-500 font-normal">Instant message query</p>
              </div>
            </a>

            {/* Direct Phone Call */}
            <a
              href="tel:+919308462418"
              className="flex items-center gap-3 p-2.5 rounded-xl bg-stone-50 hover:bg-stone-100 border border-stone-200/80 text-stone-800 text-xs font-semibold transition-all group"
            >
              <div className="w-7 h-7 rounded-lg bg-[#14532D] text-white flex items-center justify-center shrink-0 shadow-xs">
                <Phone className="w-4 h-4" />
              </div>
              <div className="text-left">
                <p className="leading-tight font-bold text-stone-900">Call Campus Office</p>
                <p className="text-[10px] text-stone-500 font-normal">+91 93084 62418</p>
              </div>
            </a>

            {/* Google Maps Directions */}
            <a
              href="https://www.google.com/maps/search/?api=1&query=Opposite+Jashn+Palace+Marriage+Hall+Agarwal+Tola+Loharwa+Ghat+Ashok+Rajpath+Rd+Gulzarbagh+Alamganj+Patna+Bihar+800007"
              target="_blank"
              rel="noopener noreferrer"
              className="flex items-center gap-3 p-2.5 rounded-xl bg-stone-50 hover:bg-stone-100 border border-stone-200/80 text-stone-800 text-xs font-semibold transition-all group"
            >
              <div className="w-7 h-7 rounded-lg bg-[#D97706] text-white flex items-center justify-center shrink-0 shadow-xs">
                <MapPin className="w-4 h-4" />
              </div>
              <div className="text-left">
                <p className="leading-tight font-bold text-stone-900">Get Directions</p>
                <p className="text-[10px] text-stone-500 font-normal">Ashok Rajpath, Gulzarbagh</p>
              </div>
            </a>
          </div>
        </div>
      )}

      {/* Floating Action Trigger Button */}
      <button
        onClick={() => setIsOpen(!isOpen)}
        aria-label="Quick School Help"
        className="flex items-center gap-2 px-4 py-3 rounded-full bg-[#14532D] hover:bg-[#0E3D1E] text-white shadow-xl hover:shadow-2xl transition-all duration-300 active:scale-95 border-2 border-emerald-400/40 group cursor-pointer"
      >
        {isOpen ? (
          <X className="w-5 h-5 transition-transform duration-200" />
        ) : (
          <>
            <div className="relative">
              <HelpCircle className="w-5 h-5 text-amber-300" />
              <span className="absolute -top-1 -right-1 w-2 h-2 rounded-full bg-amber-400 animate-ping" />
            </div>
            <span className="text-xs font-bold tracking-wide">Quick Desk</span>
          </>
        )}
      </button>
    </div>
  );
}
