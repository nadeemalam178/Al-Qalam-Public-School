"use client";

import React, { useState } from "react";
import { Star, Quote, CheckCircle, Heart, Users, MapPin } from "lucide-react";

interface Testimonial {
  id: string;
  parentName: string;
  relation: string;
  studentName: string;
  grade: string;
  locality: string;
  rating: number;
  highlight: string;
  feedback: string;
  category: "foundational" | "primary";
}

const TESTIMONIALS: Testimonial[] = [
  {
    id: "1",
    parentName: "Mohd. Tariq Alam",
    relation: "Father of",
    studentName: "Zaid Alam",
    grade: "Class 3",
    locality: "Agarwal Tola, Gulzarbagh",
    rating: 5,
    highlight: "Remarkable improvement in English speaking & math clarity",
    feedback:
      "When Zaid joined in Class 1, he was shy with English words. In two years at Al-Qalam, his reading fluency and mental arithmetic have grown tremendously. The teachers pay personal attention to each child's notebook every single afternoon.",
    category: "primary",
  },
  {
    id: "2",
    parentName: "Shagufta Parveen",
    relation: "Mother of",
    studentName: "Ayesha Fatima",
    grade: "Upper Kindergarten (UKG)",
    locality: "Sultanganj Dargah Rd",
    rating: 5,
    highlight: "Safe, respectful atmosphere with caring female mentors",
    feedback:
      "Finding a safe school close to home on Ashok Rajpath was our priority. Al-Qalam's CCTV monitoring, clean campus, and female teachers for foundational classes give us complete peace of mind. Ayesha loves the interactive Smart Class rhymes!",
    category: "foundational",
  },
  {
    id: "3",
    parentName: "Er. Imran Warsi",
    relation: "Father of",
    studentName: "Rayyan Warsi",
    grade: "Class 1",
    locality: "Loharwa Ghat, Alamganj",
    rating: 5,
    highlight: "Perfect balance of modern CBSE syllabus & moral Deeniyat",
    feedback:
      "What sets Al-Qalam apart from other local schools is the combination of solid English-medium education with strong moral values, discipline, and daily Deeniyat. My child recites daily supplications and also speaks confident conversational English.",
    category: "foundational",
  },
  {
    id: "4",
    parentName: "Dr. Parwez Akhtar",
    relation: "Father of",
    studentName: "Mariam Akhtar",
    grade: "Class 4",
    locality: "Patna City / Chowk",
    rating: 5,
    highlight: "Neat handwriting, disciplined routine & regular unit tests",
    feedback:
      "The school strictly emphasizes neat penmanship and timely homework. The monthly progress reports and teacher-parent interactions keep us fully updated about Mariam's academic standing.",
    category: "primary",
  },
  {
    id: "5",
    parentName: "Farhana Bano",
    relation: "Mother of",
    studentName: "Hamza Sheikh",
    grade: "Lower Kindergarten (LKG)",
    locality: "Ashok Rajpath Rd",
    rating: 5,
    highlight: "Affordable fee structure without sacrificing quality",
    feedback:
      "For middle-class families in Gulzarbagh, Al-Qalam provides quality primary schooling and digital smart classes at a genuinely fair and transparent fee structure. No hidden demands or exorbitant annual charges.",
    category: "foundational",
  },
];

export default function ParentTestimonials() {
  const [filter, setFilter] = useState<"all" | "foundational" | "primary">("all");

  const filtered = TESTIMONIALS.filter((t) => {
    if (filter === "all") return true;
    return t.category === filter;
  });

  return (
    <section className="py-16 sm:py-20 lg:py-24 bg-stone-50/80 border-b border-stone-200">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Header */}
        <div className="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-12 sm:mb-14">
          <div className="space-y-3">
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-md bg-[#E8F3EA] border border-[#2F7D4A]/20 text-[#14532D] text-xs font-bold uppercase tracking-wider">
              <Heart className="w-3.5 h-3.5 text-[#14532D]" />
              <span>Parent Voices &amp; Trust</span>
            </div>
            <h2 className="font-heading font-bold text-2xl sm:text-3xl lg:text-4xl text-stone-900 tracking-tight">
              What Families Say About Al-Qalam
            </h2>
            <p className="text-stone-600 text-sm sm:text-base max-w-2xl leading-relaxed">
              Real reflections from parents in Gulzarbagh, Sultanganj, and Alamganj whose children study from Pre-Nursery through Class 5.
            </p>
          </div>

          {/* Filter Pills */}
          <div className="flex items-center gap-2 bg-white p-1 rounded-xl border border-stone-200 shadow-2xs self-start md:self-auto shrink-0">
            <button
              onClick={() => setFilter("all")}
              className={`px-3.5 py-1.5 rounded-lg text-xs font-semibold transition-colors cursor-pointer ${
                filter === "all"
                  ? "bg-[#14532D] text-white shadow-xs"
                  : "text-stone-600 hover:text-stone-900"
              }`}
            >
              All Reviews
            </button>
            <button
              onClick={() => setFilter("foundational")}
              className={`px-3.5 py-1.5 rounded-lg text-xs font-semibold transition-colors cursor-pointer ${
                filter === "foundational"
                  ? "bg-[#14532D] text-white shadow-xs"
                  : "text-stone-600 hover:text-stone-900"
              }`}
            >
              Foundational (Pre-KG / KG)
            </button>
            <button
              onClick={() => setFilter("primary")}
              className={`px-3.5 py-1.5 rounded-lg text-xs font-semibold transition-colors cursor-pointer ${
                filter === "primary"
                  ? "bg-[#14532D] text-white shadow-xs"
                  : "text-stone-600 hover:text-stone-900"
              }`}
            >
              Primary (Class 1–5)
            </button>
          </div>
        </div>

        {/* Testimonials Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {filtered.map((item) => (
            <div
              key={item.id}
              className="bg-white rounded-2xl border border-stone-200/90 p-6 sm:p-7 shadow-xs hover:shadow-md hover:border-[#14532D]/30 transition-all duration-300 flex flex-col justify-between"
            >
              <div className="space-y-4">
                {/* Rating & Verified Tag */}
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-1 text-amber-400">
                    {Array.from({ length: item.rating }).map((_, i) => (
                      <Star key={i} className="w-4 h-4 fill-amber-400 text-amber-400" />
                    ))}
                  </div>
                  <span className="inline-flex items-center gap-1 text-[11px] font-semibold text-emerald-700 bg-emerald-50 px-2 py-0.5 rounded-full border border-emerald-200">
                    <CheckCircle className="w-3 h-3" />
                    <span>Verified Parent</span>
                  </span>
                </div>

                {/* Highlight Title */}
                <h3 className="font-heading font-bold text-stone-900 text-base leading-snug">
                  &ldquo;{item.highlight}&rdquo;
                </h3>

                {/* Quote Text */}
                <p className="text-stone-600 text-xs sm:text-sm leading-relaxed relative">
                  <Quote className="w-5 h-5 text-stone-200 absolute -top-2 -left-2 -z-0 opacity-50" />
                  <span className="relative z-10">{item.feedback}</span>
                </p>
              </div>

              {/* Author Footer */}
              <div className="pt-5 mt-6 border-t border-stone-100 flex items-center justify-between">
                <div>
                  <h4 className="font-heading font-bold text-xs sm:text-sm text-stone-900">
                    {item.parentName}
                  </h4>
                  <p className="text-[11px] text-stone-500">
                    {item.relation} <strong className="text-stone-700">{item.studentName}</strong> ({item.grade})
                  </p>
                </div>
                <div className="text-right">
                  <span className="inline-flex items-center gap-1 text-[10px] text-stone-400">
                    <MapPin className="w-3 h-3 text-stone-400" />
                    <span>{item.locality.split(",")[0]}</span>
                  </span>
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Bottom Trust Banner */}
        <div className="mt-12 p-6 rounded-2xl bg-gradient-to-r from-[#14532D] to-[#0F3E22] text-white flex flex-col sm:flex-row items-center justify-between gap-6 shadow-md">
          <div className="flex items-center gap-4 text-center sm:text-left">
            <div className="w-12 h-12 rounded-xl bg-white/10 flex items-center justify-center shrink-0 border border-white/20">
              <Users className="w-6 h-6 text-emerald-300" />
            </div>
            <div>
              <h4 className="font-heading font-bold text-base sm:text-lg">
                Join 400+ Satisfied Families in Patna City
              </h4>
              <p className="text-xs sm:text-sm text-emerald-100/90">
                Admissions for Academic Session 2026–27 are now open from Pre-Nursery to Class 5.
              </p>
            </div>
          </div>

          <a
            href="#admissions"
            className="px-5 py-2.5 rounded-xl bg-[#E5A93C] hover:bg-[#D4982B] text-stone-900 font-bold text-xs shadow-sm transition-colors shrink-0"
          >
            Apply for Admission
          </a>
        </div>
      </div>
    </section>
  );
}
