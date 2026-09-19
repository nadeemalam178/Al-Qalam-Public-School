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
import { SCHOOL_DATA } from "@/data/schoolData";

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
    <div className="bg-white">
      {/* Page Header Banner */}
      <section className="bg-forest-hero text-white py-16 sm:py-20 border-b border-[#0d3b1f]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
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
        </div>
      </section>

      {/* Main Introduction Grid */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">
            <div className="lg:col-span-7 space-y-6">
              <div className="inline-flex items-center gap-2 px-3.5 py-1 rounded-full bg-[#E8F3EA] text-[#14532D] border border-[#2F7D4A]/25 text-xs font-bold uppercase tracking-wider">
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
            </div>

            <div className="lg:col-span-5 flex justify-center">
              <div className="relative w-full max-w-sm rounded-3xl bg-gradient-to-br from-[#0d3b1f] via-[#14532D] to-[#166534] p-8 text-white shadow-lg border border-[#2F7D4A]/40 text-center space-y-6">
                <div className="w-36 h-36 mx-auto rounded-full bg-white p-2 shadow-md ring-4 ring-[#EDE2D3]/40">
                  <Image
                    src="/branding/al-qalam-logo.svg"
                    alt="Al-Qalam Emblem"
                    width={140}
                    height={140}
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
                <div className="pt-4 border-t border-[#2F7D4A]/40 text-xs text-[#EDE2D3] space-y-2">
                  <p>• Foundational & Primary Education</p>
                  <p>• Smart Classroom Technology</p>
                  <p>• Comprehensive CCTV Campus Security</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Vision & Mission Cards - Light Cream (#FAF8F2) */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <SectionHeading
            badge="Guiding Principles"
            title="Vision & Mission"
            subtitle="Guiding our daily mentorship to ensure every child thrives in a secure and supportive school environment."
            center
          />

          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-5xl mx-auto">
            {/* Vision */}
            <div className="bg-white rounded-3xl p-8 border border-stone-200 shadow-xs flex flex-col justify-between">
              <div>
                <div className="w-12 h-12 rounded-xl bg-[#E8F3EA] text-[#166534] flex items-center justify-center mb-5 border border-[#2F7D4A]/20">
                  <Eye className="w-6 h-6" />
                </div>
                <h3 className="text-xl font-bold text-[#14532D] mb-3">Our Vision</h3>
                <p className="text-sm text-stone-600 leading-relaxed">
                  To be a premier primary learning institution recognized for cultivating foundational literacy, intellectual curiosity, and grounded moral values in young learners, preparing them confidently for advanced academic pursuits.
                </p>
              </div>
              <div className="mt-6 pt-4 border-t border-stone-100 text-xs font-semibold text-[#6B4226]">
                Al-Qalam Public School Vision
              </div>
            </div>

            {/* Mission */}
            <div className="bg-white rounded-3xl p-8 border border-stone-200 shadow-xs flex flex-col justify-between">
              <div>
                <div className="w-12 h-12 rounded-xl bg-[#E8F3EA] text-[#166534] flex items-center justify-center mb-5 border border-[#2F7D4A]/20">
                  <Target className="w-6 h-6" />
                </div>
                <h3 className="text-xl font-bold text-[#14532D] mb-3">Our Mission</h3>
                <p className="text-sm text-stone-600 leading-relaxed">
                  To provide a safe, disciplined, and nurturing educational sanctuary where qualified mentors employ concept-based and technology-supported instruction (Smart Classes) while prioritizing student well-being, character building, and individual attention.
                </p>
              </div>
              <div className="mt-6 pt-4 border-t border-stone-100 text-xs font-semibold text-[#14532D]">
                Al-Qalam Public School Mission
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Core Values Section - White */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <SectionHeading
            badge="Pillars of Excellence"
            title="Our Core Values"
            subtitle="The enduring principles that define the atmosphere of Al-Qalam Public School."
            center
          />

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {coreValues.map((val, i) => {
              const Icon = val.icon;
              return (
                <div
                  key={i}
                  className="bg-[#FAF8F2] rounded-2xl p-6 border border-[#EDE2D3] shadow-xs hover:shadow-md transition"
                >
                  <div
                    className={`w-12 h-12 rounded-xl flex items-center justify-center border mb-4 ${val.color}`}
                  >
                    <Icon className="w-6 h-6" />
                  </div>
                  <h4 className="text-base font-bold text-[#14532D] mb-2">{val.title}</h4>
                  <p className="text-xs sm:text-sm text-stone-600 leading-relaxed">{val.desc}</p>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      {/* Director's Desk Section */}
      <section className="py-16 sm:py-20 bg-[#FAF8F2] border-b border-[#EDE2D3]">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <DirectorCard />
        </div>
      </section>

      {/* Admission CTA */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <CTA
          title="Join Our School Community in Patna"
          subtitle="Explore admissions for your child or visit our campus desk at Ashok Rajpath Rd, Gulzarbagh."
        />
      </section>
    </div>
  );
}
