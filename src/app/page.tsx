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
import ScrollReveal from "@/components/ScrollReveal";
import { SCHOOL_DATA } from "@/data/schoolData";
import { schoolImages } from "@/data/schoolImages";

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
    <div className="flex flex-col space-y-0 overflow-x-hidden">
      {/* 1. Hero Section - Deep Forest Green with Ken Burns & Entrance Sequence */}
      <Hero />

      {/* 2. Welcome Section - Light Cream (#FAF8F2) */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-10 items-center">
            <ScrollReveal variant="fade-right" className="lg:col-span-7 space-y-5">
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
                <span className="flex items-center gap-1.5 bg-white px-3 py-1.5 rounded-lg border border-stone-200 shadow-2xs">
                  <CheckCircle className="w-4 h-4 text-[#166534]" />
                  Child-Centric Mentorship
                </span>
                <span className="flex items-center gap-1.5 bg-white px-3 py-1.5 rounded-lg border border-stone-200 shadow-2xs">
                  <CheckCircle className="w-4 h-4 text-[#166534]" />
                  Smart Class Learning
                </span>
                <span className="flex items-center gap-1.5 bg-white px-3 py-1.5 rounded-lg border border-stone-200 shadow-2xs">
                  <CheckCircle className="w-4 h-4 text-[#166534]" />
                  CCTV Safety Monitored
                </span>
              </div>
            </ScrollReveal>

            <ScrollReveal variant="fade-left" className="lg:col-span-5">
              <div className="card-interactive bg-gradient-to-br from-[#0d3b1f] to-[#14532D] rounded-3xl p-6 sm:p-8 text-white shadow-md border border-[#2F7D4A]/40 flex flex-col justify-between space-y-6">
                {/* Classroom Sample Photo with Subtle Zoom */}
                <div className="img-zoom-parent relative h-48 sm:h-52 w-full rounded-2xl overflow-hidden bg-stone-900 border border-white/20">
                  <Image
                    src={schoolImages.about.src}
                    alt={schoolImages.about.alt}
                    fill
                    sizes="(max-width: 1024px) 100vw, 40vw"
                    className="img-zoom-child object-cover object-center"
                  />
                  <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent" />
                  <div className="absolute bottom-3 left-3 right-3 flex items-center justify-between text-xs">
                    <span className="font-bold text-[#EDE2D3] bg-black/50 px-2.5 py-1 rounded-md backdrop-blur-xs">
                      Classroom Environment
                    </span>
                    <span className="text-stone-300 text-[11px]">Gulzarbagh, Patna</span>
                  </div>
                </div>

                <div className="space-y-3">
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 rounded-xl bg-[#E8F3EA]/15 text-[#EDE2D3] flex items-center justify-center border border-[#EDE2D3]/20">
                      <Compass className="w-5 h-5" />
                    </div>
                    <h3 className="text-lg font-bold text-white tracking-tight">
                      Our Educational Commitment
                    </h3>
                  </div>
                  <p className="text-xs sm:text-sm text-[#EDE2D3] leading-relaxed">
                    Every child deserves an inspiring first step in schooling. We focus on concept clarity, regular practice, attentive care, and a secure environment so parents can trust their child&apos;s daily growth.
                  </p>
                </div>

                <div className="pt-3 border-t border-[#2F7D4A]/40 flex items-center justify-between text-xs">
                  <span className="text-[#EDE2D3] font-bold uppercase tracking-wider">
                    Patna, Bihar
                  </span>
                  <Link
                    href="/about"
                    className="text-white hover:text-[#EDE2D3] font-semibold flex items-center gap-1.5 transition group"
                  >
                    <span>Learn About Us</span>
                    <ArrowRight className="w-3.5 h-3.5 group-hover:translate-x-1 transition-transform" />
                  </Link>
                </div>
              </div>
            </ScrollReveal>
          </div>
        </div>
      </section>

      {/* 3. Why Choose Al-Qalam - White */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
            <SectionHeading
              badge="Our Strengths"
              title="Why Choose Al-Qalam Public School?"
              subtitle="Cultivating foundational clarity, moral values, and modern smart learning right in Gulzarbagh, Patna."
              center
            />
          </ScrollReveal>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {whyChoosePoints.map((item, index) => {
              const IconComp = item.icon;
              return (
                <ScrollReveal key={index} variant="fade-up" delay={index * 90}>
                  <div className="card-interactive p-6 rounded-2xl bg-white border border-stone-200 shadow-xs flex flex-col justify-between h-full group">
                    <div>
                      <div
                        className={`w-12 h-12 rounded-xl flex items-center justify-center mb-4 border transition-transform duration-300 group-hover:scale-105 ${item.accent}`}
                      >
                        <IconComp className="w-6 h-6" />
                      </div>
                      <h3 className="text-lg font-bold text-[#14532D] tracking-tight mb-2 group-hover:text-[#166534] transition-colors">
                        {item.title}
                      </h3>
                      <p className="text-xs sm:text-sm text-stone-600 leading-relaxed">
                        {item.desc}
                      </p>
                    </div>
                    <div className="mt-4 pt-3 border-t border-stone-100 flex items-center gap-1 text-[11px] font-bold text-[#6B4226] uppercase tracking-wider">
                      <span>Primary Excellence</span>
                    </div>
                  </div>
                </ScrollReveal>
              );
            })}
          </div>
        </div>
      </section>

      {/* 4. Academic Structure Preview - Light Cream (#FAF8F2) */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
            <div className="flex flex-col md:flex-row md:items-end justify-between mb-12 gap-4">
              <div>
                <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-full bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/25 text-xs font-bold uppercase tracking-wider mb-3">
                  <GraduationCap className="w-3.5 h-3.5 text-[#166534]" />
                  <span>Academic Pathways</span>
                </div>
                <h2 className="text-2xl sm:text-3xl lg:text-4xl font-extrabold text-[#14532D] tracking-tight">
                  Foundational & Primary Curriculum
                </h2>
              </div>
              <Link
                href="/academics"
                className="btn-interactive inline-flex items-center gap-1.5 text-sm font-bold text-[#14532D] hover:text-[#166534] transition"
              >
                <span>View Full Curriculum</span>
                <ArrowRight className="btn-icon-nudge w-4 h-4 text-[#6B4226]" />
              </Link>
            </div>
          </ScrollReveal>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            {SCHOOL_DATA.academicStages.map((stage, idx) => (
              <ScrollReveal key={stage.id} variant={idx === 0 ? "fade-right" : "fade-left"} delay={idx * 120}>
                <div className="card-interactive bg-white rounded-3xl p-6 sm:p-8 border border-stone-200 shadow-xs flex flex-col justify-between h-full">
                  <div>
                    <div className="flex items-center justify-between mb-4">
                      <span className="px-3 py-1 rounded-full text-xs font-bold uppercase bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/20">
                        {stage.grades}
                      </span>
                      <span className="text-xs font-semibold text-[#6B4226] bg-[#FAF8F2] px-2.5 py-1 rounded-md border border-[#EDE2D3]">
                        {stage.focus}
                      </span>
                    </div>

                    <h3 className="text-xl sm:text-2xl font-bold text-[#14532D] tracking-tight mb-2">
                      {stage.stageName}
                    </h3>

                    <p className="text-stone-600 text-sm leading-relaxed mb-6">
                      {stage.description}
                    </p>

                    <div className="space-y-2 border-t border-stone-100 pt-4">
                      <p className="text-xs font-bold uppercase tracking-wider text-[#6B4226]">
                        Curriculum Highlights:
                      </p>
                      <ul className="grid grid-cols-1 sm:grid-cols-2 gap-2 text-xs text-stone-700">
                        {stage.highlights.map((h, i) => (
                          <li key={i} className="flex items-center gap-2">
                            <span className="w-1.5 h-1.5 rounded-full bg-[#166534]" />
                            <span>{h}</span>
                          </li>
                        ))}
                      </ul>
                    </div>
                  </div>

                  <div className="mt-6 pt-4 border-t border-stone-100 flex items-center justify-between">
                    <span className="text-xs font-semibold text-stone-500">Patna, Bihar</span>
                    <Link
                      href="/academics"
                      className="text-xs font-bold text-[#14532D] hover:underline flex items-center gap-1"
                    >
                      <span>Explore Stage</span>
                      <span>→</span>
                    </Link>
                  </div>
                </div>
              </ScrollReveal>
            ))}
          </div>
        </div>
      </section>

      {/* 5. Confirmed Facilities - White */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
            <SectionHeading
              badge="Confirmed Campus Facilities"
              title="Safety and Technology at the Heart of Learning"
              subtitle="Al-Qalam Public School is equipped with modern infrastructure designed to protect and inspire young learners."
              center
            />
          </ScrollReveal>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-5xl mx-auto">
            {SCHOOL_DATA.confirmedFacilities.map((facility, idx) => (
              <ScrollReveal key={facility.id} variant={idx === 0 ? "fade-right" : "fade-left"} delay={idx * 120}>
                <FacilityCard facility={facility} featured />
              </ScrollReveal>
            ))}
          </div>

          <div className="mt-10 text-center">
            <Link
              href="/facilities"
              className="btn-interactive inline-flex items-center gap-2 px-6 py-3 rounded-xl font-bold text-sm text-[#14532D] bg-[#FAF8F2] border border-[#EDE2D3] hover:bg-white shadow-xs"
            >
              <span>View Facilities Overview</span>
              <ArrowRight className="btn-icon-nudge w-4 h-4 text-[#6B4226]" />
            </Link>
          </div>
        </div>
      </section>

      {/* 6. Activities & Gallery Preview - Light Cream (#FAF8F2) */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
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
                className="btn-interactive inline-flex items-center gap-1.5 text-sm font-bold text-[#14532D] hover:text-[#166534] transition"
              >
                <span>View Full Gallery</span>
                <ArrowRight className="btn-icon-nudge w-4 h-4 text-[#6B4226]" />
              </Link>
            </div>
          </ScrollReveal>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {schoolImages.gallery.slice(0, 3).map((item, idx) => (
              <ScrollReveal key={item.id} variant="fade-up" delay={idx * 100}>
                <Link
                  href="/gallery"
                  className="card-interactive bg-white rounded-2xl border border-stone-200 overflow-hidden shadow-xs flex flex-col group block"
                >
                  {/* Photo Thumbnail with Smooth Zoom */}
                  <div className="img-zoom-parent relative h-52 w-full bg-stone-900">
                    <Image
                      src={item.src}
                      alt={item.title}
                      fill
                      sizes="(max-width: 640px) 100vw, (max-width: 1024px) 50vw, 33vw"
                      className="img-zoom-child object-cover object-center"
                    />
                    <div className="absolute inset-0 bg-gradient-to-t from-black/75 via-black/20 to-transparent" />
                    
                    <div className="absolute top-3 right-3 z-10">
                      <span className="text-[11px] font-bold uppercase tracking-widest text-[#6B4226] bg-[#FAF8F2]/95 px-2.5 py-0.5 rounded-full border border-[#EDE2D3] shadow-xs backdrop-blur-xs">
                        {item.tag}
                      </span>
                    </div>

                    <div className="absolute bottom-3 left-3 right-3 z-10">
                      <h4 className="text-base font-bold text-white leading-snug drop-shadow-sm group-hover:text-[#EDE2D3] transition-colors">
                        {item.title}
                      </h4>
                    </div>
                  </div>

                  <div className="p-5 flex-1 flex flex-col justify-between">
                    <p className="text-xs sm:text-sm text-stone-600 line-clamp-2">{item.description}</p>
                    <div className="mt-4 pt-3 border-t border-stone-100 flex items-center justify-between text-xs">
                      <span className="font-semibold text-stone-500">{item.category}</span>
                      <span className="text-[#14532D] font-bold flex items-center gap-1 group-hover:translate-x-1 transition-transform">
                        <span>Enlarge</span>
                        <span>→</span>
                      </span>
                    </div>
                  </div>
                </Link>
              </ScrollReveal>
            ))}
          </div>
        </div>
      </section>

      {/* 7. Notices Preview - White */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
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
                className="btn-interactive inline-flex items-center gap-1.5 text-sm font-bold text-[#14532D] hover:text-[#166534] transition"
              >
                <span>View All Notices</span>
                <ArrowRight className="btn-icon-nudge w-4 h-4 text-[#6B4226]" />
              </Link>
            </div>
          </ScrollReveal>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {SCHOOL_DATA.notices.slice(0, 2).map((notice, idx) => (
              <ScrollReveal key={notice.id} variant={idx === 0 ? "fade-right" : "fade-left"} delay={idx * 100}>
                <NoticeCard notice={notice} />
              </ScrollReveal>
            ))}
          </div>
        </div>
      </section>

      {/* 8. Director's Section - Deep Forest Green */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
            <DirectorCard />
          </ScrollReveal>
        </div>
      </section>

      {/* 9. Admission CTA Banner */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <ScrollReveal variant="scale-in">
          <CTA
            title="Admissions Open for Foundational & Primary Grades"
            subtitle="Give your child the gift of disciplined mentorship and modern learning at Al-Qalam Public School in Gulzarbagh, Patna."
            primaryBtnText="Submit Online Admission Enquiry"
            primaryBtnHref="/admissions"
          />
        </ScrollReveal>
      </section>

      {/* 10. Location & Contact Section - Very Light Green (#E8F3EA) */}
      <section className="py-16 sm:py-20 bg-[#E8F3EA]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
            <SectionHeading
              badge="Contact & Visit"
              title="Visit Al-Qalam Public School"
              subtitle="Conveniently located on Ashok Rajpath Rd, Gulzarbagh, Alamganj, Patna."
              center
            />
          </ScrollReveal>
          <ScrollReveal variant="fade-up" delay={150}>
            <ContactSection />
          </ScrollReveal>
        </div>
      </section>
    </div>
  );
}
