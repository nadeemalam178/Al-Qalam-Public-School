import React from "react";
import type { Metadata } from "next";
import Link from "next/link";
import Image from "next/image";
import {
  BookOpen,
  GraduationCap,
  MonitorPlay,
  Brain,
  Palette,
  CheckCircle2,
  ArrowRight,
  HelpCircle,
  Sparkles,
} from "lucide-react";
import SectionHeading from "@/components/SectionHeading";
import CTA from "@/components/CTA";
import ScrollReveal from "@/components/ScrollReveal";
import { SCHOOL_DATA } from "@/data/schoolData";
import { schoolImages } from "@/data/schoolImages";

export const metadata: Metadata = {
  title: "Academics",
  description:
    "Explore the academic curriculum and methodology at Al-Qalam Public School, Gulzarbagh, Patna. Foundational learning, Smart Classes, and concept-based primary education.",
};

export default function AcademicsPage() {
  const learningPillars = [
    {
      title: "Concept-Based Learning",
      desc: "Moving beyond rote memorization. We emphasize deep understanding through interactive demonstrations and guided explanations.",
      icon: Brain,
      color: "text-[#166534] bg-[#E8F3EA] border-[#2F7D4A]/25",
    },
    {
      title: "Smart Class Audio-Visual Modules",
      desc: "Utilizing multimedia graphics, digital storytelling, and visual presentations to make abstract topics engaging.",
      icon: MonitorPlay,
      color: "text-[#166534] bg-[#E8F3EA] border-[#2F7D4A]/25",
    },
    {
      title: "Activity-Based Engagement",
      desc: "Hands-on drawing, tactile math manipulatives, and creative exercises that cultivate coordination and analytical thinking.",
      icon: Palette,
      color: "text-[#6B4226] bg-[#FAF8F2] border-[#EDE2D3]",
    },
    {
      title: "Foundational Literacy & Numeracy",
      desc: "Phonics, structured reading habits, neat penmanship, and basic arithmetic mastered with patience and consistency.",
      icon: BookOpen,
      color: "text-[#166534] bg-[#E8F3EA] border-[#2F7D4A]/25",
    },
  ];

  return (
    <div className="bg-white">
      {/* Banner */}
      <section className="bg-forest-hero text-white py-16 sm:py-20 border-b border-[#0d3b1f]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <ScrollReveal variant="fade-up">
            <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#0d3b1f]/60 border border-[#2F7D4A]/40 text-[#EDE2D3] text-xs font-bold uppercase tracking-wider mb-4">
              <GraduationCap className="w-4 h-4 text-[#E8F3EA]" />
              <span>Academic Curriculum</span>
            </div>
            <h1 className="text-3xl sm:text-4xl lg:text-5xl font-black tracking-tight text-white">
              Academic Excellence & Child Development
            </h1>
            <p className="mt-3 text-base sm:text-lg text-[#EDE2D3] max-w-2xl mx-auto">
              A balanced primary curriculum designed to spark curiosity, instill discipline, and build strong conceptual foundations.
            </p>
          </ScrollReveal>
        </div>
      </section>

      {/* Methodology Section - White */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
            <SectionHeading
              badge="Our Approach"
              title="How We Teach at Al-Qalam"
              subtitle="Our educational framework blends traditional values with modern instructional tools for primary age groups."
              center
            />
          </ScrollReveal>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {learningPillars.map((pillar, i) => {
              const Icon = pillar.icon;
              return (
                <ScrollReveal key={i} variant="fade-up" delay={i * 80}>
                  <div
                    className="card-interactive bg-[#FAF8F2] rounded-2xl p-6 border border-[#EDE2D3] shadow-xs flex flex-col justify-between h-full"
                  >
                    <div>
                      <div
                        className={`w-12 h-12 rounded-xl flex items-center justify-center border mb-5 ${pillar.color}`}
                      >
                        <Icon className="w-6 h-6" />
                      </div>
                      <h3 className="text-lg font-bold text-[#14532D] mb-2">
                        {pillar.title}
                      </h3>
                      <p className="text-xs sm:text-sm text-stone-600 leading-relaxed">
                        {pillar.desc}
                      </p>
                    </div>
                    <div className="mt-6 pt-3 border-t border-[#EDE2D3] text-xs font-semibold text-[#6B4226]">
                      Active Standard
                    </div>
                  </div>
                </ScrollReveal>
              );
            })}
          </div>

          {/* Academic Environment Feature Showcase */}
          <ScrollReveal variant="fade-up" delay={200} className="mt-12">
            <div className="card-interactive rounded-3xl overflow-hidden border border-[#EDE2D3] bg-[#FAF8F2] shadow-xs">
              <div className="grid grid-cols-1 lg:grid-cols-12 items-center">
                <div className="lg:col-span-7 img-zoom-parent relative h-64 sm:h-80 w-full overflow-hidden">
                  <Image
                    src={schoolImages.academics.src}
                    alt={schoolImages.academics.alt}
                    fill
                    sizes="(max-width: 1024px) 100vw, 60vw"
                    className="img-zoom-child object-cover"
                  />
                  <div className="absolute inset-0 bg-gradient-to-t from-[#14532D]/40 via-transparent to-transparent pointer-events-none" />
                  <div className="absolute bottom-3 left-3 bg-[#14532D]/90 backdrop-blur-xs text-white text-[11px] font-bold px-3 py-1 rounded-full border border-white/20">
                    Academic Environment
                  </div>
                </div>
                <div className="lg:col-span-5 p-6 sm:p-8 space-y-3">
                  <div className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-[#E8F3EA] text-[#14532D] text-xs font-bold uppercase tracking-wider border border-[#2F7D4A]/25">
                    <Sparkles className="w-3.5 h-3.5 text-[#166534]" />
                    <span>Nurturing Young Minds</span>
                  </div>
                  <h3 className="text-xl sm:text-2xl font-black text-[#14532D] leading-tight">
                    Concept-Centric Daily Classrooms
                  </h3>
                  <p className="text-xs sm:text-sm text-stone-600 leading-relaxed">
                    Small group activities and attentive teacher guidance ensure every child builds confidence in reading, arithmetic, and creative expression.
                  </p>
                  <p className="text-[11px] text-stone-400 italic">
                    *{schoolImages.academics.caption}
                  </p>
                </div>
              </div>
            </div>
          </ScrollReveal>
        </div>
      </section>

      {/* Academic Stages - Light Green (#E8F3EA) */}
      <section className="py-16 sm:py-20 bg-[#E8F3EA] border-b border-[#2F7D4A]/20">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
            <SectionHeading
              badge="Learning Stages"
              title="Educational Pathways"
              subtitle="Carefully calibrated for early childhood and primary developmental milestones."
              center
            />
          </ScrollReveal>

          <div className="space-y-8 max-w-4xl mx-auto">
            {SCHOOL_DATA.academicStages.map((stage, idx) => (
              <ScrollReveal key={stage.id} variant="fade-up" delay={idx * 100}>
                <div
                  className="card-interactive bg-white rounded-3xl p-6 sm:p-10 border border-stone-200 shadow-xs flex flex-col md:flex-row gap-8 items-start"
                >
                  <div className="md:w-1/3 space-y-3 shrink-0">
                    <span className="inline-block px-3 py-1 rounded-full text-xs font-bold uppercase bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/30">
                      Stage {idx + 1}
                    </span>
                    <h3 className="text-2xl font-black text-[#14532D] leading-tight">
                      {stage.stageName}
                    </h3>
                    <p className="text-xs font-bold text-[#6B4226]">
                      {stage.grades}
                    </p>
                    <p className="text-xs text-stone-500 font-medium">
                      Core Focus: {stage.focus}
                    </p>
                  </div>

                  <div className="md:w-2/3 space-y-4">
                    <p className="text-sm text-stone-600 leading-relaxed">
                      {stage.description}
                    </p>

                    <div className="bg-[#FAF8F2] p-4 rounded-xl border border-[#EDE2D3] space-y-2">
                      <p className="text-xs font-bold uppercase tracking-wider text-[#6B4226]">
                        Key Program Features
                      </p>
                      <ul className="space-y-2">
                        {stage.highlights.map((item, i) => (
                          <li key={i} className="flex items-start gap-2.5 text-xs sm:text-sm text-stone-700">
                            <CheckCircle2 className="w-4 h-4 text-[#166534] shrink-0 mt-0.5" />
                            <span>{item}</span>
                          </li>
                        ))}
                      </ul>
                    </div>

                    <div className="pt-2">
                      <Link
                        href="/admissions"
                        className="inline-flex items-center gap-1.5 text-xs font-bold text-[#166534] hover:text-[#14532D] transition group/link"
                      >
                        <span>Submit Admission Enquiry for {stage.stageName}</span>
                        <ArrowRight className="w-3.5 h-3.5 text-[#6B4226] group-hover/link:translate-x-1 transition-transform" />
                      </Link>
                    </div>
                  </div>
                </div>
              </ScrollReveal>
            ))}
          </div>

          {/* Curriculum Note Placeholder */}
          <ScrollReveal variant="fade-up" delay={150}>
            <div className="max-w-4xl mx-auto mt-8 p-4 bg-white rounded-2xl border border-stone-200 flex items-start gap-3 shadow-xs">
              <HelpCircle className="w-5 h-5 text-[#6B4226] shrink-0 mt-0.5" />
              <div className="text-xs text-stone-600 leading-relaxed">
                <span className="font-bold text-[#14532D]">Class & Section Structure:</span> Detailed syllabi, subject distributions, and book lists for specific classes are available at the school campus desk during office hours.
              </div>
            </div>
          </ScrollReveal>
        </div>
      </section>

      {/* CTA */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <ScrollReveal variant="fade-up">
          <CTA
            title="Inquire About Academic Admissions"
            subtitle="Speak with our admissions counselors to learn more about classes and enrollment criteria."
          />
        </ScrollReveal>
      </section>
    </div>
  );
}
