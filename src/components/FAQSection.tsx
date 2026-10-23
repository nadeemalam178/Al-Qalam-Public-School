"use client";

import React, { useState } from "react";
import { ChevronDown, HelpCircle, MessageCircle, Phone, Search } from "lucide-react";

interface FAQItem {
  q: string;
  a: string;
  category: "admissions" | "academics" | "timings" | "transport";
}

const FAQS: FAQItem[] = [
  {
    category: "admissions",
    q: "What is the minimum age criteria for Nursery and Class 1?",
    a: "Under the National Education Policy (NEP 2020) guidelines followed by Al-Qalam Public School: for Nursery / Pre-School, the child must be 3 years of age as of 31st March of the admission year. For Class 1, the child must complete 6 years of age. You can verify your child's exact eligibility using our interactive Admission Calculator above.",
  },
  {
    category: "admissions",
    q: "What documents are required at the time of admission?",
    a: "Parents need to submit: (1) Copy of child's Birth Certificate, (2) Aadhaar Card of child & parents, (3) 4 recent passport-size photographs, and (4) Previous school report card & Transfer Certificate (TC) for admissions into Class 1 through Class 5.",
  },
  {
    category: "timings",
    q: "What are the daily school operational hours?",
    a: "School operational timings are Monday through Saturday from 7:30 AM to 1:30 PM (with seasonal winter adjustments communicated via notice circulars). Campus administrative desks remain open for parent inquiries until 2:30 PM.",
  },
  {
    category: "academics",
    q: "What curriculum and medium of instruction does the school follow?",
    a: "Al-Qalam Public School follows an English-medium curriculum aligned with CBSE educational standards. Alongside foundational English, Mathematics, Science/EVS, Hindi, and Social Studies, students receive daily instruction in Urdu, Deeniyat, and moral character education.",
  },
  {
    category: "academics",
    q: "How are Smart Classes integrated into everyday teaching?",
    a: "Every classroom is equipped with interactive Smart Class technology. Teachers use curated audio-visual modules, animated science simulations, and pronunciation aids to help young learners comprehend complex ideas visually and effectively.",
  },
  {
    category: "transport",
    q: "Is supervised school transport available for students?",
    a: "Yes. Supervised auto-rickshaw and van transport routes cover Ashok Rajpath Road, Sultanganj, Loharwa Ghat, Agarwal Tola, Alamganj, Patna City, Chowk, and nearby neighborhoods. Each vehicle operates under strict safety guidelines with designated drivers.",
  },
  {
    category: "admissions",
    q: "What is the fee payment structure and schedule?",
    a: "Al-Qalam maintains an affordable and transparent fee structure. Monthly tuition fees range from ₹750 for Nursery up to ₹1,300 for Class 5. Fees can be paid monthly or quarterly at the campus cash desk or online via UPI through our administrative desk.",
  },
  {
    category: "academics",
    q: "How can parents track their child's daily progress and homework?",
    a: "Parents receive regular notebook check reviews, monthly unit test mark sheets, and daily diary updates. Furthermore, parents can monitor attendance and circulars through our official Al-Qalam Mobile App.",
  },
];

export default function FAQSection() {
  const [activeCategory, setActiveCategory] = useState<"all" | "admissions" | "academics" | "timings" | "transport">("all");
  const [openIndex, setOpenIndex] = useState<number | null>(0);
  const [searchQuery, setSearchQuery] = useState("");

  const filteredFaqs = FAQS.filter((faq) => {
    const matchesCat = activeCategory === "all" || faq.category === activeCategory;
    const matchesSearch =
      faq.q.toLowerCase().includes(searchQuery.toLowerCase()) ||
      faq.a.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesCat && matchesSearch;
  });

  const toggle = (idx: number) => {
    setOpenIndex(openIndex === idx ? null : idx);
  };

  return (
    <section className="py-16 sm:py-20 lg:py-24 bg-white border-b border-stone-200">
      <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Header */}
        <div className="text-center space-y-3 mb-10 sm:mb-12">
          <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-md bg-[#E8F3EA] border border-[#2F7D4A]/20 text-[#14532D] text-xs font-bold uppercase tracking-wider">
            <HelpCircle className="w-3.5 h-3.5 text-[#14532D]" />
            <span>Parent Inquiries</span>
          </div>
          <h2 className="font-heading font-bold text-2xl sm:text-3xl lg:text-4xl text-stone-900 tracking-tight">
            Frequently Asked Questions
          </h2>
          <p className="text-stone-600 text-sm sm:text-base max-w-2xl mx-auto leading-relaxed">
            Clear answers to common questions about admissions, school routines, smart classes, and transport.
          </p>
        </div>

        {/* Search & Category Tabs */}
        <div className="flex flex-col md:flex-row items-center justify-between gap-4 mb-8">
          <div className="flex flex-wrap items-center gap-2 w-full md:w-auto">
            {[
              { id: "all", label: "All Questions" },
              { id: "admissions", label: "Admissions & Fees" },
              { id: "academics", label: "Academics & Smart Class" },
              { id: "timings", label: "Timings & Campus" },
              { id: "transport", label: "Transport" },
            ].map((tab) => (
              <button
                key={tab.id}
                onClick={() => setActiveCategory(tab.id as typeof activeCategory)}
                className={`px-3.5 py-1.5 rounded-lg text-xs font-semibold transition-colors cursor-pointer ${
                  activeCategory === tab.id
                    ? "bg-[#14532D] text-white shadow-xs"
                    : "bg-stone-50 text-stone-700 hover:bg-stone-100 border border-stone-200"
                }`}
              >
                {tab.label}
              </button>
            ))}
          </div>

          <div className="relative w-full md:w-64">
            <Search className="w-4 h-4 text-stone-400 absolute left-3 top-1/2 -translate-y-1/2 pointer-events-none" />
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              placeholder="Search questions..."
              className="w-full pl-9 pr-3 py-1.5 rounded-lg text-xs bg-stone-50 border border-stone-200 focus:bg-white focus:outline-none focus:ring-2 focus:ring-[#14532D]"
            />
          </div>
        </div>

        {/* Accordion List */}
        <div className="space-y-3">
          {filteredFaqs.length > 0 ? (
            filteredFaqs.map((faq, idx) => {
              const isOpen = openIndex === idx;
              return (
                <div
                  key={idx}
                  className="border border-stone-200 rounded-xl overflow-hidden transition-all duration-200 bg-white shadow-2xs hover:border-[#14532D]/30"
                >
                  <button
                    onClick={() => toggle(idx)}
                    aria-expanded={isOpen}
                    className="w-full px-5 py-4 text-left flex items-center justify-between gap-4 hover:bg-stone-50/70 transition-colors cursor-pointer"
                  >
                    <span className="font-heading font-bold text-sm sm:text-base text-stone-900 leading-snug">
                      {faq.q}
                    </span>
                    <ChevronDown
                      className={`w-5 h-5 text-stone-500 shrink-0 transition-transform duration-300 ${
                        isOpen ? "rotate-180 text-[#14532D]" : ""
                      }`}
                    />
                  </button>

                  {isOpen && (
                    <div className="px-5 pb-5 text-xs sm:text-sm text-stone-600 leading-relaxed border-t border-stone-100 pt-3 bg-stone-50/40">
                      {faq.a}
                    </div>
                  )}
                </div>
              );
            })
          ) : (
            <div className="text-center py-10 bg-stone-50 rounded-xl border border-stone-200 text-stone-500 text-sm">
              No matching questions found for &ldquo;{searchQuery}&rdquo;.
            </div>
          )}
        </div>

        {/* Still have questions card */}
        <div className="mt-10 p-6 rounded-2xl bg-[#E8F3EA]/70 border border-[#2F7D4A]/25 flex flex-col sm:flex-row items-center justify-between gap-4">
          <div className="space-y-1 text-center sm:text-left">
            <h4 className="font-heading font-bold text-sm sm:text-base text-[#14532D]">
              Have a specific question about your child&apos;s admission?
            </h4>
            <p className="text-xs text-stone-600">
              Our campus administration desk is available Monday to Saturday to assist you personally.
            </p>
          </div>

          <div className="flex items-center gap-3 shrink-0">
            <a
              href="https://wa.me/919308462418?text=Hello%20Al-Qalam%20Public%20School,%20I%20have%20an%20admission%20inquiry."
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-1.5 px-3.5 py-2 rounded-lg bg-[#25D366] text-white font-bold text-xs shadow-xs hover:bg-[#20BE5B] transition-colors"
            >
              <MessageCircle className="w-3.5 h-3.5" />
              <span>WhatsApp Us</span>
            </a>
            <a
              href="tel:+919308462418"
              className="inline-flex items-center gap-1.5 px-3.5 py-2 rounded-lg bg-[#14532D] text-white font-bold text-xs shadow-xs hover:bg-[#0E3D1E] transition-colors"
            >
              <Phone className="w-3.5 h-3.5" />
              <span>Call Campus</span>
            </a>
          </div>
        </div>
      </div>
    </section>
  );
}
