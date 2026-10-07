"use client";

import React, { useState } from "react";
import Link from "next/link";
import { ArrowRight, GraduationCap, BookOpen, Sparkles, CheckCircle2 } from "lucide-react";

interface AcademicTab {
  id: string;
  stageName: string;
  grades: string;
  badge: string;
  badgeBg: string;
  tagline: string;
  description: string;
  keyPillars: { title: string; desc: string }[];
  subjects: string[];
}

const ACADEMIC_TABS: AcademicTab[] = [
  {
    id: "early-years",
    stageName: "Early Childhood Wing",
    grades: "Pre-Nursery & Nursery",
    badge: "Age 3 – 4 Years",
    badgeBg: "#14532D",
    tagline: "Joyful play-based readiness & sensory motor discovery",
    description:
      "A warm, secure environment where young toddlers begin their educational journey through activity-based rhymes, fine motor manipulation, color identification, and speech fluency.",
    keyPillars: [
      { title: "Phonetic Sound Sense", desc: "Interactive phonics, nursery rhymes, and auditory recognition" },
      { title: "Tactile Coordination", desc: "Clay modeling, grip exercises, paper craft, and kinetic play" },
      { title: "Cognitive Sorting", desc: "Shapes, primary colors, numbers 1-20, and pattern puzzles" },
      { title: "Social Habits", desc: "Caring interaction, sharing toys, clean eating, and polite manners" },
    ],
    subjects: ["English Phonics", "Spoken Hindi", "Basic Numbers", "Art & Craft", "Rhymes & Rhythm"],
  },
  {
    id: "kindergarten",
    stageName: "Kindergarten Milestones",
    grades: "LKG & UKG",
    badge: "Age 4 – 5 Years",
    badgeBg: "#166534",
    tagline: "Structured reading, bilingual communication & numeracy",
    description:
      "Bridging pre-primary joy with structured pencil-and-paper milestones. Students learn cursive letter tracing, bilingual vocabulary in English and Hindi, simple addition, and nature awareness.",
    keyPillars: [
      { title: "Reading Fluency", desc: "3-letter CVC blending, sight words, and illustrated storybooks" },
      { title: "Pencil Grip & Script", desc: "Accurate two-line and four-line notebook handwriting" },
      { title: "Mathematical Concepts", desc: "Addition sense, backward counting, before/after concepts" },
      { title: "Environmental Studies", desc: "Seasons, family, community helpers, plants, and animal life" },
    ],
    subjects: ["English Literacy", "Hindi Varnamala", "Elementary Math", "General Awareness", "Urdu Alphabet (Basics)"],
  },
  {
    id: "primary",
    stageName: "Primary Scholastic Wing",
    grades: "Class 1 to Class 5",
    badge: "CBSE Standard",
    badgeBg: "#B45309",
    tagline: "Rigorous academic competence & critical thinking skills",
    description:
      "Adhering to CBSE foundational standards with comprehensive training in English grammar, Hindi literature, Mathematics, Environmental Studies (EVS), Science, and introductory computer logic.",
    keyPillars: [
      { title: "Mathematical Mastery", desc: "Multiplication tables, word problems, fractions, and mental arithmetic" },
      { title: "Inquiry-Based Science", desc: "Interactive experiments, human anatomy, ecology, and living systems" },
      { title: "Linguistic Precision", desc: "Reading comprehension, creative essays, formal grammar, and dictation" },
      { title: "Digital Foundations", desc: "Computer parts, typing proficiency, paint tools, and safe IT literacy" },
    ],
    subjects: ["Mathematics", "English Literature & Grammar", "Hindi", "Environmental Studies (EVS)", "General Science", "Computer Studies", "Social Studies"],
  },
  {
    id: "deeniyat",
    stageName: "Moral Ethics & Deeniyat",
    grades: "Pre-N to Class 5",
    badge: "Character Building",
    badgeBg: "#2F7D4A",
    tagline: "Values-first Islamic ethics, Quranic Tajweed & civic responsibility",
    description:
      "A dedicated values curriculum running in harmony with modern CBSE subjects, nurturing truthfulness, respect for parents and elders, civic discipline, and correct Quranic Arabic phonetics.",
    keyPillars: [
      { title: "Quranic Phonetics (Tajweed)", desc: "Correct Makharij, Noorani Qaida recitation, and daily Duas" },
      { title: "Moral Stories (Akhlaq)", desc: "Prophetic virtues, honesty, cleanliness (Taharah), and kindness to all" },
      { title: "Civic Etiquette (Adab)", desc: "Greeting elders with Salam, respecting teachers, humility, and discipline" },
      { title: "Universal Humanity", desc: "Compassion for neighbors, community service, and environmental stewardship" },
    ],
    subjects: ["Noorani Qaida", "Deeniyat & Hifz of short Surahs", "Masnoon Duas", "Islamic History Stories", "Moral Science"],
  },
];

export default function AcademicsSection() {
  const [activeTabId, setActiveTabId] = useState("early-years");
  const activeTab = ACADEMIC_TABS.find((t) => t.id === activeTabId) || ACADEMIC_TABS[0];

  return (
    <section className="py-16 sm:py-20 lg:py-24 bg-white border-b border-stone-200">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Heading with Right Link */}
        <div className="flex flex-col md:flex-row md:items-end justify-between gap-4 mb-10 sm:mb-12">
          <div className="space-y-3">
            <div className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-md bg-[#E8F3EA] text-[#14532D] text-xs font-bold uppercase tracking-wider">
              <GraduationCap className="w-3.5 h-3.5 text-[#14532D]" />
              <span>Academic Curriculum</span>
            </div>
            <h2 className="font-heading font-bold text-2xl sm:text-3xl lg:text-4xl tracking-tight text-stone-900">
              Structured Learning from Pre-Nursery to Class 5
            </h2>
            <p className="text-stone-600 text-sm sm:text-base max-w-2xl leading-relaxed">
              Designed around child developmental milestones, combining CBSE academic standards with character-building moral education in Gulzarbagh, Patna.
            </p>
          </div>

          <Link
            href="/admissions"
            className="btn-primary-school text-xs py-2.5 px-4 font-semibold flex items-center gap-2 shrink-0 shadow-xs"
          >
            <span>Apply for Academic Year</span>
            <ArrowRight className="w-3.5 h-3.5 text-white/80" />
          </Link>
        </div>

        {/* Tab Navigation Header */}
        <div
          className="flex overflow-x-auto no-scrollbar border-b border-stone-200 gap-1 mb-8"
          role="tablist"
          aria-label="Academic Stages"
        >
          {ACADEMIC_TABS.map((tab) => {
            const isActive = tab.id === activeTabId;
            return (
              <button
                key={tab.id}
                role="tab"
                aria-selected={isActive}
                aria-controls={`panel-${tab.id}`}
                id={`tab-${tab.id}`}
                onClick={() => setActiveTabId(tab.id)}
                className={`px-5 py-3 text-xs sm:text-sm font-bold shrink-0 transition-all cursor-pointer flex items-center gap-2 border-t border-x rounded-t-lg ${
                  isActive
                    ? "bg-stone-50/90 text-[#14532D] border-stone-200 border-b-transparent shadow-xs"
                    : "bg-white text-stone-600 border-transparent hover:text-stone-900 hover:bg-stone-50"
                }`}
                style={{
                  borderBottom: isActive ? "2px solid #14532D" : undefined,
                }}
              >
                <span>{tab.stageName}</span>
                <span
                  className="text-[10px] font-extrabold uppercase px-1.5 py-0.5 rounded-sm"
                  style={{
                    backgroundColor: isActive ? tab.badgeBg : "#E5E7EB",
                    color: isActive ? "#FFFFFF" : "#4B5563",
                  }}
                >
                  {tab.grades}
                </span>
              </button>
            );
          })}
        </div>

        {/* Active Tab Panel */}
        <div
          id={`panel-${activeTab.id}`}
          role="tabpanel"
          aria-labelledby={`tab-${activeTab.id}`}
          className="p-6 sm:p-8 bg-stone-50/70 border border-stone-200 rounded-xl shadow-xs animate-slide-up"
        >
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
            {/* Left Column: Stage Info & Key Pillars */}
            <div className="lg:col-span-8 space-y-6">
              <div className="space-y-2">
                <div className="flex items-center gap-2">
                  <span
                    className="text-xs font-bold uppercase tracking-wider px-2.5 py-1 rounded-sm text-white"
                    style={{ backgroundColor: activeTab.badgeBg }}
                  >
                    {activeTab.badge}
                  </span>
                  <span className="text-xs font-semibold text-stone-500">
                    Target Class: {activeTab.grades}
                  </span>
                </div>
                <h3 className="font-heading font-bold text-2xl sm:text-3xl tracking-tight text-stone-900">
                  {activeTab.stageName}
                </h3>
                <p className="text-sm sm:text-base font-semibold text-[#166534]">
                  &ldquo;{activeTab.tagline}&rdquo;
                </p>
                <p className="text-stone-700 text-sm leading-relaxed">
                  {activeTab.description}
                </p>
              </div>

              {/* 4 Developmental Pillars Grid */}
              <div className="space-y-3 pt-2">
                <p className="text-xs font-extrabold uppercase tracking-wider text-stone-600">
                  Core Learning Milestones:
                </p>
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                  {activeTab.keyPillars.map((pillar, idx) => (
                    <div
                      key={idx}
                      className="p-3.5 bg-white rounded-lg border border-stone-200/90 shadow-2xs"
                    >
                      <div className="flex items-center gap-2 mb-1">
                        <CheckCircle2 className="w-4 h-4 text-[#166534] shrink-0" />
                        <h4 className="font-bold text-xs sm:text-sm text-stone-900">
                          {pillar.title}
                        </h4>
                      </div>
                      <p className="text-xs text-stone-600 pl-6 leading-relaxed">
                        {pillar.desc}
                      </p>
                    </div>
                  ))}
                </div>
              </div>
            </div>

            {/* Right Column: Subject Curriculum & Enrolment Card */}
            <div className="lg:col-span-4 bg-white p-6 rounded-xl border border-stone-200/90 shadow-xs space-y-5">
              <div>
                <span className="text-[11px] font-bold uppercase tracking-wider text-stone-500 block mb-2">
                  Prescribed Curriculum Areas:
                </span>
                <div className="flex flex-wrap gap-1.5">
                  {activeTab.subjects.map((sub, i) => (
                    <span
                      key={i}
                      className="text-xs font-medium px-2.5 py-1 rounded-sm bg-stone-50 text-stone-800 border border-stone-200"
                    >
                      {sub}
                    </span>
                  ))}
                </div>
              </div>

              <div className="p-4 rounded-lg bg-amber-50/70 border border-amber-200/60 space-y-1.5">
                <div className="flex items-center gap-1.5 text-xs font-bold text-[#B45309] uppercase tracking-wider">
                  <Sparkles className="w-3.5 h-3.5" />
                  <span>Limited Batch Size</span>
                </div>
                <p className="text-xs text-stone-700 leading-snug">
                  To ensure personalized attention, class strength is strictly capped at 20-25 students per section.
                </p>
              </div>

              <div className="pt-2">
                <Link
                  href="/admissions"
                  className="btn-primary-school w-full text-xs py-2.5 px-4 font-bold flex items-center justify-center gap-2 shadow-xs"
                >
                  <span>Enquire for {activeTab.grades}</span>
                  <ArrowRight className="w-3.5 h-3.5 text-white/80" />
                </Link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
