"use client";

import React, { useState, useEffect, useRef } from "react";
import Link from "next/link";
import Image from "next/image";
import { usePathname } from "next/navigation";
import { Menu, X, MapPin, ArrowRight } from "lucide-react";
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
      {/* 1. Top Utility Authority Strip */}
      <div className="bg-[#0B3B20] text-stone-200 text-xs py-2 px-4 border-b border-[#14532D]">
        <div className="max-w-7xl mx-auto flex flex-wrap items-center justify-between gap-y-2">
          {/* Left: Admissions & Timings */}
          <div className="flex items-center gap-3">
            <span className="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-md text-[11px] font-bold uppercase tracking-wider text-white bg-[#B45309] shadow-xs">
              <span className="w-1.5 h-1.5 rounded-full bg-white animate-pulse" />
              <span>Admissions 2026-27 Open</span>
            </span>
            <span className="text-[#2F7D4A] hidden sm:inline">|</span>
            <span className="text-stone-300 hidden sm:inline text-[11px]">
              Campus Timings: Mon – Sat 7:30 AM – 1:30 PM
            </span>
          </div>

          {/* Right: Phone, Location & WhatsApp */}
          <div className="flex items-center gap-4 text-[11px] text-stone-300">
            <a
              href="tel:+919334112345"
              className="hover:text-white transition-colors flex items-center gap-1 font-semibold text-emerald-200"
            >
              <span>📞 +91 93341 12345</span>
            </a>
            <span className="text-[#2F7D4A] hidden md:inline">|</span>
            <div className="flex items-center gap-1.5 hidden md:flex">
              <MapPin className="w-3.5 h-3.5 text-emerald-300 shrink-0" />
              <span>Ashok Rajpath Rd, Gulzarbagh, Patna</span>
            </div>
            <span className="text-[#2F7D4A] hidden lg:inline">|</span>
            <a
              href="https://wa.me/919334112345?text=Hello%20Al-Qalam%20Public%20School%2C%20I%20would%20like%20information%20regarding%20admissions"
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-md text-[10px] font-bold text-white bg-[#166534] hover:bg-[#14532D] transition-colors"
            >
              <span>WhatsApp Us</span>
            </a>
          </div>
        </div>
      </div>

      {/* 2. Main Sticky Header */}
      <header
        className={`sticky top-0 z-40 transition-all duration-300 backdrop-blur-xl bg-white/95 border-b ${
          isScrolled
            ? "py-2 shadow-md border-stone-200/90 bg-white"
            : "py-3 border-stone-200/60"
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
                  <span className="font-medium text-stone-600">Gulzarbagh, Patna</span>
                  <span className="text-stone-300">•</span>
                  <span className="font-serif text-[11px] text-[#14532D] font-medium hidden sm:inline">
                    اقْرَأْ بِاسْمِ رَبِّكَ
                  </span>
                  <span className="text-stone-300 hidden lg:inline">•</span>
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
            <div className="hidden sm:flex items-center gap-2.5">
              <Link
                href="/admissions"
                className="btn-primary-school text-xs py-2 px-4 font-semibold shadow-xs hover:shadow-sm transition-all"
              >
                <span>Admission Enquiry</span>
                <ArrowRight className="w-3.5 h-3.5 ml-1 text-white/80" />
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

      {/* 3. Mobile Navigation Drawer */}
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
        <div className="p-4 sm:p-5 border-b border-stone-200 flex items-center justify-between bg-stone-50">
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
              <p className="text-xs text-stone-600 font-medium">Gulzarbagh, Patna</p>
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
              <ArrowRight className="w-4 h-4 text-white/80" />
            </Link>

            <Link
              href="/contact"
              onClick={closeDrawer}
              className="w-full flex items-center justify-center gap-2 py-2.5 px-4 rounded-lg font-medium text-stone-700 bg-white hover:bg-stone-50 border border-stone-200 text-sm transition-colors shadow-2xs"
            >
              <span>Campus Location & Details</span>
            </Link>
          </div>
        </div>

        {/* Drawer Footer Information */}
        <div className="p-4 bg-[#0B3B20] text-stone-200 text-xs space-y-1.5 border-t border-[#14532D]">
          <p className="font-heading font-semibold text-white">&ldquo;{SCHOOL_DATA.tagline}&rdquo;</p>
          <p className="text-stone-300 text-[11px] leading-relaxed">
            Opp. Jashn Palace, Ashok Rajpath Rd, Gulzarbagh, Patna 800007
          </p>
        </div>
      </div>
    </>
  );
}
