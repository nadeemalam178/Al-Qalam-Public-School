import React from "react";
import type { Metadata } from "next";
import Link from "next/link";
import Image from "next/image";
import {
  BookOpen,
  GraduationCap,
  MonitorPlay,
  Brain,
  CheckCircle2,
  ArrowRight,
  Sparkles,
} from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";
import { schoolImages } from "@/data/schoolImages";

export const metadata: Metadata = {
  title: "Academic Curriculum & Methodology",
  description:
    "Explore the foundational and primary curriculum at Al-Qalam Public School, Gulzarbagh, Patna. Concept-based teaching, Smart Classes, and disciplined study habits.",
};

export default function AcademicsPage() {
  const learningPillars = [
    {
      title: "Concept-Based Instruction",
      desc: "Moving past mechanical memorization to cultivate true comprehension through patient explanations and step-by-step guidance.",
      icon: Brain,
    },
    {
      title: "Smart Class Visual Reinforcement",
      desc: "Audio-visual modules that illustrate scientific patterns, geometric forms, and language stories with clarity.",
      icon: MonitorPlay,
    },
    {
      title: "Daily Reading & Penmanship",
      desc: "Structured practice in pronunciation, phonetic spelling, reading fluency, and legible handwriting every single day.",
      icon: BookOpen,
    },
    {
      title: "Values & Classroom Habits",
      desc: "Cultivating respect, attentiveness, tidy study materials, and cooperative participation during lessons.",
      icon: Sparkles,
    },
  ];

  return (
    <div className="bg-white">
      {/* Banner */}
      <section className="bg-forest-hero text-white py-14 sm:py-18 lg:py-20 border-b border-[#0B3B20]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-3">
          <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-md bg-white/10 border border-white/20 text-emerald-200 text-xs font-bold uppercase tracking-wider backdrop-blur-xs">
            <GraduationCap className="w-3.5 h-3.5" />
            <span>Academic Framework</span>
          </div>
          <h1 className="font-heading font-black text-3xl sm:text-4xl lg:text-5xl text-white tracking-tight">
            Academic Curriculum & Child Development
          </h1>
          <p className="text-base sm:text-lg text-stone-200 max-w-2xl mx-auto leading-relaxed">
            A balanced foundational and primary curriculum designed to spark curiosity, build strong basic skills, and instill disciplined study habits.
          </p>
        </div>
      </section>

      {/* Teaching Methodology */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="max-w-3xl mx-auto text-center mb-12 sm:mb-14 space-y-3">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#E8F3EA] border border-[#2F7D4A]/20 text-[#14532D] text-xs font-bold uppercase tracking-wider">
              <span>Teaching Method</span>
            </div>
            <h2 className="font-heading font-bold text-2xl sm:text-3xl text-stone-900 tracking-tight">
              How We Teach at Al-Qalam
            </h2>
            <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
              Our instructional method blends traditional classroom focus with modern interactive visual aids for primary learners.
            </p>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {learningPillars.map((pillar, i) => {
              const Icon = pillar.icon;
              return (
                <div
                  key={i}
                  className="bg-stone-50/70 p-6 rounded-xl border border-stone-200/90 shadow-xs flex flex-col justify-between"
                >
                  <div>
                    <div className="w-10 h-10 rounded-lg bg-white text-[#14532D] flex items-center justify-center border border-stone-200 mb-4 shadow-2xs">
                      <Icon className="w-5 h-5" />
                    </div>
                    <h3 className="font-heading font-bold text-base text-stone-900 mb-1.5">
                      {pillar.title}
                    </h3>
                    <p className="text-stone-600 text-xs sm:text-sm leading-relaxed">
                      {pillar.desc}
                    </p>
                  </div>
                </div>
              );
            })}
          </div>

          {/* Real Classroom Feature */}
          <div className="mt-12 rounded-xl overflow-hidden border border-stone-200/90 bg-stone-50/70 shadow-xs">
            <div className="grid grid-cols-1 lg:grid-cols-12 items-center">
              <div className="lg:col-span-7 relative h-64 sm:h-80 w-full bg-stone-900">
                <Image
                  src={schoolImages.academics.src}
                  alt={schoolImages.academics.alt}
                  fill
                  sizes="(max-width: 1024px) 100vw, 60vw"
                  className="object-cover object-center"
                />
                <div className="absolute inset-0 bg-gradient-to-t from-black/50 via-transparent to-transparent pointer-events-none" />
                <div className="absolute bottom-3 left-3 bg-black/65 backdrop-blur-xs text-white text-[11px] font-medium px-3 py-1 rounded-md border border-white/20">
                  Al-Qalam Primary Classroom Environment
                </div>
              </div>

              <div className="lg:col-span-5 p-6 sm:p-8 space-y-3">
                <span className="text-xs uppercase tracking-wider font-bold text-[#14532D]">
                  Classroom Atmosphere
                </span>
                <h3 className="font-heading font-bold text-xl sm:text-2xl text-stone-900">
                  Attentive Mentorship in Every Lesson
                </h3>
                <p className="text-stone-600 text-xs sm:text-sm leading-relaxed">
                  Teachers work closely with young students to ensure no child is left behind in core reading, counting, or spelling. Regular classroom feedback encourages self-confidence.
                </p>
                <div className="pt-2">
                  <Link
                    href="/admissions"
                    className="inline-flex items-center gap-1.5 text-xs font-bold text-[#14532D] hover:underline"
                  >
                    <span>Inquire About Class Enrollment</span>
                    <ArrowRight className="w-3.5 h-3.5" />
                  </Link>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Academic Stages Detailed Breakdown */}
      <section className="py-16 sm:py-20 bg-stone-50/70 border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="max-w-3xl mx-auto text-center mb-12 space-y-3">
            <h2 className="font-heading font-bold text-2xl sm:text-3xl text-stone-900 tracking-tight">
              Educational Stages at Al-Qalam
            </h2>
            <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
              Curriculum progression tailored to the developmental needs of young children from pre-primary readiness through primary standards.
            </p>
          </div>

          <div className="space-y-8 max-w-4xl mx-auto">
            {SCHOOL_DATA.academicStages.map((stage, idx) => (
              <div
                key={stage.id}
                className="bg-white rounded-xl p-6 sm:p-8 border border-stone-200/90 shadow-xs flex flex-col md:flex-row gap-8 items-start"
              >
                <div className="md:w-1/3 space-y-2 shrink-0">
                  <span className="inline-block px-2.5 py-0.5 rounded text-xs font-bold bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/25">
                    Stage 0{idx + 1}
                  </span>
                  <h3 className="font-heading font-bold text-xl sm:text-2xl text-stone-900">
                    {stage.stageName}
                  </h3>
                  <p className="text-xs font-bold text-[#14532D]">
                    {stage.grades}
                  </p>
                  <p className="text-xs text-stone-500 pt-1">
                    <strong>Focus:</strong> {stage.focus}
                  </p>
                </div>

                <div className="md:w-2/3 space-y-4">
                  <p className="text-stone-600 text-xs sm:text-sm leading-relaxed">
                    {stage.description}
                  </p>

                  <div className="bg-stone-50/70 p-4 rounded-xl border border-stone-200/80 space-y-2">
                    <p className="text-xs font-bold uppercase tracking-wider text-stone-700">
                      Subject & Learning Highlights:
                    </p>
                    <ul className="space-y-2">
                      {stage.highlights.map((item, i) => (
                        <li key={i} className="flex items-start gap-2.5 text-xs text-stone-700">
                          <CheckCircle2 className="w-4 h-4 text-[#166534] shrink-0 mt-0.5" />
                          <span>{item}</span>
                        </li>
                      ))}
                    </ul>
                  </div>

                  <div className="pt-1">
                    <Link
                      href="/admissions"
                      className="inline-flex items-center gap-1.5 text-xs font-bold text-[#14532D] hover:underline"
                    >
                      <span>Submit Admission Enquiry for {stage.stageName}</span>
                      <ArrowRight className="w-3.5 h-3.5" />
                    </Link>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="py-16 sm:py-20 bg-white">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-5">
          <h2 className="font-heading font-bold text-2xl sm:text-3xl text-stone-900 tracking-tight">
            Interested in Enrolling Your Child?
          </h2>
          <p className="text-stone-600 text-sm sm:text-base leading-relaxed max-w-2xl mx-auto">
            Admissions enquiries are accepted for pre-primary and primary grades. Submit an enquiry online or speak with our school administration at the campus desk.
          </p>
          <div className="pt-2">
            <Link
              href="/admissions"
              className="btn-primary px-6 py-3 rounded-lg text-sm font-semibold text-white bg-[#14532D] hover:bg-[#0B3B20] shadow-xs transition-colors inline-block"
            >
              <span>Go to Admissions Page</span>
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}
