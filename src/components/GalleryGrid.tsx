"use client";

import React, { useState, useEffect, useCallback } from "react";
import Image from "next/image";
import { X, ChevronLeft, ChevronRight, ZoomIn } from "lucide-react";
import { SCHOOL_DATA } from "@/data/schoolData";
import { schoolImages } from "@/data/schoolImages";

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

  // Find image corresponding to the item or fallback cyclically
  const getItemImage = (index: number) => {
    const galImages = schoolImages.gallery;
    return galImages[index % galImages.length];
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
              className={`btn-interactive px-4 py-2 rounded-xl text-xs sm:text-sm font-bold transition-all duration-150 cursor-pointer ${
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
        {filteredItems.map((item, index) => {
          const imageObj = getItemImage(index);
          return (
            <div
              key={item.id}
              onClick={() => handleOpen(index)}
              className="card-interactive group rounded-2xl overflow-hidden bg-white border border-stone-200 shadow-xs cursor-pointer flex flex-col"
            >
              {/* Photo Tile with Smooth Zoom */}
              <div className="img-zoom-parent relative h-56 sm:h-60 w-full bg-stone-900">
                <Image
                  src={imageObj.src}
                  alt={item.title}
                  fill
                  sizes="(max-width: 640px) 100vw, (max-width: 1024px) 50vw, 33vw"
                  className="img-zoom-child object-cover object-center"
                />

                {/* Gradient vignette for legibility */}
                <div className="absolute inset-0 bg-gradient-to-t from-black/75 via-black/20 to-black/30" />

                {/* Watermark crest subtle touch */}
                <div className="absolute top-3 left-3 w-8 h-8 opacity-40 pointer-events-none">
                  <Image
                    src={schoolImages.branding.lightSvg}
                    alt=""
                    width={32}
                    height={32}
                    className="w-full h-full object-contain"
                  />
                </div>

                {/* Floating Tag */}
                <div className="absolute top-3 right-3 z-10">
                  <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-bold uppercase tracking-wider bg-[#FAF8F2]/95 text-[#6B4226] border border-[#EDE2D3] shadow-xs backdrop-blur-xs">
                    {item.tag}
                  </span>
                </div>

                {/* Bottom Title on Image */}
                <div className="absolute bottom-3 left-3 right-3 z-10">
                  <h4 className="text-base font-bold text-white leading-snug drop-shadow-sm group-hover:text-[#EDE2D3] transition-colors">
                    {item.title}
                  </h4>
                </div>

                {/* Hover Zoom Overlay */}
                <div className="absolute inset-0 bg-[#0d3b1f]/65 opacity-0 group-hover:opacity-100 backdrop-blur-xs transition-opacity duration-200 flex items-center justify-center gap-2 text-white font-semibold text-xs z-20">
                  <ZoomIn className="w-4 h-4 text-[#EDE2D3]" />
                  <span>Enlarge Photo</span>
                </div>
              </div>

              {/* Caption & Category Footer */}
              <div className="p-4 sm:p-5 flex-1 flex flex-col justify-between bg-white">
                <p className="text-xs sm:text-sm text-stone-600 line-clamp-2">
                  {item.description}
                </p>
                <div className="mt-3 pt-3 border-t border-stone-100 flex items-center justify-between text-xs">
                  <span className="font-semibold text-stone-500">{item.category}</span>
                  <span className="text-[#14532D] font-bold flex items-center gap-1 group-hover:translate-x-1 transition-transform">
                    <span>View</span>
                    <span>→</span>
                  </span>
                </div>
              </div>
            </div>
          );
        })}
      </div>

      {/* Lightbox Modal */}
      {selectedItemIndex !== null && currentItem && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-stone-950/85 backdrop-blur-sm animate-in fade-in duration-200"
          onClick={handleClose}
        >
          <div
            className="relative max-w-3xl w-full bg-[#0d3b1f] rounded-3xl overflow-hidden shadow-2xl border border-[#2F7D4A]/50 text-white"
            onClick={(e) => e.stopPropagation()}
          >
            {/* Top Bar */}
            <div className="p-4 border-b border-[#2F7D4A]/40 flex items-center justify-between bg-[#0a2916]">
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

            {/* Center Visual - High Quality Photograph Display */}
            <div className="relative h-72 sm:h-96 w-full bg-stone-900">
              <Image
                src={getItemImage(selectedItemIndex).src}
                alt={currentItem.title}
                fill
                sizes="(max-width: 768px) 100vw, 768px"
                className="object-cover object-center"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-transparent to-black/20" />

              {/* Corner School Crest Badge */}
              <div className="absolute top-4 left-4 z-10 w-12 h-12 rounded-full bg-white/95 p-1 shadow-md border border-white/40">
                <Image
                  src={schoolImages.branding.primarySvg}
                  alt="Al-Qalam Crest"
                  width={40}
                  height={40}
                  className="w-full h-full object-contain"
                />
              </div>

              {/* Bottom Tag & Title Overlay */}
              <div className="absolute bottom-4 left-4 right-4 z-10">
                <span className="text-xs uppercase font-bold tracking-widest text-[#EDE2D3] mb-1 block">
                  {currentItem.tag}
                </span>
                <h3 className="text-xl sm:text-2xl font-black text-white leading-tight drop-shadow-md">
                  {currentItem.title}
                </h3>
              </div>
            </div>

            {/* Description & Navigation Controls */}
            <div className="p-6 bg-[#0a2916] flex flex-col sm:flex-row items-center justify-between gap-4">
              <p className="text-xs sm:text-sm text-stone-200 leading-relaxed text-center sm:text-left max-w-xl">
                {currentItem.description}
              </p>

              <div className="flex items-center gap-2 shrink-0">
                <button
                  onClick={handlePrev}
                  className="btn-interactive p-2.5 rounded-xl bg-[#14532D] hover:bg-[#166534] border border-[#2F7D4A]/50 text-white transition cursor-pointer"
                  aria-label="Previous item"
                >
                  <ChevronLeft className="w-5 h-5" />
                </button>
                <button
                  onClick={handleNext}
                  className="btn-interactive p-2.5 rounded-xl bg-[#14532D] hover:bg-[#166534] border border-[#2F7D4A]/50 text-white transition cursor-pointer"
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
