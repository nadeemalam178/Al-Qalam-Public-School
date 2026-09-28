import React from "react";
import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import {
  Compass,
  BookOpen,
  HeartHandshake,
  ShieldCheck,
  CheckCircle2,
  ArrowRight,
  Sparkles,
} from "lucide-react";
import DirectorCard from "@/components/DirectorCard";
import { SCHOOL_DATA } from "@/data/schoolData";
import { schoolImages } from "@/data/schoolImages";

export const metadata: Metadata = {
  title: "About Our School",
  description:
    "Learn about Al-Qalam Public School in Gulzarbagh, Patna. Our institutional history, educational philosophy, character values, and campus environment.",
};

export default function AboutPage() {
  const characterValues = [
    {
      title: "Academic Discipline",
      desc: "Regular classroom attendance, punctual habits, attentive listening, and structured homework practice.",
      icon: BookOpen,
    },
    {
      title: "Moral Respect & Courtesy",
      desc: "Polite speech, deference towards elders and teachers, and cooperative peer bonding.",
      icon: HeartHandshake,
    },
    {
      title: "Intellectual Curiosity",
      desc: "Encouraging children to ask thoughtful questions, observe the natural world, and enjoy reading books.",
      icon: Compass,
    },
    {
      title: "Safety & Integrity",
      desc: "A truthful character, honesty in examinations, and adherence to campus safety standards.",
      icon: ShieldCheck,
    },
  ];

  return (
    <div className="bg-white overflow-x-hidden">
      {/* 1. Page Hero Banner */}
      <section className="bg-forest-hero text-white py-14 sm:py-18 lg:py-20 border-b border-[#0B3B20]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-3">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#072413] border border-[#2F7D4A]/40 text-[#EDE2D3] text-xs font-semibold uppercase tracking-wider">
            <span>Institutional Profile</span>
          </div>
          <h1 className="font-heading font-black text-3xl sm:text-4xl lg:text-5xl text-white tracking-tight">
            About Al-Qalam Public School
          </h1>
          <p className="text-base sm:text-lg text-stone-200 max-w-2xl mx-auto leading-relaxed">
            Nurturing young minds through foundational learning, moral discipline, and caring mentorship in Gulzarbagh, Patna.
          </p>
        </div>
      </section>

      {/* 2. About Al-Qalam: Institutional Heritage */}
      <section className="py-16 sm:py-20 bg-white border-b border-[#E7E5E4]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-10 lg:gap-14 items-center">
            <div className="lg:col-span-7 space-y-5">
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#FAF8F2] border border-[#EDE2D3] text-[#6B4226] text-xs font-semibold uppercase tracking-wider">
                <span>School Overview</span>
              </div>
              <h2 className="font-heading font-black text-2xl sm:text-3xl lg:text-4xl text-[#14532D] tracking-tight leading-tight">
                Rooted in Community, Dedicated to Quality Primary Schooling
              </h2>
              <p className="text-stone-700 text-sm sm:text-base leading-relaxed">
                Al-Qalam Public School is an independent foundational and primary educational institution located on Ashok Rajpath Road in Gulzarbagh, Alamganj, Patna. Founded to serve families seeking a disciplined, supportive environment for early education, the school provides schooling from pre-primary readiness through class five.
              </p>
              <p className="text-stone-700 text-sm sm:text-base leading-relaxed">
                The name <em>Al-Qalam</em> (&ldquo;The Pen&rdquo;) is derived from the noble Quranic tradition celebrating the pen as the instrument of knowledge, reflection, and enlightenment. In keeping with this motto, our teachers place equal weight on academic proficiency, personal discipline, and respect for others.
              </p>

              <div className="p-4 rounded-xl bg-[#FAF8F2] border border-[#EDE2D3] text-xs text-stone-700 space-y-1">
                <span className="font-bold text-[#14532D]">Campus Address:</span>
                <p>{SCHOOL_DATA.address.fullAddress}</p>
              </div>
            </div>

            {/* School Classroom Photograph */}
            <div className="lg:col-span-5">
              <div className="relative rounded-2xl overflow-hidden shadow-md border border-[#EDE2D3] bg-stone-900 aspect-[4/3]">
                <Image
                  src={schoolImages.about.src}
                  alt={schoolImages.about.alt}
                  fill
                  sizes="(max-width: 1024px) 100vw, 40vw"
                  className="object-cover object-center"
                />
                <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent pointer-events-none" />
                <div className="absolute bottom-3 left-3 right-3 text-white text-xs">
                  <p className="font-semibold text-white">Daily Classroom Instruction</p>
                  <p className="text-stone-300 text-[11px]">Attentive primary learners at Al-Qalam Public School</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* 3. Educational Philosophy */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="max-w-3xl mx-auto text-center mb-12 space-y-3">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/25 text-xs font-semibold uppercase tracking-wider">
              <span>Philosophy</span>
            </div>
            <h2 className="font-heading font-black text-2xl sm:text-3xl text-[#14532D] tracking-tight">
              Our Educational Philosophy
            </h2>
            <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
              We believe every child is capable of steady progress when guided with consistent routines, patient instruction, and clear expectations.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-5xl mx-auto">
            <div className="bg-white p-7 sm:p-8 rounded-xl border border-[#E7E5E4] card-subtle space-y-3">
              <h3 className="font-heading font-bold text-xl text-[#14532D]">
                Foundational Concept Clarity
              </h3>
              <p className="text-stone-600 text-sm leading-relaxed">
                Rather than memorizing words without meaning, students are taught the fundamental principles behind reading, spelling, and mathematics. We believe early clarity builds lifelong intellectual self-reliance.
              </p>
            </div>

            <div className="bg-white p-7 sm:p-8 rounded-xl border border-[#E7E5E4] card-subtle space-y-3">
              <h3 className="font-heading font-bold text-xl text-[#14532D]">
                Character as the True Measure of Education
              </h3>
              <p className="text-stone-600 text-sm leading-relaxed">
                Academic success must be paired with humble manners, honest conduct, empathy for peers, and respect for elders. Classroom mentors actively guide children in everyday moral habits.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* 4. Our Approach to Learning */}
      <section className="py-16 sm:py-20 bg-white border-b border-[#E7E5E4]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-10 items-center">
            <div className="lg:col-span-6 space-y-5">
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#FAF8F2] border border-[#EDE2D3] text-[#6B4226] text-xs font-semibold uppercase tracking-wider">
                <Sparkles className="w-3.5 h-3.5 text-[#14532D]" />
                <span>Instructional Method</span>
              </div>
              <h2 className="font-heading font-black text-2xl sm:text-3xl text-[#14532D] tracking-tight">
                Our Approach to Classroom Teaching
              </h2>
              <p className="text-stone-700 text-sm sm:text-base leading-relaxed">
                Classroom instruction combines textbook study, neat penmanship practice, and interactive Smart Class audio-visual sessions. This balanced methodology helps students grasp abstract concepts with ease.
              </p>

              <ul className="space-y-2.5 pt-2">
                {[
                  "Daily language reading and phonetic pronunciation exercises",
                  "Step-by-step arithmetic operations with real-world examples",
                  "Smart class animations illustrating environmental and science lessons",
                  "Encouraging students to articulate their thoughts clearly in class",
                ].map((item, index) => (
                  <li key={index} className="flex items-start gap-2.5 text-xs sm:text-sm text-stone-800">
                    <CheckCircle2 className="w-4 h-4 text-[#166534] shrink-0 mt-0.5" />
                    <span>{item}</span>
                  </li>
                ))}
              </ul>
            </div>

            <div className="lg:col-span-6">
              <div className="bg-[#FAF8F2] p-6 sm:p-8 rounded-2xl border border-[#EDE2D3] space-y-4">
                <h3 className="font-heading font-bold text-lg text-[#14532D]">
                  Technology Used Responsibly
                </h3>
                <p className="text-stone-600 text-xs sm:text-sm leading-relaxed">
                  Technology at Al-Qalam is used to support teacher explanations rather than replace them. Audio-visual modules help visualize difficult concepts in science and mathematics, making learning lively and memorable.
                </p>
                <div className="pt-2 border-t border-[#EDE2D3]">
                  <Link
                    href="/facilities"
                    className="inline-flex items-center gap-1.5 text-xs font-semibold text-[#14532D] hover:underline"
                  >
                    <span>View Our Technology & Campus Facilities</span>
                    <ArrowRight className="w-3.5 h-3.5 text-[#6B4226]" />
                  </Link>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* 5. Character & Values */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="max-w-3xl mx-auto text-center mb-12 space-y-3">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/25 text-xs font-semibold uppercase tracking-wider">
              <span>Core Values</span>
            </div>
            <h2 className="font-heading font-black text-2xl sm:text-3xl text-[#14532D] tracking-tight">
              Character & Values We Instill
            </h2>
            <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
              Every school day begins with morning assemblies and regular guidance designed to cultivate integrity and kindness.
            </p>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {characterValues.map((val, idx) => {
              const IconComp = val.icon;
              return (
                <div
                  key={idx}
                  className="bg-white p-6 rounded-xl border border-[#E7E5E4] card-subtle flex flex-col justify-between"
                >
                  <div>
                    <div className="w-10 h-10 rounded-lg bg-[#E8F3EA] text-[#14532D] flex items-center justify-center mb-4 border border-[#2F7D4A]/20">
                      <IconComp className="w-5 h-5" />
                    </div>
                    <h3 className="font-heading font-bold text-base text-[#14532D] mb-1.5">
                      {val.title}
                    </h3>
                    <p className="text-stone-600 text-xs sm:text-sm leading-relaxed">
                      {val.desc}
                    </p>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      {/* 6. Director Section */}
      <section className="py-16 sm:py-20 bg-white border-b border-[#E7E5E4]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <DirectorCard />
        </div>
      </section>

      {/* 7. Campus Environment */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="max-w-3xl mx-auto text-center mb-10 space-y-3">
            <h2 className="font-heading font-black text-2xl sm:text-3xl text-[#14532D] tracking-tight">
              Campus Environment & Safety
            </h2>
            <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
              Our school premises opposite Jashn Palace Marriage Hall on Ashok Rajpath Road are maintained to offer children a peaceful, monitored learning sanctuary.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-5xl mx-auto text-xs text-stone-700">
            <div className="p-5 bg-white rounded-xl border border-[#E7E5E4] space-y-2">
              <h3 className="font-heading font-bold text-sm text-[#14532D]">Supervised Gates</h3>
              <p className="leading-relaxed text-stone-600">
                Visitor registration and supervised entry during school operational hours to ensure child safety.
              </p>
            </div>
            <div className="p-5 bg-white rounded-xl border border-[#E7E5E4] space-y-2">
              <h3 className="font-heading font-bold text-sm text-[#14532D]">Corridor CCTV</h3>
              <p className="leading-relaxed text-stone-600">
                Continuous monitored camera surveillance across school corridors and communal spaces.
              </p>
            </div>
            <div className="p-5 bg-white rounded-xl border border-[#E7E5E4] space-y-2">
              <h3 className="font-heading font-bold text-sm text-[#14532D]">Disciplined Atmosphere</h3>
              <p className="leading-relaxed text-stone-600">
                Structured class transitions and calm classrooms promoting focus and mutual consideration.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* 8. Call to Action */}
      <section className="py-16 sm:py-20 bg-white">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center space-y-6">
          <h2 className="font-heading font-black text-2xl sm:text-3xl text-[#14532D] tracking-tight">
            Learn More About Admissions at Al-Qalam
          </h2>
          <p className="text-stone-600 text-sm sm:text-base leading-relaxed max-w-2xl mx-auto">
            Admissions enquiries are welcomed for foundational and primary classes. Submit an online enquiry or visit our Gulzarbagh campus.
          </p>
          <div className="flex flex-wrap items-center justify-center gap-4">
            <Link
              href="/admissions"
              className="btn-primary px-6 py-3 rounded-lg text-sm font-semibold text-white bg-[#14532D] hover:bg-[#0B3B20] shadow-xs transition-colors"
            >
              <span>Submit Admission Enquiry</span>
            </Link>
            <Link
              href="/contact"
              className="btn-primary px-6 py-3 rounded-lg text-sm font-semibold text-stone-700 bg-[#FAF8F2] hover:bg-stone-100 border border-[#EDE2D3] transition-colors"
            >
              <span>Campus Location & Details</span>
            </Link>
          </div>
        </div>
      </section>
    </div>
  );
}
