"use client";

import React, { useState } from "react";
import {
  Smartphone,
  Download,
  ShieldCheck,
  CheckCircle2,
  HelpCircle,
  QrCode,
  Sparkles,
  ExternalLink,
} from "lucide-react";
import MobileAppModal from "./MobileAppModal";

export default function ApkDownloadSection() {
  const [isModalOpen, setIsModalOpen] = useState(false);

  return (
    <>
      <section
        id="download-app"
        className="relative py-16 sm:py-24 bg-gradient-to-br from-[#0B3B20] via-[#14532D] to-[#0A2E19] text-white overflow-hidden"
      >
        {/* Subtle decorative circles */}
        <div className="absolute top-0 right-0 -mt-12 -mr-12 w-96 h-96 rounded-full bg-emerald-500/10 blur-3xl pointer-events-none" />
        <div className="absolute bottom-0 left-0 -mb-12 -ml-12 w-80 h-80 rounded-full bg-amber-400/10 blur-3xl pointer-events-none" />

        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
          <div className="bg-white/10 backdrop-blur-md rounded-3xl p-6 sm:p-10 lg:p-12 border border-white/20 shadow-2xl">
            <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 lg:gap-12 items-center">
              {/* Left Column: App Information & Features */}
              <div className="lg:col-span-7 space-y-6">
                <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-amber-400/20 border border-amber-300/40 text-amber-300 text-xs font-bold uppercase tracking-wider">
                  <Sparkles className="w-3.5 h-3.5" />
                  <span>Official Campus Mobile Application</span>
                </div>

                <div className="space-y-3">
                  <h2 className="font-heading font-black text-2xl sm:text-3xl lg:text-4xl text-white tracking-tight leading-tight">
                    Experience Al-Qalam on Your Android Device
                  </h2>
                  <p className="text-sm sm:text-base text-stone-200 leading-relaxed max-w-xl">
                    Dedicated mobile management suite for Parents, Teachers &amp; Campus Administration. Stay updated with daily attendance rollcalls, digital fee receipts, homework diary, and real-time school circulars.
                  </p>
                </div>

                {/* Role Feature Pills */}
                <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
                  <div className="p-3.5 rounded-2xl bg-white/5 border border-white/10 space-y-1">
                    <span className="text-amber-300 text-xs font-bold flex items-center gap-1.5">
                      <CheckCircle2 className="w-4 h-4 text-amber-400" />
                      <span>Parents Portal</span>
                    </span>
                    <p className="text-[11px] text-stone-300">
                      Live attendance, digital fee receipts &amp; daily homework.
                    </p>
                  </div>

                  <div className="p-3.5 rounded-2xl bg-white/5 border border-white/10 space-y-1">
                    <span className="text-emerald-300 text-xs font-bold flex items-center gap-1.5">
                      <CheckCircle2 className="w-4 h-4 text-emerald-400" />
                      <span>Faculty Desk</span>
                    </span>
                    <p className="text-[11px] text-stone-300">
                      1-Tap rollcall, homework assignments &amp; marks entry.
                    </p>
                  </div>

                  <div className="p-3.5 rounded-2xl bg-white/5 border border-white/10 space-y-1">
                    <span className="text-blue-300 text-xs font-bold flex items-center gap-1.5">
                      <CheckCircle2 className="w-4 h-4 text-blue-400" />
                      <span>Administration</span>
                    </span>
                    <p className="text-[11px] text-stone-300">
                      Website CMS, fee collections &amp; broadcast circulars.
                    </p>
                  </div>
                </div>

                {/* Action Buttons */}
                <div className="pt-2 flex flex-wrap items-center gap-4">
                  <a
                    href="https://github.com/nadeemalam178/Al-Qalam-Public-School/releases/latest/download/Al-Qalam-Public-School-Release.apk"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="px-6 py-3.5 rounded-xl font-bold text-sm bg-amber-400 hover:bg-amber-300 text-stone-900 shadow-lg hover:shadow-xl transition-all flex items-center gap-2.5 active:scale-95"
                  >
                    <Download className="w-4 h-4" />
                    <span>Download Release APK (v1.3.0)</span>
                  </a>

                  <button
                    type="button"
                    onClick={() => setIsModalOpen(true)}
                    className="px-5 py-3.5 rounded-xl font-semibold text-sm bg-white/15 hover:bg-white/25 text-white border border-white/25 transition-all flex items-center gap-2 cursor-pointer"
                  >
                    <Smartphone className="w-4 h-4" />
                    <span>View Role Guide</span>
                  </button>
                </div>

                <div className="flex items-center gap-4 text-[11px] text-stone-300 pt-1">
                  <span className="flex items-center gap-1">
                    <ShieldCheck className="w-3.5 h-3.5 text-emerald-300" />
                    <span>Android 8.0+ Required</span>
                  </span>
                  <span>•</span>
                  <span>Package Size: ~26 MB</span>
                  <span>•</span>
                  <span>Clean &amp; Verified Build</span>
                </div>
              </div>

              {/* Right Column: Visual Device Mockup & 3-Step Installation Guide */}
              <div className="lg:col-span-5 bg-black/30 rounded-2xl p-6 border border-white/15 space-y-5">
                <div className="flex items-center justify-between border-b border-white/10 pb-3">
                  <h3 className="font-heading font-bold text-base text-white flex items-center gap-2">
                    <Smartphone className="w-4 h-4 text-amber-400" />
                    <span>Quick Installation Steps</span>
                  </h3>
                  <span className="text-[10px] uppercase font-bold tracking-wider px-2 py-0.5 rounded bg-emerald-500/20 text-emerald-300 border border-emerald-500/30">
                    Direct APK
                  </span>
                </div>

                <ol className="space-y-3.5 text-xs text-stone-200">
                  <li className="flex items-start gap-3">
                    <span className="w-5 h-5 rounded-full bg-amber-400 text-stone-900 font-bold flex items-center justify-center shrink-0 text-[11px]">
                      1
                    </span>
                    <div>
                      <p className="font-semibold text-white">Download the APK file</p>
                      <p className="text-[11px] text-stone-300">
                        Tap the download button above on your Android phone browser.
                      </p>
                    </div>
                  </li>

                  <li className="flex items-start gap-3">
                    <span className="w-5 h-5 rounded-full bg-amber-400 text-stone-900 font-bold flex items-center justify-center shrink-0 text-[11px]">
                      2
                    </span>
                    <div>
                      <p className="font-semibold text-white">Enable Install Unknown Apps</p>
                      <p className="text-[11px] text-stone-300">
                        When prompted by Android, allow installation from your browser.
                      </p>
                    </div>
                  </li>

                  <li className="flex items-start gap-3">
                    <span className="w-5 h-5 rounded-full bg-amber-400 text-stone-900 font-bold flex items-center justify-center shrink-0 text-[11px]">
                      3
                    </span>
                    <div>
                      <p className="font-semibold text-white">Open &amp; Sign In</p>
                      <p className="text-[11px] text-stone-300">
                        Launch the app and enter your school credentials to access your portal.
                      </p>
                    </div>
                  </li>
                </ol>

                <div className="pt-2 border-t border-white/10 flex items-center justify-between text-[11px] text-stone-300">
                  <span>Need assistance installing?</span>
                  <a
                    href="https://wa.me/919308462418?text=Hello%20Al-Qalam%20School%20Desk,%20I%20need%20help%20installing%20the%20school%20mobile%20app."
                    target="_blank"
                    rel="noopener noreferrer"
                    className="font-bold text-amber-300 hover:text-amber-200 underline inline-flex items-center gap-1"
                  >
                    <span>Contact WhatsApp Desk</span>
                    <ExternalLink className="w-3 h-3" />
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Role Guide Modal */}
      <MobileAppModal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
      />
    </>
  );
}
