import React from "react";
import Link from "next/link";
import Image from "next/image";
import {
  ShieldCheck,
  MonitorPlay,
  BookOpen,
  Sparkles,
  HeartHandshake,
  CheckCircle,
  ArrowRight,
  GraduationCap,
  Calendar,
  Compass,
} from "lucide-react";
import Hero from "@/components/Hero";
import SectionHeading from "@/components/SectionHeading";
import FacilityCard from "@/components/FacilityCard";
import NoticeCard from "@/components/NoticeCard";
import DirectorCard from "@/components/DirectorCard";
import ContactSection from "@/components/ContactSection";
import CTA from "@/components/CTA";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function HomePage() {
  const whyChoosePoints = [
    {
      title: "Focused Learning Environment",
      desc: "Small batches and caring mentors ensuring every child receives individualized attention and guidance.",
      icon: BookOpen,
      accent: "text-[#166534] bg-[#E8F3EA] border-[#2F7D4A]/20",
    },
    {
      title: "Smart Learning Classrooms",
      desc: "Audio-visual digital instruction that transforms abstract primary concepts into intuitive visual understanding.",
      icon: MonitorPlay,
      accent: "text-[#166534] bg-[#E8F3EA] border-[#2F7D4A]/20",
    },
    {
      title: "Student Safety Oversight",
      desc: "Campus corridors and key entry points secured with continuous CCTV monitoring for parent peace of mind.",
      icon: ShieldCheck,
      accent: "text-[#166534] bg-[#E8F3EA] border-[#2F7D4A]/20",
    },
    {
      title: "Holistic Development",
      desc: "Nurturing fundamental academic skills alongside moral character, discipline, empathy, and active curiosity.",
      icon: HeartHandshake,
      accent: "text-[#6B4226] bg-[#FAF8F2] border-[#EDE2D3]",
    },
  ];

  return (
    <div className="flex flex-col space-y-0">
      {/* 1. Hero Section - Deep Forest Green */}
      <Hero />

      {/* 2. Welcome Section - Light Cream (#FAF8F2) */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-10 items-center">
            <div className="lg:col-span-7 space-y-5">
              <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-full bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/25 text-xs font-bold uppercase tracking-wider">
                <Sparkles className="w-3.5 h-3.5 text-[#166534]" />
                <span>Welcome to Al-Qalam Public School</span>
              </div>
              <h2 className="text-2xl sm:text-3xl lg:text-4xl font-extrabold text-[#14532D] tracking-tight leading-snug">
                Nurturing Young Minds with Care, Discipline, and Modern Tools
              </h2>
              <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
                At Al-Qalam Public School, we believe the primary school years form the cornerstone of a child&apos;s lifelong intellectual and moral growth. Located in Gulzarbagh, Patna, our institution provides a warm, respectful, and disciplined environment where young learners feel safe to explore, question, and learn.
              </p>
              <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
                By pairing foundational literacy and numeracy with modern interactive Smart Classes, our mentors help children build lasting conceptual clarity while cultivating character and positive social habits.
              </p>

              <div className="pt-2 flex flex-wrap items-center gap-4 text-xs font-semibold text-stone-700">
                <span className="flex items-center gap-1.5 bg-white px-3 py-1.5 rounded-lg border border-stone-200">
                  <CheckCircle className="w-4 h-4 text-[#166534]" />
                  Child-Centric Mentorship
                </span>
                <span className="flex items-center gap-1.5 bg-white px-3 py-1.5 rounded-lg border border-stone-200">
                  <CheckCircle className="w-4 h-4 text-[#166534]" />
                  Smart Class Learning
                </span>
                <span className="flex items-center gap-1.5 bg-white px-3 py-1.5 rounded-lg border border-stone-200">
                  <CheckCircle className="w-4 h-4 text-[#166534]" />
                  CCTV Safety Monitored
                </span>
              </div>
            </div>

            <div className="lg:col-span-5 bg-gradient-to-br from-[#0d3b1f] to-[#14532D] rounded-3xl p-8 text-white shadow-md border border-[#2F7D4A]/40 flex flex-col justify-between space-y-6">
              <div className="space-y-3">
                <div className="w-12 h-12 rounded-xl bg-[#E8F3EA]/15 text-[#EDE2D3] flex items-center justify-center border border-[#EDE2D3]/20">
                  <Compass className="w-6 h-6" />
                </div>
                <h3 className="text-xl font-bold text-white tracking-tight">
                  Our Educational Commitment
                </h3>
                <p className="text-xs sm:text-sm text-[#EDE2D3] leading-relaxed">
                  Every child deserves an inspiring first step in schooling. We focus on concept clarity, regular practice, attentive care, and a secure environment so parents can trust their child&apos;s daily growth.
                </p>
              </div>

              <div className="pt-4 border-t border-[#2F7D4A]/40 flex items-center justify-between text-xs">
                <span className="text-[#EDE2D3] font-bold uppercase tracking-wider">
                  Patna, Bihar
                </span>
                <Link
                  href="/about"
                  className="text-white hover:text-[#EDE2D3] font-semibold flex items-center gap-1 transition"
                >
                  <span>Learn About Us</span>
                  <ArrowRight className="w-3.5 h-3.5" />
                </Link>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* 3. Why Choose Us - White */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <SectionHeading
            badge="Why Choose Us"
            title="A Balanced Environment for Early & Primary Learners"
            subtitle="Built on trusted fundamentals: focused attention, modern educational technology, and uncompromising safety."
            center
          />

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {whyChoosePoints.map((item, idx) => {
              const Icon = item.icon;
              return (
                <div
                  key={idx}
                  className="bg-[#FAF8F2] rounded-2xl p-6 border border-[#EDE2D3] shadow-xs hover:shadow-md transition-all duration-200 flex flex-col justify-between group"
                >
                  <div>
                    <div
                      className={`w-12 h-12 rounded-xl flex items-center justify-center border mb-5 transition-transform duration-200 group-hover:scale-105 ${item.accent}`}
                    >
                      <Icon className="w-6 h-6" />
                    </div>
                    <h3 className="text-lg font-bold text-[#14532D] mb-2 group-hover:text-[#166534] transition-colors">
                      {item.title}
                    </h3>
                    <p className="text-xs sm:text-sm text-stone-600 leading-relaxed">
                      {item.desc}
                    </p>
                  </div>

                  <div className="mt-6 pt-3 border-t border-[#EDE2D3] flex items-center text-xs font-semibold text-[#6B4226]">
                    <span>Priority Standard</span>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      {/* 4. Academic Stages - Very Light Green (#E8F3EA) */}
      <section className="py-16 sm:py-20 bg-[#E8F3EA] border-b border-[#2F7D4A]/20">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex flex-col md:flex-row md:items-end justify-between mb-12 gap-4">
            <div>
              <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-full bg-white text-[#14532D] border border-[#2F7D4A]/30 text-xs font-bold uppercase tracking-wider mb-3">
                <GraduationCap className="w-3.5 h-3.5 text-[#166534]" />
                <span>Academic Stages</span>
              </div>
              <h2 className="text-2xl sm:text-3xl lg:text-4xl font-extrabold text-[#14532D] tracking-tight">
                Structured Learning for Primary Grades
              </h2>
            </div>
            <Link
              href="/academics"
              className="inline-flex items-center gap-1.5 text-sm font-bold text-[#14532D] hover:text-[#166534] transition"
            >
              <span>Explore Academic Approach</span>
              <ArrowRight className="w-4 h-4 text-[#6B4226]" />
            </Link>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            {SCHOOL_DATA.academicStages.map((stage) => (
              <div
                key={stage.id}
                className="bg-white rounded-2xl p-6 sm:p-8 border border-stone-200 shadow-xs hover:shadow-md transition flex flex-col justify-between"
              >
                <div>
                  <div className="flex items-center justify-between mb-4">
                    <span className="px-3 py-1 rounded-full text-xs font-bold bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/30 shadow-xs">
                      {stage.grades}
                    </span>
                    <span className="text-xs font-semibold text-stone-400">Foundational Curriculum</span>
                  </div>
                  <h3 className="text-xl font-bold text-[#14532D] mb-2">
                    {stage.stageName}
                  </h3>
                  <p className="text-xs font-semibold text-[#6B4226] mb-3">
                    Focus: {stage.focus}
                  </p>
                  <p className="text-xs sm:text-sm text-stone-600 leading-relaxed mb-6">
                    {stage.description}
                  </p>

                  <div className="space-y-2 pt-2 border-t border-stone-100">
                    <p className="text-xs font-bold uppercase text-stone-400">Key Pillars</p>
                    <ul className="space-y-1.5">
                      {stage.highlights.map((h, i) => (
                        <li key={i} className="flex items-start gap-2 text-xs sm:text-sm text-stone-700">
                          <CheckCircle className="w-3.5 h-3.5 text-[#166534] mt-0.5 shrink-0" />
                          <span>{h}</span>
                        </li>
                      ))}
                    </ul>
                  </div>
                </div>

                <div className="mt-6 pt-4 border-t border-stone-100">
                  <Link
                    href="/admissions"
                    className="text-xs font-bold text-[#166534] hover:text-[#14532D] flex items-center gap-1"
                  >
                    <span>Enquire for {stage.stageName}</span>
                    <ArrowRight className="w-3.5 h-3.5 text-[#6B4226]" />
                  </Link>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* 5. Confirmed Facilities - White */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <SectionHeading
            badge="Confirmed Campus Facilities"
            title="Safety and Technology at the Heart of Learning"
            subtitle="Al-Qalam Public School is equipped with modern infrastructure designed to protect and inspire young learners."
            center
          />

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-5xl mx-auto">
            {SCHOOL_DATA.confirmedFacilities.map((facility) => (
              <FacilityCard key={facility.id} facility={facility} featured />
            ))}
          </div>

          <div className="mt-10 text-center">
            <Link
              href="/facilities"
              className="inline-flex items-center gap-2 px-6 py-3 rounded-xl font-bold text-sm text-[#14532D] bg-[#FAF8F2] border border-[#EDE2D3] hover:bg-white shadow-xs transition"
            >
              <span>View Facilities Overview</span>
              <ArrowRight className="w-4 h-4 text-[#6B4226]" />
            </Link>
          </div>
        </div>
      </section>

      {/* 6. Activities & Gallery Preview - Light Cream (#FAF8F2) */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex flex-col md:flex-row md:items-end justify-between mb-12 gap-4">
            <div>
              <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-full bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/25 text-xs font-bold uppercase tracking-wider mb-3">
                <Sparkles className="w-3.5 h-3.5 text-[#166534]" />
                <span>Life at Al-Qalam</span>
              </div>
              <h2 className="text-2xl sm:text-3xl lg:text-4xl font-extrabold text-[#14532D] tracking-tight">
                School Activities & Environment
              </h2>
            </div>
            <Link
              href="/gallery"
              className="inline-flex items-center gap-1.5 text-sm font-bold text-[#14532D] hover:text-[#166534] transition"
            >
              <span>View Full Gallery</span>
              <ArrowRight className="w-4 h-4 text-[#6B4226]" />
            </Link>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {SCHOOL_DATA.galleryItems.slice(0, 3).map((item) => (
              <div
                key={item.id}
                className="bg-white rounded-2xl border border-stone-200 overflow-hidden shadow-xs hover:shadow-md transition flex flex-col group"
              >
                <div className="h-44 bg-gradient-to-br from-[#0d3b1f] via-[#14532D] to-[#166534] flex flex-col items-center justify-center p-6 text-center text-white relative">
                  <div className="w-12 h-12 rounded-xl bg-white/15 flex items-center justify-center mb-2 border border-white/20">
                    <Image
                      src="/logo.png"
                      alt="Badge"
                      width={40}
                      height={40}
                      className="object-contain"
                    />
                  </div>
                  <span className="text-[11px] font-bold uppercase tracking-widest text-[#EDE2D3]">
                    {item.tag}
                  </span>
                  <h4 className="text-base font-bold text-white mt-1 leading-snug">
                    {item.title}
                  </h4>
                </div>
                <div className="p-5 flex-1 flex flex-col justify-between">
                  <p className="text-xs sm:text-sm text-stone-600">{item.description}</p>
                  <div className="mt-4 pt-3 border-t border-stone-100 flex items-center justify-between text-xs">
                    <span className="font-semibold text-stone-500">{item.category}</span>
                    <span className="text-[#6B4226] bg-[#FAF8F2] px-2 py-0.5 rounded text-[11px] font-medium border border-[#EDE2D3]">
                      Sample Preview
                    </span>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* 7. Notices Preview - White */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex flex-col md:flex-row md:items-end justify-between mb-12 gap-4">
            <div>
              <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-full bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/25 text-xs font-bold uppercase tracking-wider mb-3">
                <Calendar className="w-3.5 h-3.5 text-[#166534]" />
                <span>Notice Board</span>
              </div>
              <h2 className="text-2xl sm:text-3xl lg:text-4xl font-extrabold text-[#14532D] tracking-tight">
                Latest Announcements & Circulars
              </h2>
            </div>
            <Link
              href="/notices"
              className="inline-flex items-center gap-1.5 text-sm font-bold text-[#14532D] hover:text-[#166534] transition"
            >
              <span>View All Notices</span>
              <ArrowRight className="w-4 h-4 text-[#6B4226]" />
            </Link>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {SCHOOL_DATA.notices.slice(0, 2).map((notice) => (
              <NoticeCard key={notice.id} notice={notice} />
            ))}
          </div>
        </div>
      </section>

      {/* 8. Director's Section - Deep Forest Green */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <DirectorCard />
        </div>
      </section>

      {/* 9. Admission CTA Banner */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <CTA
          title="Admissions Open for Foundational & Primary Grades"
          subtitle="Give your child the gift of disciplined mentorship and modern learning at Al-Qalam Public School in Gulzarbagh, Patna."
          primaryBtnText="Submit Online Admission Enquiry"
          primaryBtnHref="/admissions"
        />
      </section>

      {/* 10. Location & Contact Section - Very Light Green (#E8F3EA) */}
      <section className="py-16 sm:py-20 bg-[#E8F3EA]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <SectionHeading
            badge="Contact & Visit"
            title="Visit Al-Qalam Public School"
            subtitle="Conveniently located on Ashok Rajpath Rd, Gulzarbagh, Alamganj, Patna."
            center
          />
          <ContactSection />
        </div>
      </section>
    </div>
  );
}
