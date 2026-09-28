"use client";

import React, { useState } from "react";
import { MapPin, Navigation, Send, CheckCircle2, AlertCircle, RefreshCw } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";

const INDIAN_MOBILE_REGEX = /^[6-9]\d{9}$/;

export default function ContactSection() {
  const [form, setForm] = useState({ name: "", mobile: "", message: "" });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitted, setSubmitted] = useState(false);
  const [referenceId, setReferenceId] = useState("");
  const [error, setError] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!form.name.trim()) {
      setError("Please enter your name.");
      return;
    }
    const cleanMobile = form.mobile.replace(/\D/g, "");
    if (!cleanMobile || !INDIAN_MOBILE_REGEX.test(cleanMobile)) {
      setError("Please enter a valid 10-digit Indian mobile number.");
      return;
    }
    if (!form.message.trim() || form.message.trim().length < 5) {
      setError("Please enter your query or message.");
      return;
    }

    setError("");
    setIsSubmitting(true);

    try {
      const response = await fetch("/api/contact", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: form.name.trim(),
          mobile: cleanMobile,
          message: form.message.trim(),
        }),
      });

      const data = await response.json();
      if (!response.ok || !data.success) {
        setError(data.message || "Failed to submit message. Please try again or visit campus.");
        setIsSubmitting(false);
        return;
      }

      setReferenceId(data.referenceId);
      setSubmitted(true);
      setIsSubmitting(false);
    } catch {
      setError("Network error occurred. Please check connection or visit campus desk.");
      setIsSubmitting(false);
    }
  };

  return (
    <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
      {/* Left Column: Verified Campus Address & Visiting Guidelines */}
      <div className="lg:col-span-6 bg-white rounded-2xl border border-stone-200 p-6 sm:p-8 shadow-xs space-y-6">
        <div>
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/25 text-xs font-semibold uppercase tracking-wider mb-2">
            <span>Campus Location</span>
          </div>
          <h3 className="font-heading font-black text-2xl text-[#14532D] tracking-tight">
            {SCHOOL_DATA.name}
          </h3>
          <p className="text-xs font-semibold text-[#6B4226] mt-0.5">
            Gulzarbagh, Alamganj, Patna, Bihar 800007
          </p>
        </div>

        {/* Address Card */}
        <div className="bg-[#FAF8F2] border border-[#EDE2D3] rounded-xl p-5 space-y-4">
          <div className="flex items-start gap-3.5">
            <div className="w-10 h-10 rounded-lg bg-[#E8F3EA] text-[#14532D] flex items-center justify-center shrink-0 border border-[#2F7D4A]/20">
              <MapPin className="w-5 h-5" />
            </div>
            <div className="text-sm leading-relaxed text-stone-700">
              <p className="font-bold text-[#14532D]">{SCHOOL_DATA.address.line1}</p>
              <p>{SCHOOL_DATA.address.line2}</p>
              <p>{SCHOOL_DATA.address.street}</p>
              <p>
                {SCHOOL_DATA.address.locality}, {SCHOOL_DATA.address.city}, {SCHOOL_DATA.address.state} – {SCHOOL_DATA.address.pincode}
              </p>
            </div>
          </div>

          <div className="pt-3 border-t border-[#EDE2D3] flex flex-wrap items-center justify-between gap-3">
            <a
              href={SCHOOL_DATA.address.googleMapsUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="btn-primary inline-flex items-center gap-2 px-4 py-2 rounded-lg text-xs font-semibold text-white bg-[#14532D] hover:bg-[#0B3B20] shadow-xs cursor-pointer"
            >
              <Navigation className="w-3.5 h-3.5 text-[#EDE2D3]" />
              <span>Get Directions</span>
            </a>
            <span className="text-xs text-stone-500 font-medium">
              Landmark: {SCHOOL_DATA.address.landmark}
            </span>
          </div>
        </div>

        {/* In-Person Campus Desk Instructions */}
        <div className="p-4 rounded-xl bg-[#FAF8F2] border border-[#EDE2D3] text-xs text-stone-600 leading-relaxed space-y-2">
          <p className="font-semibold text-[#14532D] text-sm">
            Campus Visit & Office Desk
          </p>
          <p>
            {SCHOOL_DATA.contact.campusDeskNote}
          </p>
          <p className="text-[11px] text-stone-500 pt-1">
            *Visitors are requested to check in at the campus security gate on Ashok Rajpath Rd.
          </p>
        </div>
      </div>

      {/* Right Column: Quick Query to School Desk */}
      <div className="lg:col-span-6 bg-white rounded-2xl border border-stone-200 p-6 sm:p-8 shadow-xs">
        <h3 className="font-heading font-black text-xl sm:text-2xl text-[#14532D] tracking-tight mb-2">
          Send a Message to Campus Desk
        </h3>
        <p className="text-xs sm:text-sm text-stone-500 mb-6">
          Have a query regarding admissions, syllabus, or visiting the school campus? Leave your details below.
        </p>

        {submitted ? (
          <div className="p-6 rounded-xl bg-[#E8F3EA] border border-[#2F7D4A]/30 text-center space-y-3">
            <CheckCircle2 className="w-10 h-10 text-[#14532D] mx-auto" />
            <h4 className="font-heading font-bold text-[#14532D] text-lg">Message Registered</h4>
            <p className="text-xs sm:text-sm text-stone-600 max-w-sm mx-auto leading-relaxed">
              Thank you, {form.name}. Your query (Reference: <span className="font-mono font-bold text-[#14532D]">{referenceId}</span>) has been recorded at the school administrative desk.
            </p>
            <button
              onClick={() => {
                setSubmitted(false);
                setForm({ name: "", mobile: "", message: "" });
              }}
              className="mt-3 px-4 py-2 rounded-lg text-xs font-semibold text-stone-700 bg-white border border-stone-300 hover:bg-stone-50 cursor-pointer"
            >
              Send Another Query
            </button>
          </div>
        ) : (
          <form onSubmit={handleSubmit} className="space-y-4" noValidate>
            {error && (
              <div className="p-3 rounded-lg bg-red-50 border border-red-200 text-xs text-red-700 flex items-center gap-2">
                <AlertCircle className="w-4 h-4 shrink-0" />
                <span>{error}</span>
              </div>
            )}

            <div>
              <label htmlFor="contact-name" className="block text-xs font-semibold uppercase tracking-wider text-stone-700 mb-1">
                Your Full Name *
              </label>
              <input
                id="contact-name"
                type="text"
                required
                disabled={isSubmitting}
                value={form.name}
                onChange={(e) => setForm({ ...form, name: e.target.value })}
                placeholder="Full Name"
                className="w-full px-3.5 py-2.5 rounded-lg text-sm bg-[#FAF8F2] border border-stone-300 focus:bg-white focus:outline-none focus:ring-2 focus:ring-[#14532D] text-stone-900"
              />
            </div>

            <div>
              <label htmlFor="contact-mobile" className="block text-xs font-semibold uppercase tracking-wider text-stone-700 mb-1">
                Mobile Number *
              </label>
              <input
                id="contact-mobile"
                type="tel"
                required
                maxLength={10}
                disabled={isSubmitting}
                value={form.mobile}
                onChange={(e) => setForm({ ...form, mobile: e.target.value.replace(/\D/g, "") })}
                placeholder="10-digit mobile number"
                className="w-full px-3.5 py-2.5 rounded-lg text-sm bg-[#FAF8F2] border border-stone-300 focus:bg-white focus:outline-none focus:ring-2 focus:ring-[#14532D] text-stone-900"
              />
            </div>

            <div>
              <label htmlFor="contact-message" className="block text-xs font-semibold uppercase tracking-wider text-stone-700 mb-1">
                Your Message / Query *
              </label>
              <textarea
                id="contact-message"
                rows={3}
                required
                disabled={isSubmitting}
                value={form.message}
                onChange={(e) => setForm({ ...form, message: e.target.value })}
                placeholder="How may our school administration assist you?"
                className="w-full px-3.5 py-2.5 rounded-lg text-sm bg-[#FAF8F2] border border-stone-300 focus:bg-white focus:outline-none focus:ring-2 focus:ring-[#14532D] text-stone-900 resize-none"
              />
            </div>

            <button
              type="submit"
              disabled={isSubmitting}
              className="btn-primary w-full py-2.5 px-5 rounded-lg text-sm font-semibold text-white bg-[#14532D] hover:bg-[#0B3B20] shadow-xs flex items-center justify-center gap-2 cursor-pointer disabled:opacity-60"
            >
              {isSubmitting ? (
                <>
                  <RefreshCw className="w-4 h-4 animate-spin text-[#EDE2D3]" />
                  <span>Sending Message...</span>
                </>
              ) : (
                <>
                  <Send className="w-4 h-4 text-[#EDE2D3]" />
                  <span>Send Message to Desk</span>
                </>
              )}
            </button>
          </form>
        )}
      </div>
    </div>
  );
}
