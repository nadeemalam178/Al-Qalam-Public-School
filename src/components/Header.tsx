"use client";

import React, { useState, useEffect, useRef } from "react";
import Link from "next/link";
import Image from "next/image";
import { usePathname } from "next/navigation";
import { Menu, X, MapPin, Sparkles, ArrowRight } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";

export default function Header() {
  const [isOpen, setIsOpen] = useState(false);
  const [isScrolled, setIsScrolled] = useState(false);
  const pathname = usePathname();
  const drawerRef = useRef<HTMLDivElement>(null);
  const menuButtonRef = useRef<HTMLButtonElement>(null);

  // Monitor scroll for subtle height compression & shadow
  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 20);
    };
    window.addEventListener("scroll", handleScroll, { passive: true });
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  // Handle body scroll lock & Escape key when mobile drawer is open
  useEffect(() => {
    if (isOpen) {
      const originalOverflow = document.body.style.overflow;
      document.body.style.overflow = "hidden";

      const handleKeyDown = (e: KeyboardEvent) => {
        if (e.key === "Escape") {
          setIsOpen(false);
          menuButtonRef.current?.focus();
        }
      };

      const handleResize = () => {
        if (window.innerWidth >= 1280) {
          setIsOpen(false);
        }
      };

      window.addEventListener("keydown", handleKeyDown);
      window.addEventListener("resize", handleResize);

      return () => {
        document.body.style.overflow = originalOverflow;
        window.removeEventListener("keydown", handleKeyDown);
        window.removeEventListener("resize", handleResize);
      };
    }
  }, [isOpen]);

  const closeDrawer = () => {
    setIsOpen(false);
  };

  return (
    <>
      {/* 1. Top Utility Strip */}
      <div className="bg-[#0B3B20] text-[#EDE2D3] text-xs py-2 px-4 border-b border-[#14532D]">
        <div className="max-w-7xl mx-auto flex items-center justify-between">
          <div className="flex items-center gap-2">
            <span className="inline-flex items-center gap-1.5 px-2 py-0.5 rounded-full bg-[#14532D] text-[#E8F3EA] text-[11px] font-semibold border border-[#2F7D4A]/40">
              <Sparkles className="w-3 h-3 text-[#E8F3EA]" />
              <span>Admissions Open</span>
            </span>
            <span className="text-stone-400 hidden sm:inline">•</span>
            <span className="text-stone-300 hidden sm:inline text-[11px]">
              Foundational & Primary Classes
            </span>
          </div>

          <div className="flex items-center gap-4 text-[11px] text-stone-300">
            <div className="flex items-center gap-1.5">
              <MapPin className="w-3.5 h-3.5 text-[#EDE2D3] shrink-0" />
              <span className="hidden md:inline">Opp. Jashn Palace,</span>
              <span>Ashok Rajpath Rd, Gulzarbagh</span>
            </div>
            <span className="text-[#2F7D4A] hidden md:inline">|</span>
            <Link
              href="/contact"
              className="text-[#FAF8F2] hover:text-white underline underline-offset-2 transition-colors font-medium hidden sm:inline"
            >
              Campus Visit
            </Link>
          </div>
        </div>
      </div>

      {/* 2. Main Sticky Header */}
      <header
        className={`sticky top-0 z-40 transition-all duration-300 backdrop-blur-xl bg-white/90 border-b ${
          isScrolled
            ? "py-2.5 shadow-md border-stone-200/90 bg-white/95"
            : "py-3.5 border-stone-200/60"
        }`}
      >
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between">
            {/* School Crest & Name */}
            <Link
              href="/"
              className="flex items-center gap-3 group focus:outline-none focus-visible:ring-2 focus-visible:ring-[#166534] rounded-lg p-0.5"
              aria-label="Al-Qalam Public School Home"
              onClick={closeDrawer}
            >
              <div className="relative w-11 h-11 sm:w-12 sm:h-12 shrink-0 transition-transform duration-200 group-hover:scale-102">
                <Image
                  src="/logo.png"
                  alt="Al-Qalam Public School Crest"
                  width={48}
                  height={48}
                  className="w-full h-full object-contain"
                  priority
                />
              </div>
              <div className="flex flex-col">
                <span className="font-heading font-bold text-[#14532D] text-lg sm:text-xl tracking-tight leading-tight group-hover:text-[#0B3B20] transition-colors">
                  {SCHOOL_DATA.name}
                </span>
                <div className="flex items-center gap-1.5 text-xs text-stone-500">
                  <span className="font-medium text-[#6B4226]">Gulzarbagh, Patna</span>
                  <span className="text-stone-300">•</span>
                  <span className="italic hidden lg:inline text-stone-600">
                    &ldquo;{SCHOOL_DATA.tagline}&rdquo;
                  </span>
                </div>
              </div>
            </Link>

            {/* Desktop Navigation Links */}
            <nav className="hidden xl:flex items-center space-x-1" aria-label="Primary Navigation">
              {SCHOOL_DATA.navLinks.map((link) => {
                const isActive = pathname === link.href;
                return (
                  <Link
                    key={link.href}
                    href={link.href}
                    className={`px-3 py-1.5 rounded-md text-sm font-medium transition-colors ${
                      isActive
                        ? "text-[#14532D] bg-[#E8F3EA] font-semibold"
                        : "text-stone-700 hover:text-[#14532D] hover:bg-stone-50"
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
                className="btn-primary px-4 py-2 text-xs font-semibold text-white bg-[#14532D] hover:bg-[#0B3B20] rounded-lg shadow-xs hover:shadow-sm transition-colors border border-[#0B3B20]"
              >
                <span>Admission Enquiry</span>
                <ArrowRight className="w-3.5 h-3.5 ml-1.5 text-[#EDE2D3]" />
              </Link>
            </div>

            {/* Mobile Navigation Trigger Button */}
            <button
              ref={menuButtonRef}
              onClick={() => setIsOpen((prev) => !prev)}
              type="button"
              className="xl:hidden p-2 rounded-lg text-stone-700 hover:text-[#14532D] hover:bg-[#E8F3EA] transition-colors focus:outline-none focus-visible:ring-2 focus-visible:ring-[#166534]"
              aria-label={isOpen ? "Close navigation menu" : "Open navigation menu"}
              aria-expanded={isOpen}
              aria-controls="mobile-navigation-drawer"
            >
              {isOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
            </button>
          </div>
        </div>
      </header>

      {/* 3. Mobile Navigation Drawer (Near Full-Screen) */}
      {isOpen && (
        <div
          className="fixed inset-0 z-50 bg-black/60 backdrop-blur-md xl:hidden transition-opacity"
          onClick={closeDrawer}
          aria-hidden="true"
        />
      )}

      <div
        id="mobile-navigation-drawer"
        ref={drawerRef}
        role="dialog"
        aria-modal="true"
        aria-label="Mobile Navigation"
        className={`fixed inset-y-0 right-0 z-50 w-full max-w-sm sm:max-w-md bg-white shadow-2xl flex flex-col xl:hidden transform transition-transform duration-250 ease-out ${
          isOpen ? "translate-x-0" : "translate-x-full"
        }`}
      >
        {/* Drawer Header */}
        <div className="p-4 sm:p-5 border-b border-[#E7E5E4] flex items-center justify-between bg-[#FAF8F2]">
          <div className="flex items-center gap-3">
            <Image
              src="/logo.png"
              alt="Al-Qalam Crest"
              width={40}
              height={40}
              className="object-contain"
            />
            <div>
              <p className="font-heading font-bold text-[#14532D] text-base leading-tight">
                {SCHOOL_DATA.name}
              </p>
              <p className="text-xs text-[#6B4226] font-medium">Gulzarbagh, Patna</p>
            </div>
          </div>
          <button
            onClick={closeDrawer}
            className="p-2 text-stone-600 hover:text-stone-900 rounded-lg hover:bg-stone-200/60 transition-colors"
            aria-label="Close navigation menu"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Drawer Navigation Links */}
        <div className="flex-1 overflow-y-auto px-4 py-5 space-y-1">
          <p className="px-3 text-[11px] font-bold text-stone-400 uppercase tracking-wider mb-2">
            Navigation
          </p>
          {SCHOOL_DATA.navLinks.map((link) => {
            const isActive = pathname === link.href;
            return (
              <Link
                key={link.href}
                href={link.href}
                onClick={closeDrawer}
                className={`flex items-center justify-between px-3.5 py-3 rounded-lg text-sm font-medium transition-colors ${
                  isActive
                    ? "bg-[#E8F3EA] text-[#14532D] font-semibold"
                    : "text-stone-700 hover:bg-stone-50 hover:text-[#14532D]"
                }`}
              >
                <span>{link.label}</span>
                <span className="text-stone-400 text-xs">→</span>
              </Link>
            );
          })}

          <div className="pt-6 space-y-3">
            <Link
              href="/admissions"
              onClick={closeDrawer}
              className="w-full flex items-center justify-center gap-2 py-3 px-4 rounded-lg font-semibold text-white bg-[#14532D] hover:bg-[#0B3B20] text-sm shadow-xs transition-colors"
            >
              <span>Admission Enquiry</span>
              <ArrowRight className="w-4 h-4 text-[#EDE2D3]" />
            </Link>

            <Link
              href="/contact"
              onClick={closeDrawer}
              className="w-full flex items-center justify-center gap-2 py-2.5 px-4 rounded-lg font-medium text-stone-700 bg-[#FAF8F2] hover:bg-stone-100 border border-[#EDE2D3] text-sm transition-colors"
            >
              <span>Campus Location & Details</span>
            </Link>
          </div>
        </div>

        {/* Drawer Footer Information */}
        <div className="p-4 bg-[#0B3B20] text-[#EDE2D3] text-xs space-y-1.5 border-t border-[#14532D]">
          <p className="font-heading font-semibold text-[#FAF8F2]">&ldquo;{SCHOOL_DATA.tagline}&rdquo;</p>
          <p className="text-stone-300 text-[11px] leading-relaxed">
            Opp. Jashn Palace, Ashok Rajpath Rd, Gulzarbagh, Patna 800007
          </p>
        </div>
      </div>
    </>
  );
}
