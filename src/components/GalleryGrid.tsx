"use client";

import React, { useState, useEffect, useCallback } from "react";
import Image from "next/image";
import { X, ChevronLeft, ChevronRight, ZoomIn, Camera } from "lucide-react";
import { SCHOOL_DATA, GalleryItem } from "@/data/schoolData";

const categories = ["All", "School", "Classroom", "Activities", "Events", "Facilities"] as const;

export default function GalleryGrid() {
  const [activeCategory, setActiveCategory] = useState<string>("All");
  const [selectedItemIndex, setSelectedItemIndex] = useState<number | null>(null);

  const filteredItems = SCHOOL_DATA.galleryItems.filter(
    (item) => activeCategory === "All" || item.category === activeCategory
  );

  const handleOpen = (idx: number) => {
    setSelectedItemIndex(idx);
  };

  const handleClose = () => {
    setSelectedItemIndex(null);
  };

  const handlePrev = useCallback(() => {
    if (selectedItemIndex !== null) {
      setSelectedItemIndex((prev) =>
        prev !== null ? (prev === 0 ? filteredItems.length - 1 : prev - 1) : null
      );
    }
  }, [selectedItemIndex, filteredItems.length]);

  const handleNext = useCallback(() => {
    if (selectedItemIndex !== null) {
      setSelectedItemIndex((prev) =>
        prev !== null ? (prev === filteredItems.length - 1 ? 0 : prev + 1) : null
      );
    }
  }, [selectedItemIndex, filteredItems.length]);

  // Keyboard navigation for Lightbox
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (selectedItemIndex === null) return;
      if (e.key === "Escape") handleClose();
      if (e.key === "ArrowLeft") handlePrev();
      if (e.key === "ArrowRight") handleNext();
    };

    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [selectedItemIndex, handlePrev, handleNext]);

  const currentItem = selectedItemIndex !== null ? filteredItems[selectedItemIndex] : null;

  const getColorGradient = (scheme: GalleryItem["colorScheme"]) => {
    switch (scheme) {
      case "forest":
        return "from-[#0d3b1f] via-[#14532D] to-[#166534] text-white";
      case "earth":
        return "from-[#3d2314] via-[#4A2C1A] to-[#6B4226] text-[#EDE2D3]";
      case "mediumGreen":
        return "from-[#14532D] via-[#1b7a3f] to-[#2F7D4A] text-[#FAF8F2]";
      case "warmBrown":
        return "from-[#4A2C1A] via-[#6B4226] to-[#885532] text-[#EDE2D3]";
      default:
        return "from-[#0d3b1f] via-[#14532D] to-[#166534] text-white";
    }
  };

  return (
    <div>
      {/* Category Tabs */}
      <div className="flex flex-wrap items-center justify-center gap-2 mb-10">
        {categories.map((cat) => {
          const isActive = activeCategory === cat;
          return (
            <button
              key={cat}
              onClick={() => {
                setActiveCategory(cat);
                setSelectedItemIndex(null);
              }}
              className={`px-4 py-2 rounded-xl text-xs sm:text-sm font-bold transition-all duration-150 cursor-pointer ${
                isActive
                  ? "bg-[#14532D] text-white shadow-xs border border-[#166534]"
                  : "bg-[#FAF8F2] text-stone-700 hover:bg-[#E8F3EA] border border-[#EDE2D3]"
              }`}
            >
              {cat}
            </button>
          );
        })}
      </div>

      {/* Gallery Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        {filteredItems.map((item, index) => (
          <div
            key={item.id}
            onClick={() => handleOpen(index)}
            className="group rounded-2xl overflow-hidden bg-white border border-stone-200 shadow-xs hover:shadow-md transition-all duration-200 cursor-pointer flex flex-col"
          >
            {/* Visual Graphic Tile */}
            <div
              className={`h-52 bg-gradient-to-br ${getColorGradient(
                item.colorScheme
              )} relative flex flex-col items-center justify-center p-6 text-center overflow-hidden`}
            >
              {/* Watermark crest */}
              <div className="absolute inset-0 flex items-center justify-center opacity-10 pointer-events-none transform group-hover:scale-105 transition-transform duration-300">
                <Image
                  src="/logo.png"
                  alt="Al-Qalam Logo Watermark"
                  width={180}
                  height={180}
                  className="object-contain"
                />
              </div>

              {/* Badge & Icon */}
              <div className="relative z-10 w-13 h-13 rounded-2xl bg-white/10 backdrop-blur-md border border-white/20 flex items-center justify-center mb-3 group-hover:scale-105 transition-transform duration-200 shadow-sm">
                <Camera className="w-6 h-6 text-[#EDE2D3]" />
              </div>

              <span className="relative z-10 text-xs uppercase font-bold tracking-widest text-[#EDE2D3] mb-1">
                {item.tag}
              </span>
              <h4 className="relative z-10 text-lg font-bold text-white px-4 leading-snug">
                {item.title}
              </h4>

              {/* Hover Zoom Overlay */}
              <div className="absolute inset-0 bg-[#0d3b1f]/75 opacity-0 group-hover:opacity-100 backdrop-blur-xs transition-opacity duration-150 flex items-center justify-center gap-2 text-white font-semibold text-xs">
                <ZoomIn className="w-4 h-4 text-[#EDE2D3]" />
                <span>Click to View</span>
              </div>
            </div>

            {/* Bottom Card Content */}
            <div className="p-5 flex-1 flex flex-col justify-between">
              <p className="text-xs sm:text-sm text-stone-600 leading-relaxed">
                {item.description}
              </p>
              <div className="mt-4 pt-3 border-t border-stone-100 flex items-center justify-between text-xs">
                <span className="font-semibold text-stone-500">{item.category}</span>
                <span className="text-[11px] font-medium text-[#6B4226] bg-[#FAF8F2] px-2 py-0.5 rounded border border-[#EDE2D3]">
                  Sample Preview
                </span>
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Lightbox Modal */}
      {currentItem && selectedItemIndex !== null && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-stone-950/80 backdrop-blur-xs animate-in fade-in duration-150"
          onClick={handleClose}
        >
          <div
            className="relative max-w-2xl w-full bg-[#0d3b1f] rounded-3xl overflow-hidden shadow-2xl border border-[#2F7D4A]/50 text-white"
            onClick={(e) => e.stopPropagation()}
          >
            {/* Top Bar */}
            <div className="p-4 border-b border-[#2F7D4A]/40 flex items-center justify-between">
              <div className="flex items-center gap-2">
                <span className="px-2.5 py-0.5 rounded-full text-xs font-bold uppercase bg-[#E8F3EA]/15 text-[#EDE2D3] border border-[#EDE2D3]/20">
                  {currentItem.category}
                </span>
                <span className="text-xs text-stone-300 font-mono">
                  {selectedItemIndex + 1} / {filteredItems.length}
                </span>
              </div>
              <button
                onClick={handleClose}
                className="p-1.5 text-stone-300 hover:text-white rounded-lg hover:bg-white/10 transition cursor-pointer"
                aria-label="Close Lightbox"
              >
                <X className="w-5 h-5 text-stone-200" />
              </button>
            </div>

            {/* Center Visual */}
            <div
              className={`h-72 sm:h-80 bg-gradient-to-br ${getColorGradient(
                currentItem.colorScheme
              )} relative flex flex-col items-center justify-center p-8 text-center`}
            >
              <div className="w-20 h-20 rounded-2xl bg-white p-1.5 border border-white/30 flex items-center justify-center mb-4 shadow-lg">
                <Image
                  src="/logo.png"
                  alt="Al-Qalam Badge"
                  width={64}
                  height={64}
                  className="object-contain"
                />
              </div>
              <span className="text-xs uppercase font-bold tracking-widest text-[#EDE2D3] mb-2">
                {currentItem.tag}
              </span>
              <h3 className="text-xl sm:text-2xl font-black text-white max-w-md leading-snug">
                {currentItem.title}
              </h3>
            </div>

            {/* Description & Navigation */}
            <div className="p-6 bg-[#0a2916] flex flex-col sm:flex-row items-center justify-between gap-4">
              <p className="text-xs sm:text-sm text-stone-200 leading-relaxed text-center sm:text-left">
                {currentItem.description}
              </p>

              <div className="flex items-center gap-2 shrink-0">
                <button
                  onClick={handlePrev}
                  className="p-2.5 rounded-xl bg-[#14532D] hover:bg-[#166534] border border-[#2F7D4A]/50 text-white transition cursor-pointer"
                  aria-label="Previous item"
                >
                  <ChevronLeft className="w-5 h-5" />
                </button>
                <button
                  onClick={handleNext}
                  className="p-2.5 rounded-xl bg-[#14532D] hover:bg-[#166534] border border-[#2F7D4A]/50 text-white transition cursor-pointer"
                  aria-label="Next item"
                >
                  <ChevronRight className="w-5 h-5" />
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
