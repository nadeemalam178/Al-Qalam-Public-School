import React from "react";
import Image from "next/image";
import Link from "next/link";
import { ArrowRight, CheckCircle2 } from "lucide-react";
import { schoolImages } from "@/data/schoolImages";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function SchoolStory() {
  const highlights = [
    "Foundational literacy and arithmetic taught with structured daily practice",
    "Character building, respect, and discipline instilled from early years",
    "Attentive teacher guidance and supportive classroom atmosphere",
    "Interactive Smart Classes that illustrate concepts clearly",
    "Secure campus environment supported by monitored CCTV coverage",
  ];

  return (
    <section id="school-story" className="py-16 sm:py-20 lg:py-24 bg-white border-b border-[#E7E5E4]">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 lg:gap-16 items-center">
          {/* Left: Editorial School Narrative */}
          <div className="lg:col-span-7 space-y-6">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-md bg-[#FAF8F2] border border-[#EDE2D3] text-[#6B4226] text-xs font-semibold uppercase tracking-wider">
              <span>Our School Story</span>
            </div>

            <h2 className="font-heading font-black text-2xl sm:text-3xl lg:text-4xl text-[#14532D] tracking-tight leading-tight">
              A Strong Beginning for Every Child
            </h2>

            <div className="space-y-4 text-stone-700 text-sm sm:text-base leading-relaxed">
              <p>
                At Al-Qalam Public School, we understand that early education shapes how a child thinks, behaves, and learns for a lifetime. Situated in the historic locality of Gulzarbagh, Patna, our institution offers a structured yet caring school environment where foundational learning is treated with the seriousness it deserves.
              </p>
              <p>
                Academic discipline and good manners are nurtured side by side. Children develop strong reading habits, clear handwriting, and numerical confidence through patient instruction from committed educators. By pairing traditional classroom attentiveness with modern audio-visual Smart Classes, lessons become engaging and intuitive rather than burdensome.
              </p>
              <p>
                Above all, our campus prioritizes safety and peace of mind. With monitored CCTV cameras across corridors and main entrance gates, parents can trust that their children are learning in a secure, orderly, and respectful environment every single day.
              </p>
            </div>

            {/* Editorial Feature Highlights */}
            <div className="pt-2 border-t border-stone-200">
              <ul className="space-y-2.5">
                {highlights.map((point, index) => (
                  <li key={index} className="flex items-start gap-2.5 text-xs sm:text-sm text-stone-800">
                    <CheckCircle2 className="w-4 h-4 text-[#166534] shrink-0 mt-0.5" />
                    <span>{point}</span>
                  </li>
                ))}
              </ul>
            </div>

            <div className="pt-2">
              <Link
                href="/about"
                className="inline-flex items-center gap-2 text-sm font-bold text-[#14532D] hover:text-[#0B3B20] transition-colors group"
              >
                <span>Read More About Our Educational Philosophy</span>
                <ArrowRight className="w-4 h-4 text-[#6B4226] group-hover:translate-x-1 transition-transform" />
              </Link>
            </div>
          </div>

          {/* Right: Real Photograph with Editorial Frame */}
          <div className="lg:col-span-5">
            <div className="relative">
              {/* Main Photo: Real Drawing Competition / School Life */}
              <div className="relative rounded-2xl overflow-hidden border border-[#EDE2D3] shadow-md bg-stone-900 aspect-[4/3]">
                <Image
                  src={schoolImages.drawingCompetition.src}
                  alt={schoolImages.drawingCompetition.alt}
                  fill
                  sizes="(max-width: 1024px) 100vw, 40vw"
                  className="object-cover object-center"
                />
                <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-transparent to-transparent pointer-events-none" />

                <div className="absolute bottom-3 left-3 right-3 text-white text-xs">
                  <p className="font-semibold text-[#FAF8F2] text-sm drop-shadow-xs">
                    Annual Drawing Competition
                  </p>
                  <p className="text-stone-300 text-[11px] mt-0.5">
                    Al-Qalam students presenting their creative artwork in school
                  </p>
                </div>
              </div>

              {/* Editorial Caption Box */}
              <div className="mt-4 p-4 rounded-xl bg-[#FAF8F2] border border-[#EDE2D3] text-xs text-stone-600 leading-relaxed">
                <p className="font-semibold text-[#14532D] mb-1">
                  Balanced Development in Practice
                </p>
                <p>
                  Regular school co-curricular events like drawing exhibitions, field excursions, and merit recognition instill confidence and team spirit in our primary students.
                </p>
                <p className="mt-2 text-[11px] text-[#6B4226] font-medium">
                  Al-Qalam Public School • {SCHOOL_DATA.address.city}, {SCHOOL_DATA.address.state}
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
