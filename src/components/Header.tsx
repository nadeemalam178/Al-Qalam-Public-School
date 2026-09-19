"use client";

import React, { useState, useEffect } from "react";
import Link from "next/link";
import Image from "next/image";
import { usePathname } from "next/navigation";
import { Menu, X, PhoneCall, ChevronRight, GraduationCap } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function Header() {
  const [isOpen, setIsOpen] = useState(false);
  const [isScrolled, setIsScrolled] = useState(false);
  const pathname = usePathname();

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 15);
    };
    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  // Close mobile drawer whenever route changes
  useEffect(() => {
    setIsOpen(false);
  }, [pathname]);

  // Prevent background scroll when mobile menu is open
  useEffect(() => {
    if (isOpen) {
      document.body.style.overflow = "hidden";
    } else {
      document.body.style.overflow = "unset";
    }
  }, [isOpen]);

  return (
    <>
      {/* Top Notification Bar - Deep Forest Green */}
      <div className="bg-[#14532D] text-[#EDE2D3] text-xs py-1.5 px-4 hidden sm:block border-b border-[#0d3b1f]">
        <div className="max-w-7xl mx-auto flex justify-between items-center">
          <div className="flex items-center space-x-2">
            <span className="inline-block w-2 h-2 rounded-full bg-[#E8F3EA] animate-pulse" />
            <span className="text-[#FAF8F2] font-semibold">Admissions Open</span>
            <span className="text-[#2F7D4A]">|</span>
            <span className="text-[#EDE2D3]">Foundational & Primary Classes</span>
          </div>
          <div className="flex items-center space-x-4 text-[#EDE2D3]">
            <span>Ashok Rajpath Rd, Gulzarbagh, Patna</span>
            <span className="text-[#2F7D4A]">|</span>
            <Link
              href="/contact"
              className="text-[#FAF8F2] hover:text-[#EDE2D3] transition-colors flex items-center gap-1 font-medium"
            >
              <PhoneCall className="w-3 h-3 text-[#EDE2D3]" />
              <span>Campus Desk</span>
            </Link>
          </div>
        </div>
      </div>

      {/* Main Sticky Header */}
      <header
        className={`sticky top-0 z-50 transition-all duration-200 ${
          isScrolled
            ? "bg-white/98 backdrop-blur-md shadow-sm py-2.5 border-b border-stone-200"
            : "bg-[#FAF8F2]/95 backdrop-blur-sm py-3 border-b border-[#EDE2D3]"
        }`}
      >
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between">
            {/* Logo & School Title */}
            <Link
              href="/"
              className="flex items-center gap-3 group focus:outline-none focus:ring-2 focus:ring-[#166534] rounded-lg p-1 transition"
              aria-label="Al-Qalam Public School Home"
            >
              <div className="relative w-11 h-11 sm:w-12 sm:h-12 shrink-0 rounded-full ring-2 ring-[#166534]/20 p-0.5 bg-white shadow-xs transition-transform duration-200 group-hover:scale-105">
                <Image
                  src="/branding/al-qalam-logo.svg"
                  alt="Al-Qalam Public School Crest"
                  width={48}
                  height={48}
                  className="w-full h-full object-contain"
                  priority
                />
              </div>
              <div className="flex flex-col">
                <span className="font-black text-[#14532D] tracking-tight text-base sm:text-lg lg:text-xl leading-tight group-hover:text-[#166534] transition-colors">
                  {SCHOOL_DATA.name}
                </span>
                <div className="flex items-center gap-1.5 text-xs text-stone-500">
                  <span className="font-semibold text-[#6B4226]">Gulzarbagh, Patna</span>
                  <span className="text-stone-300">•</span>
                  <span className="italic hidden md:inline text-stone-600">
                    &ldquo;{SCHOOL_DATA.tagline}&rdquo;
                  </span>
                </div>
              </div>
            </Link>

            {/* Desktop Navigation */}
            <nav className="hidden xl:flex items-center space-x-1" aria-label="Main Navigation">
              {SCHOOL_DATA.navLinks.map((link) => {
                const isActive = pathname === link.href;
                return (
                  <Link
                    key={link.href}
                    href={link.href}
                    className={`nav-link-animated px-3 py-2 rounded-lg text-sm font-semibold transition-all duration-200 ${
                      isActive
                        ? "text-[#14532D] bg-[#E8F3EA] border-b-2 border-[#166534] font-bold"
                        : "text-stone-700 hover:text-[#14532D] hover:bg-stone-100/70"
                    }`}
                  >
                    {link.label}
                  </Link>
                );
              })}
            </nav>

            {/* Header Right Action CTA */}
            <div className="hidden sm:flex items-center gap-3">
              <Link
                href="/admissions"
                className="btn-interactive relative inline-flex items-center gap-2 px-4 py-2 text-sm font-bold text-white bg-[#166534] hover:bg-[#14532D] rounded-lg shadow-xs hover:shadow-sm active:scale-98 transition-all duration-150 border border-[#14532D]"
              >
                <GraduationCap className="w-4 h-4 text-[#EDE2D3]" />
                <span>Admission Enquiry</span>
              </Link>
            </div>

            {/* Mobile Hamburger Button */}
            <button
              onClick={() => setIsOpen(!isOpen)}
              type="button"
              className="xl:hidden p-2.5 rounded-lg text-[#14532D] hover:bg-[#E8F3EA] transition focus:outline-none focus:ring-2 focus:ring-[#166534]"
              aria-label={isOpen ? "Close navigation menu" : "Open navigation menu"}
              aria-expanded={isOpen}
            >
              {isOpen ? <X className="w-6 h-6 text-[#14532D]" /> : <Menu className="w-6 h-6" />}
            </button>
          </div>
        </div>
      </header>

      {/* Mobile Menu Backdrop & Drawer */}
      {isOpen && (
        <div
          className="fixed inset-0 z-40 bg-stone-900/60 backdrop-blur-xs xl:hidden transition-opacity"
          onClick={() => setIsOpen(false)}
          aria-hidden="true"
        />
      )}

      <div
        className={`fixed top-0 right-0 bottom-0 z-50 w-full max-w-sm bg-white shadow-2xl flex flex-col xl:hidden transform transition-transform duration-250 ease-in-out ${
          isOpen ? "translate-x-0" : "translate-x-full"
        }`}
      >
        {/* Mobile Drawer Header */}
        <div className="p-4 border-b border-[#EDE2D3] flex items-center justify-between bg-[#FAF8F2]">
          <div className="flex items-center gap-2.5">
            <Image
              src="/branding/al-qalam-logo.svg"
              alt="Al-Qalam Crest"
              width={36}
              height={36}
              className="object-contain"
            />
            <div>
              <p className="font-black text-[#14532D] text-sm leading-snug">{SCHOOL_DATA.name}</p>
              <p className="text-xs text-[#6B4226] font-semibold">Patna, Bihar</p>
            </div>
          </div>
          <button
            onClick={() => setIsOpen(false)}
            className="p-2 text-stone-500 hover:text-stone-800 rounded-lg hover:bg-stone-200 transition"
            aria-label="Close menu"
          >
            <X className="w-5 h-5 text-stone-700" />
          </button>
        </div>

        {/* Mobile Navigation Links */}
        <div className="flex-1 overflow-y-auto px-4 py-4 space-y-1">
          {SCHOOL_DATA.navLinks.map((link) => {
            const isActive = pathname === link.href;
            return (
              <Link
                key={link.href}
                href={link.href}
                onClick={() => setIsOpen(false)}
                className={`flex items-center justify-between px-3.5 py-3 rounded-lg text-base font-semibold transition ${
                  isActive
                    ? "bg-[#E8F3EA] text-[#14532D] border-l-4 border-[#166534] font-bold"
                    : "text-stone-700 hover:bg-stone-50 hover:text-[#14532D]"
                }`}
              >
                <span>{link.label}</span>
                <ChevronRight className="w-4 h-4 text-stone-400" />
              </Link>
            );
          })}

          <div className="pt-4 border-t border-stone-100">
            <Link
              href="/admissions"
              onClick={() => setIsOpen(false)}
              className="w-full flex items-center justify-center gap-2 py-3 px-4 rounded-xl font-bold text-white bg-[#166534] hover:bg-[#14532D] shadow-xs active:scale-98 transition text-center"
            >
              <GraduationCap className="w-5 h-5 text-[#EDE2D3]" />
              <span>Admission Enquiry</span>
            </Link>
          </div>
        </div>

        {/* Mobile Drawer Footer Info */}
        <div className="p-4 bg-[#14532D] text-[#EDE2D3] text-xs space-y-2">
          <p className="font-bold text-[#FAF8F2]">&ldquo;{SCHOOL_DATA.tagline}&rdquo;</p>
          <p className="text-stone-300 text-xs leading-relaxed">
            Opposite Jashn Palace Marriage Hall, Ashok Rajpath Rd, Gulzarbagh, Patna 800007
          </p>
        </div>
      </div>
    </>
  );
}
