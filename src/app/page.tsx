import React from "react";
import Link from "next/link";
import { ArrowRight, Calendar, Sparkles, MapPin } from "lucide-react";
import Hero from "@/components/Hero";
import AnnouncementMarquee from "@/components/AnnouncementMarquee";
import SchoolStory from "@/components/SchoolStory";
import WhyAlQalam from "@/components/WhyAlQalam";
import AcademicsSection from "@/components/AcademicsSection";
import FacilitiesSection from "@/components/FacilitiesSection";
import GalleryGrid from "@/components/GalleryGrid";
import SchoolLifeEvents from "@/components/SchoolLifeEvents";
import DirectorCard from "@/components/DirectorCard";
import ParentTestimonials from "@/components/ParentTestimonials";
import FAQSection from "@/components/FAQSection";
import ApkDownloadSection from "@/components/ApkDownloadSection";
import AdmissionForm from "@/components/AdmissionForm";
import AdmissionCalculator from "@/components/AdmissionCalculator";
import ContactSection from "@/components/ContactSection";
import NoticeCard from "@/components/NoticeCard";
import TrustStatsGrid from "@/components/TrustStatsGrid";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function HomePage() {
  return (
    <div className="flex flex-col space-y-0 overflow-x-hidden">
      {/* 1. Hero Section */}
      <Hero />

      {/* Dynamic Announcement & Verification Ticker */}
      <AnnouncementMarquee />

      {/* 1.1 Institutional Trust & Key Metrics Grid */}
      <TrustStatsGrid />

      {/* 2. School Story / Introduction (Editorial layout) */}
      <SchoolStory />

      {/* 3. Why Al-Qalam (4 concise principles) */}
      <WhyAlQalam />

      {/* 4. Academics (Two-column editorial pathways) */}
      <AcademicsSection />

      {/* 5. Facilities (Safe, Technology-Enabled Learning) */}
      <FacilitiesSection />

      {/* 6. School Life & Visual Gallery */}
      <section className="py-16 sm:py-20 lg:py-24 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex flex-col md:flex-row md:items-end justify-between gap-4 mb-12 sm:mb-14">
            <div className="space-y-3">
              <div className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-md bg-[#E8F3EA] text-[#14532D] text-xs font-bold uppercase tracking-wider">
                <Sparkles className="w-3.5 h-3.5 text-[#14532D]" />
                <span>School Life</span>
              </div>
              <h2 className="font-heading font-bold text-2xl sm:text-3xl lg:text-4xl text-stone-900 tracking-tight">
                Moments &amp; Activities at Al-Qalam
              </h2>
              <p className="text-stone-600 text-sm sm:text-base max-w-2xl leading-relaxed">
                Authentic photographic glimpses of classroom practice, drawing competitions, educational excursions, and student achievements.
              </p>
            </div>

            <Link
              href="/gallery"
              className="btn-primary inline-flex items-center gap-2 px-4 py-2.5 rounded-lg text-xs font-semibold text-stone-700 bg-white hover:bg-stone-50 border border-stone-300 shadow-xs transition-colors shrink-0"
            >
              <span>View Full Gallery</span>
              <ArrowRight className="w-3.5 h-3.5 text-stone-500" />
            </Link>
          </div>

          <GalleryGrid />
        </div>
      </section>

      {/* 7. Verified School Life, Honors & Annual Events */}
      <SchoolLifeEvents />

      {/* 8. Institutional Leadership Desk */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <DirectorCard />
        </div>
      </section>

      {/* 8.1 Parent Testimonials & Community Voice */}
      <ParentTestimonials />

      {/* 8.2 Notice Board Announcements Preview */}
      <section className="py-16 sm:py-20 bg-white border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex flex-col md:flex-row md:items-end justify-between gap-4 mb-10">
            <div className="space-y-2">
              <div className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-md bg-[#E8F3EA] text-[#14532D] text-xs font-bold uppercase tracking-wider">
                <Calendar className="w-3.5 h-3.5" />
                <span>Notice Board</span>
              </div>
              <h2 className="font-heading font-bold text-2xl sm:text-3xl text-stone-900 tracking-tight">
                Latest Announcements &amp; Circulars
              </h2>
            </div>

            <Link
              href="/notices"
              className="btn-primary inline-flex items-center gap-2 px-4 py-2 rounded-lg text-xs font-semibold text-stone-700 bg-white hover:bg-stone-50 border border-stone-300 shadow-xs transition-colors shrink-0"
            >
              <span>All Notices</span>
              <ArrowRight className="w-3.5 h-3.5 text-stone-500" />
            </Link>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {SCHOOL_DATA.notices.slice(0, 2).map((notice) => (
              <NoticeCard key={notice.id} notice={notice} />
            ))}
          </div>
        </div>
      </section>

      {/* 9. Admissions Section (Process Timeline + Real Lead-Gen Form) */}
      <section id="admissions" className="py-16 sm:py-20 lg:py-24 bg-stone-50/60 border-b border-stone-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 items-start">
            {/* Left: Admissions Overview & 4-Step Timeline */}
            <div className="lg:col-span-6 space-y-8">
              <div className="space-y-3">
                <div className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-md bg-[#E8F3EA] text-[#14532D] text-xs font-bold uppercase tracking-wider">
                  <span>Admissions Open</span>
                </div>
                <h2 className="font-heading font-bold text-2xl sm:text-3xl lg:text-4xl text-stone-900 tracking-tight">
                  Admissions at Al-Qalam Public School
                </h2>
                <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
                  We welcome admission enquiries for Foundational (Pre-Primary / KG) and Primary (Classes 1–5) grades. Our process is designed to be clear and supportive for parents.
                </p>
              </div>

              {/* Interactive Age & Grade Eligibility Calculator */}
              <div id="calculator">
                <AdmissionCalculator />
              </div>

              {/* Vertical 4-Step Process Timeline */}
              <div className="space-y-4">
                {SCHOOL_DATA.admissionProcess.map((step) => (
                  <div
                    key={step.step}
                    className="p-4 sm:p-5 rounded-xl bg-white border border-stone-200/90 flex items-start gap-4 shadow-xs"
                  >
                    <div className="w-9 h-9 rounded-lg bg-[#14532D] text-white flex items-center justify-center font-mono font-bold text-xs shrink-0">
                      {step.step}
                    </div>
                    <div className="space-y-1">
                      <h3 className="font-heading font-bold text-base text-stone-900">
                        {step.title}
                      </h3>
                      <p className="text-xs sm:text-sm text-stone-600 leading-relaxed">
                        {step.description}
                      </p>
                    </div>
                  </div>
                ))}
              </div>

              {/* In-Person Campus Desk Help */}
              <div className="p-4 sm:p-5 rounded-xl bg-white border border-stone-200/90 space-y-2 text-xs text-stone-700 shadow-xs">
                <div className="flex items-center gap-2 font-bold text-stone-900">
                  <MapPin className="w-4 h-4 text-[#14532D]" />
                  <span>Campus Desk Inquiries</span>
                </div>
                <p className="leading-relaxed text-stone-600">
                  Parents may also directly visit the school administrative desk opposite Jashn Palace Marriage Hall, Ashok Rajpath Rd, Gulzarbagh, Patna for physical prospectus collection.
                </p>
              </div>
            </div>

            {/* Right: Real Interactive Admission Enquiry Form */}
            <div className="lg:col-span-6 lg:sticky lg:top-24">
              <AdmissionForm />
            </div>
          </div>
        </div>
      </section>

      {/* 9.1 Interactive Frequently Asked Questions */}
      <FAQSection />

      {/* 9.2 Official Mobile Application Suite Download Section */}
      <ApkDownloadSection />

      {/* 10. Campus Location & Contact Section */}
      <section className="py-16 sm:py-20 bg-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="max-w-3xl mx-auto text-center mb-12 space-y-3">
            <div className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-md bg-[#E8F3EA] text-[#14532D] text-xs font-bold uppercase tracking-wider">
              <span>Campus Visit</span>
            </div>
            <h2 className="font-heading font-bold text-2xl sm:text-3xl text-stone-900 tracking-tight">
              Visit Al-Qalam Public School
            </h2>
            <p className="text-stone-600 text-sm sm:text-base leading-relaxed">
              Conveniently located on Ashok Rajpath Road in Gulzarbagh, Alamganj, Patna.
            </p>
          </div>

          <ContactSection />
        </div>
      </section>
    </div>
  );
}
