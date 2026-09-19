"use client";

import React, { useState } from "react";
import { MapPin, Navigation, Phone, Mail, Clock, Send, CheckCircle2, AlertCircle } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function ContactSection() {
  const [form, setForm] = useState({ name: "", phone: "", message: "" });
  const [submitted, setSubmitted] = useState(false);
  const [error, setError] = useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!form.name.trim() || !form.phone.trim() || !form.message.trim()) {
      setError("Please complete all fields before sending.");
      return;
    }
    if (form.phone.replace(/\D/g, "").length !== 10) {
      setError("Please provide a valid 10-digit phone number.");
      return;
    }
    setError("");
    setSubmitted(true);
  };

  return (
    <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
      {/* Confirmed Address & Details */}
      <div className="card-interactive lg:col-span-6 bg-white rounded-3xl border border-stone-200 p-6 sm:p-10 shadow-xs space-y-6">
        <div>
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/25 text-xs font-bold uppercase tracking-wider mb-3">
            <span className="w-1.5 h-1.5 rounded-full bg-[#6B4226]" />
            <span>Campus Location</span>
          </div>
          <h3 className="text-2xl font-black text-[#14532D] tracking-tight">
            {SCHOOL_DATA.name}
          </h3>
          <p className="text-xs font-semibold text-[#6B4226] mt-0.5">
            Gulzarbagh, Alamganj, Patna, Bihar
          </p>
        </div>

        {/* Address Card */}
        <div className="bg-[#FAF8F2] border border-[#EDE2D3] rounded-2xl p-5 space-y-3">
          <div className="flex items-start gap-3.5">
            <div className="w-10 h-10 rounded-xl bg-[#E8F3EA] text-[#166534] flex items-center justify-center shrink-0 mt-0.5 border border-[#2F7D4A]/20">
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

          <div className="pt-2 border-t border-[#EDE2D3] flex flex-wrap items-center gap-3">
            <a
              href={SCHOOL_DATA.address.googleMapsUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="btn-interactive inline-flex items-center gap-2 px-4 py-2 rounded-xl text-xs font-bold text-white bg-[#166534] hover:bg-[#14532D] shadow-xs cursor-pointer"
            >
              <Navigation className="w-3.5 h-3.5 text-[#EDE2D3]" />
              <span>Get Directions</span>
            </a>
            <span className="text-[11px] text-stone-500">
              Landmark: Opposite Jashn Palace Marriage Hall
            </span>
          </div>
        </div>

        {/* Contact Placeholders List */}
        <div className="space-y-3 pt-2">
          <div className="flex items-center gap-3 p-3 rounded-xl bg-[#FAF8F2] border border-[#EDE2D3] text-xs sm:text-sm text-stone-600">
            <Phone className="w-4 h-4 text-[#166534] shrink-0" />
            <div>
              <span className="font-semibold text-stone-800">Phone Enquiry:</span>{" "}
              <span className="text-stone-500">{SCHOOL_DATA.contactPlaceholders.phoneDisplay}</span>
            </div>
          </div>

          <div className="flex items-center gap-3 p-3 rounded-xl bg-[#FAF8F2] border border-[#EDE2D3] text-xs sm:text-sm text-stone-600">
            <Mail className="w-4 h-4 text-[#6B4226] shrink-0" />
            <div>
              <span className="font-semibold text-stone-800">Email:</span>{" "}
              <span className="text-stone-500">{SCHOOL_DATA.contactPlaceholders.emailDisplay}</span>
            </div>
          </div>

          <div className="flex items-center gap-3 p-3 rounded-xl bg-[#FAF8F2] border border-[#EDE2D3] text-xs sm:text-sm text-stone-600">
            <Clock className="w-4 h-4 text-[#166534] shrink-0" />
            <div>
              <span className="font-semibold text-stone-800">Visiting Hours:</span>{" "}
              <span className="text-stone-500">{SCHOOL_DATA.contactPlaceholders.officeHoursDisplay}</span>
            </div>
          </div>
        </div>
      </div>

      {/* Quick Message / Query Form */}
      <div className="card-interactive lg:col-span-6 bg-white rounded-3xl border border-stone-200 p-6 sm:p-10 shadow-xs">
        <h3 className="text-xl sm:text-2xl font-black text-[#14532D] tracking-tight mb-2">
          Send a Message to Campus Desk
        </h3>
        <p className="text-xs sm:text-sm text-stone-500 mb-6">
          Have a question about admissions, classes, or visiting the school premises? Leave a note.
        </p>

        {submitted ? (
          <div className="p-8 rounded-2xl bg-[#E8F3EA] border border-[#2F7D4A]/30 text-center space-y-3 animate-in fade-in duration-200">
            <CheckCircle2 className="w-10 h-10 text-[#166534] mx-auto" />
            <h4 className="font-bold text-[#14532D] text-lg">Message Received</h4>
            <p className="text-xs sm:text-sm text-stone-600">
              Thank you for reaching out. The school desk at Ashok Rajpath Rd will attend to your query.
            </p>
            <button
              onClick={() => {
                setSubmitted(false);
                setForm({ name: "", phone: "", message: "" });
              }}
              className="btn-interactive mt-3 px-4 py-2 rounded-xl text-xs font-bold text-stone-700 bg-white border border-stone-200 hover:bg-stone-50 cursor-pointer"
            >
              Send Another Query
            </button>
          </div>
        ) : (
          <form onSubmit={handleSubmit} className="space-y-4">
            {error && (
              <div className="p-3 rounded-xl bg-red-50 border border-red-200 text-xs text-red-700 flex items-center gap-2">
                <AlertCircle className="w-4 h-4 shrink-0" />
                <span>{error}</span>
              </div>
            )}

            <div>
              <label className="block text-xs font-bold uppercase tracking-wider text-stone-700 mb-1">
                Your Name *
              </label>
              <input
                type="text"
                value={form.name}
                onChange={(e) => setForm({ ...form, name: e.target.value })}
                placeholder="Full Name"
                className="w-full px-4 py-2.5 rounded-xl text-sm bg-[#FAF8F2] border border-stone-300 focus:bg-white focus:outline-none focus:ring-2 focus:ring-[#166534] text-stone-900"
              />
            </div>

            <div>
              <label className="block text-xs font-bold uppercase tracking-wider text-stone-700 mb-1">
                Mobile Number *
              </label>
              <input
                type="tel"
                maxLength={10}
                value={form.phone}
                onChange={(e) => setForm({ ...form, phone: e.target.value.replace(/\D/g, "") })}
                placeholder="10-digit mobile number"
                className="w-full px-4 py-2.5 rounded-xl text-sm bg-[#FAF8F2] border border-stone-300 focus:bg-white focus:outline-none focus:ring-2 focus:ring-[#166534] text-stone-900"
              />
            </div>

            <div>
              <label className="block text-xs font-bold uppercase tracking-wider text-stone-700 mb-1">
                Your Query / Message *
              </label>
              <textarea
                rows={3}
                value={form.message}
                onChange={(e) => setForm({ ...form, message: e.target.value })}
                placeholder="How can we assist you?"
                className="w-full px-4 py-2.5 rounded-xl text-sm bg-[#FAF8F2] border border-stone-300 focus:bg-white focus:outline-none focus:ring-2 focus:ring-[#166534] text-stone-900 resize-none"
              />
            </div>

            <button
              type="submit"
              className="btn-interactive w-full py-3 px-6 rounded-xl font-bold text-white bg-[#166534] hover:bg-[#14532D] shadow-xs flex items-center justify-center gap-2 cursor-pointer"
            >
              <Send className="w-4 h-4 text-[#EDE2D3] btn-icon-nudge" />
              <span>Send Message</span>
            </button>
          </form>
        )}
      </div>
    </div>
  );
}
