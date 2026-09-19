import React from "react";
import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import {
  ShieldCheck,
  HeartHandshake,
  Compass,
  CheckCircle2,
  Sparkles,
  Target,
  Eye,
} from "lucide-react";
import SectionHeading from "@/components/SectionHeading";
import DirectorCard from "@/components/DirectorCard";
import CTA from "@/components/CTA";
import ScrollReveal from "@/components/ScrollReveal";
import { SCHOOL_DATA } from "@/data/schoolData";
import { schoolImages } from "@/data/schoolImages";

export const metadata: Metadata = {
  title: "About Us",
  description:
    "Learn about Al-Qalam Public School in Gulzarbagh, Patna. Our philosophy, foundational educational vision, leadership by Director Rahat Jahan, and core values.",
};

export default function AboutPage() {
  const coreValues = [
    {
      title: "Moral Discipline & Respect",
      desc: "Instilling mutual respect, good manners, and disciplined daily habits right from early childhood.",
      icon: ShieldCheck,
      color: "text-[#166534] bg-[#E8F3EA] border-[#2F7D4A]/25",
    },
    {
      title: "Child Safety & Well-being",
      desc: "Providing a secure, supervised environment backed by 24x7 CCTV monitoring across campus premises.",
      icon: HeartHandshake,
      color: "text-[#166534] bg-[#E8F3EA] border-[#2F7D4A]/25",
    },
    {
      title: "Active Curiosity & Inquiry",
      desc: "Encouraging young learners to ask questions, observe their surroundings, and develop a genuine love for reading.",
      icon: Compass,
      color: "text-[#6B4226] bg-[#FAF8F2] border-[#EDE2D3]",
    },
    {
      title: "Modern Foundational Learning",
      desc: "Utilizing interactive Smart Classes to ensure strong fundamentals in languages, arithmetic, and sciences.",
      icon: Sparkles,
      color: "text-[#166534] bg-[#E8F3EA] border-[#2F7D4A]/25",
    },
  ];

  return (
    <div className="bg-white overflow-x-hidden">
      {/* Page Header Banner */}
      <section className="bg-forest-hero text-white py-16 sm:py-20 border-b border-[#0d3b1f]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <ScrollReveal variant="scale-in">
            <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#0d3b1f]/60 border border-[#2F7D4A]/40 text-[#EDE2D3] text-xs font-bold uppercase tracking-wider mb-4">
              <span className="w-1.5 h-1.5 rounded-full bg-[#E8F3EA]" />
              <span>Institutional Philosophy</span>
            </div>
            <h1 className="text-3xl sm:text-4xl lg:text-5xl font-black tracking-tight text-white">
              About Al-Qalam Public School
            </h1>
            <p className="mt-3 text-base sm:text-lg text-[#EDE2D3] max-w-2xl mx-auto italic font-medium">
              &ldquo;{SCHOOL_DATA.tagline}&rdquo;
            </p>
            <p className="mt-1 text-xs text-[#FAF8F2] font-serif">
              {SCHOOL_DATA.mottoArabic} • {SCHOOL_DATA.mottoTranslation}
            </p>
          </ScrollReveal>
        </div>
      </section>

      {/* Main Introduction Grid */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">
            <ScrollReveal variant="fade-right" className="lg:col-span-7 space-y-5">
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/25 text-xs font-bold uppercase tracking-wider">
                <Compass className="w-3.5 h-3.5 text-[#166534]" />
                <span>Our Heritage of Learning</span>
              </div>
              <h2 className="text-2xl sm:text-3xl lg:text-4xl font-black text-[#14532D] tracking-tight leading-tight">
                Shaping Young Minds for a Meaningful Future
              </h2>
              <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
                Al-Qalam Public School is an esteemed primary school located at Ashok Rajpath Road in Gulzarbagh, Alamganj, Patna. Founded with the conviction that education begins with compassion, character, and curiosity, we provide children with a strong, joyful foundation for their scholastic journey.
              </p>
              <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
                The name <em>Al-Qalam</em> (&ldquo;The Pen&rdquo;) reflects our veneration for knowledge, literacy, and thoughtful reflection. In an era of rapid technological transformation, we blend traditional values of respect and diligence with modern teaching methodologies like audio-visual Smart Classes.
              </p>

              <div className="bg-[#FAF8F2] border-l-4 border-[#166534] p-4 rounded-r-xl border-y border-r border-[#EDE2D3]">
                <p className="text-sm font-semibold text-[#14532D]">
                  Campus Location:
                </p>
                <p className="text-xs text-stone-600 mt-0.5">
                  Opposite Jashn Palace Marriage Hall, Agarwal Tola, Loharwa Ghat, Ashok Rajpath Rd, Gulzarbagh, Alamganj, Patna, Bihar 800007.
                </p>
              </div>
            </ScrollReveal>

            <ScrollReveal variant="fade-left" className="lg:col-span-5 flex justify-center">
              <div className="card-interactive relative w-full max-w-sm rounded-3xl bg-gradient-to-br from-[#0d3b1f] via-[#14532D] to-[#166534] p-6 sm:p-8 text-white shadow-lg border border-[#2F7D4A]/40 text-center space-y-6">
                {/* Classroom Sample Photo with Zoom */}
                <div className="img-zoom-parent relative h-40 w-full rounded-2xl overflow-hidden bg-stone-900 border border-white/20">
                  <Image
                    src={schoolImages.about.src}
                    alt={schoolImages.about.alt}
                    fill
                    sizes="(max-width: 640px) 100vw, 380px"
                    className="img-zoom-child object-cover object-center"
                  />
                  <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent" />
                  <div className="absolute bottom-2 left-2 right-2 text-center">
                    <span className="text-[11px] font-bold text-white bg-black/60 px-2 py-0.5 rounded backdrop-blur-xs">
                      Al-Qalam Classroom Atmosphere
                    </span>
                  </div>
                </div>

                <div className="w-24 h-24 mx-auto rounded-full bg-white p-1.5 shadow-md ring-4 ring-[#EDE2D3]/40">
                  <Image
                    src={schoolImages.branding.primarySvg}
                    alt="Al-Qalam Emblem"
                    width={90}
                    height={90}
                    className="w-full h-full object-contain"
                  />
                </div>
                <div>
                  <h3 className="text-xl font-bold text-white tracking-tight">
                    {SCHOOL_DATA.name}
                  </h3>
                  <p className="text-xs text-[#EDE2D3] font-semibold uppercase tracking-wider mt-1">
                    Patna, Bihar
                  </p>
                </div>
                <div className="pt-4 border-t border-[#2F7D4A]/40 text-xs text-[#EDE2D3] space-y-2 text-left">
                  <p>• Foundational & Primary Education</p>
                  <p>• Smart Classroom Technology</p>
                  <p>• Comprehensive CCTV Campus Security</p>
                </div>
              </div>
            </ScrollReveal>
          </div>
        </div>
      </section>

      {/* Vision & Mission Cards - Light Cream (#FAF8F2) */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
            <SectionHeading
              badge="Guiding Principles"
              title="Vision & Mission"
              subtitle="Guiding our daily mentorship to ensure every child thrives in a secure and supportive school environment."
              center
            />
          </ScrollReveal>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-5xl mx-auto">
            {/* Vision */}
            <ScrollReveal variant="fade-right">
              <div className="card-interactive bg-white rounded-3xl p-8 border border-stone-200 shadow-xs flex flex-col justify-between h-full">
                <div>
                  <div className="w-12 h-12 rounded-xl flex items-center justify-center bg-[#E8F3EA] text-[#166534] border border-[#2F7D4A]/20 mb-5">
                    <Eye className="w-6 h-6" />
                  </div>
                  <h3 className="text-2xl font-bold text-[#14532D] tracking-tight mb-3">
                    Our Vision
                  </h3>
                  <p className="text-stone-600 text-sm leading-relaxed mb-4">
                    To be a respected center of primary educational excellence where children develop deep academic foundations, moral discipline, and intellectual confidence, preparing them to excel in higher schooling and community life.
                  </p>
                </div>
                <div className="pt-4 border-t border-stone-100 flex items-center gap-2 text-xs font-bold text-[#14532D]">
                  <CheckCircle2 className="w-4 h-4 text-[#166534]" />
                  <span>Foundational Clarity & Moral Uprightness</span>
                </div>
              </div>
            </ScrollReveal>

            {/* Mission */}
            <ScrollReveal variant="fade-left">
              <div className="card-interactive bg-white rounded-3xl p-8 border border-stone-200 shadow-xs flex flex-col justify-between h-full">
                <div>
                  <div className="w-12 h-12 rounded-xl flex items-center justify-center bg-[#FAF8F2] text-[#6B4226] border border-[#EDE2D3] mb-5">
                    <Target className="w-6 h-6" />
                  </div>
                  <h3 className="text-2xl font-bold text-[#14532D] tracking-tight mb-3">
                    Our Mission
                  </h3>
                  <p className="text-stone-600 text-sm leading-relaxed mb-4">
                    To deliver dedicated, individualized mentorship in small batches; to utilize interactive Smart Class audio-visual tools; and to ensure an impeccably safe learning environment monitored by CCTV surveillance across the campus.
                  </p>
                </div>
                <div className="pt-4 border-t border-stone-100 flex items-center gap-2 text-xs font-bold text-[#6B4226]">
                  <CheckCircle2 className="w-4 h-4 text-[#6B4226]" />
                  <span>Smart Classrooms & Monitored Campus Safety</span>
                </div>
              </div>
            </ScrollReveal>
          </div>
        </div>
      </section>

      {/* Core Values Grid - White */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
            <SectionHeading
              badge="Character & Culture"
              title="Our Four Pillars of Character"
              subtitle="The values we cultivate every single day across classrooms, hallways, and morning assemblies."
              center
            />
          </ScrollReveal>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {coreValues.map((val, idx) => {
              const IconComp = val.icon;
              return (
                <ScrollReveal key={idx} variant="fade-up" delay={idx * 80}>
                  <div className="card-interactive p-6 rounded-2xl bg-white border border-stone-200 shadow-xs flex flex-col justify-between h-full group">
                    <div>
                      <div
                        className={`w-12 h-12 rounded-xl flex items-center justify-center mb-4 border transition-transform duration-300 group-hover:scale-105 ${val.color}`}
                      >
                        <IconComp className="w-6 h-6" />
                      </div>
                      <h4 className="text-lg font-bold text-[#14532D] tracking-tight mb-2 group-hover:text-[#166534] transition-colors">
                        {val.title}
                      </h4>
                      <p className="text-xs sm:text-sm text-stone-600 leading-relaxed">
                        {val.desc}
                      </p>
                    </div>
                  </div>
                </ScrollReveal>
              );
            })}
          </div>
        </div>
      </section>

      {/* Director Card Feature Section - Light Cream (#FAF8F2) */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <ScrollReveal variant="fade-up">
            <DirectorCard />
          </ScrollReveal>
        </div>
      </section>

      {/* Admission Call to Action */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <ScrollReveal variant="scale-in">
          <CTA
            title="Begin Your Child's Journey at Al-Qalam Public School"
            subtitle="Admissions enquiries are welcomed for foundational and primary classes. Visit our Gulzarbagh campus or submit your online enquiry today."
            primaryBtnText="Submit Admission Enquiry"
            primaryBtnHref="/admissions"
          />
        </ScrollReveal>
      </section>
    </div>
  );
}
