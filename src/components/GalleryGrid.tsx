"use client";

import React, { useState, useEffect, useCallback, useRef } from "react";
import Image from "next/image";
import {
  X,
  ChevronLeft,
  ChevronRight,
  Play,
  Pause,
  Layers,
  Sparkles,
  ExternalLink,
} from "lucide-react";
import { GALLERY_ITEMS, GalleryItem } from "@/data/galleryData";

const categories = [
  "All",
  "Achievements",
  "Activities",
  "Events",
  "Classroom",
  "Campus",
  "Facilities",
] as const;

interface DynamicCardProps {
  item: GalleryItem;
  index: number;
  isFeatured: boolean;
  globalAutoPlay: boolean;
  onOpen: (idx: number, el: HTMLElement) => void;
}

function DynamicGalleryCard({
  item,
  index,
  isFeatured,
  globalAutoPlay,
  onOpen,
}: DynamicCardProps) {
  const allImages = React.useMemo(() => {
    return [item.src, ...(item.altSrcs || [])];
  }, [item.src, item.altSrcs]);

  const [currentImgIdx, setCurrentImgIdx] = useState(0);
  const [isHovered, setIsHovered] = useState(false);

  // Cycle to next photo
  const nextPhoto = useCallback((e?: React.MouseEvent) => {
    if (e) e.stopPropagation();
    if (allImages.length <= 1) return;
    setCurrentImgIdx((prev) => (prev + 1) % allImages.length);
  }, [allImages.length]);

  const prevPhoto = useCallback((e?: React.MouseEvent) => {
    if (e) e.stopPropagation();
    if (allImages.length <= 1) return;
    setCurrentImgIdx((prev) => (prev === 0 ? allImages.length - 1 : prev - 1));
  }, [allImages.length]);

  // Hover auto-cycling: cycles every 1.5s when hovered
  useEffect(() => {
    if (!isHovered || allImages.length <= 1) return;

    const interval = setInterval(() => {
      setCurrentImgIdx((prev) => (prev + 1) % allImages.length);
    }, 1600);

    return () => clearInterval(interval);
  }, [isHovered, allImages.length]);

  // Global ambient auto-play with staggered intervals
  useEffect(() => {
    if (!globalAutoPlay || isHovered || allImages.length <= 1) return;

    // Stagger cycle based on card index (between 3.5s and 5.5s)
    const staggerDelay = 3500 + (index % 4) * 800;
    const interval = setInterval(() => {
      setCurrentImgIdx((prev) => (prev + 1) % allImages.length);
    }, staggerDelay);

    return () => clearInterval(interval);
  }, [globalAutoPlay, isHovered, index, allImages.length]);

  return (
    <div
      tabIndex={0}
      role="button"
      aria-label={`View photo album: ${item.title}`}
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
      onClick={(e) => onOpen(index, e.currentTarget)}
      onKeyDown={(e) => {
        if (e.key === "Enter" || e.key === " ") {
          e.preventDefault();
          onOpen(index, e.currentTarget);
        }
      }}
      className={`group relative rounded-2xl overflow-hidden glass-panel border border-stone-200/80 hover:border-[#14532D]/40 hover:shadow-2xl transition-all duration-500 cursor-pointer flex flex-col focus:outline-none focus-visible:ring-2 focus-visible:ring-[#14532D] active:scale-[0.985] ${
        isFeatured ? "sm:col-span-2 lg:col-span-2" : ""
      }`}
    >
      {/* Photo Container */}
      <div
        className={`relative w-full overflow-hidden bg-stone-900 ${
          isFeatured ? "h-64 sm:h-84" : "h-60 sm:h-68"
        }`}
      >
        {/* Layered Images for Cross-Fade */}
        {allImages.map((src, imgIndex) => (
          <div
            key={src}
            className={`absolute inset-0 transition-all duration-700 ease-in-out ${
              imgIndex === currentImgIdx
                ? "opacity-100 scale-100 z-10"
                : "opacity-0 scale-105 pointer-events-none z-0"
            }`}
          >
            <Image
              src={src}
              alt={`${item.title} - Photo ${imgIndex + 1} - Al-Qalam Public School`}
              fill
              sizes={
                isFeatured
                  ? "(max-width: 768px) 100vw, 66vw"
                  : "(max-width: 640px) 100vw, (max-width: 1024px) 50vw, 33vw"
              }
              priority={index < 4}
              className={`object-cover object-center transition-transform duration-700 ${
                isHovered ? "scale-105" : "scale-100"
              }`}
            />
          </div>
        ))}

        {/* Ambient Dark Gradient for Contrast */}
        <div className="absolute inset-0 bg-gradient-to-t from-black/75 via-black/20 to-black/30 z-20 pointer-events-none" />

        {/* Top Badges */}
        <div className="absolute top-3 left-3 right-3 flex items-center justify-between z-30 pointer-events-none">
          <span className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-[11px] font-semibold bg-white/95 text-[#14532D] shadow-sm backdrop-blur-md border border-white/60">
            <span className="w-1.5 h-1.5 rounded-full bg-[#14532D]" />
            {item.tag}
          </span>

          <div className="flex items-center gap-1.5">
            {allImages.length > 1 && (
              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[10px] font-bold bg-black/60 text-[#EDE2D3] border border-white/20 backdrop-blur-md shadow-xs">
                <Layers className="w-3 h-3 text-[#C6E7CE]" />
                <span>
                  {currentImgIdx + 1}/{allImages.length}
                </span>
              </span>
            )}

            {item.isReal && (
              <span className="inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-medium bg-[#14532D]/90 text-white border border-white/25 shadow-xs backdrop-blur-md">
                Verified
              </span>
            )}
          </div>
        </div>

        {/* Quick Flip Arrows (Visible on Hover / Touch) */}
        {allImages.length > 1 && (
          <div className="absolute inset-x-2 top-1/2 -translate-y-1/2 flex items-center justify-between z-30 opacity-0 group-hover:opacity-100 transition-opacity duration-300">
            <button
              type="button"
              aria-label="Previous photo"
              onClick={prevPhoto}
              className="p-1.5 rounded-full bg-black/60 text-white hover:bg-black/90 backdrop-blur-md border border-white/20 shadow-md transition-transform hover:scale-110 active:scale-95 cursor-pointer"
            >
              <ChevronLeft className="w-4 h-4" />
            </button>

            <button
              type="button"
              aria-label="Next photo"
              onClick={nextPhoto}
              className="p-1.5 rounded-full bg-black/60 text-white hover:bg-black/90 backdrop-blur-md border border-white/20 shadow-md transition-transform hover:scale-110 active:scale-95 cursor-pointer"
            >
              <ChevronRight className="w-4 h-4" />
            </button>
          </div>
        )}

        {/* Hover / Auto-Change Progress Dots */}
        {allImages.length > 1 && (
          <div className="absolute bottom-3 left-3 right-3 flex items-center justify-between z-30 pointer-events-none">
            <div className="flex items-center gap-1.5">
              {allImages.map((_, dotIdx) => (
                <span
                  key={dotIdx}
                  className={`h-1.5 rounded-full transition-all duration-300 ${
                    dotIdx === currentImgIdx
                      ? "w-5 bg-[#C6E7CE] shadow-sm"
                      : "w-1.5 bg-white/40"
                  }`}
                />
              ))}
            </div>

            <span className="text-[10px] text-white/80 font-medium tracking-wide drop-shadow-xs">
              {isHovered ? "Cycling..." : "Hover to cycle"}
            </span>
          </div>
        )}
      </div>

      {/* Card Details Footer */}
      <div className="p-4 sm:p-5 flex-1 flex flex-col justify-between bg-white/90 backdrop-blur-sm">
        <div>
          <div className="flex items-center justify-between gap-2 text-xs text-stone-500 mb-1.5">
            <span className="font-semibold text-[#14532D] tracking-wide uppercase text-[10px]">
              {item.category}
            </span>
            {item.year && (
              <span className="text-stone-400 font-medium text-[11px]">
                Session {item.year}
              </span>
            )}
          </div>

          <h3 className="font-heading font-bold text-base sm:text-lg text-[#14532D] group-hover:text-[#0B3B20] transition-colors leading-snug">
            {item.title}
          </h3>

          <p className="text-stone-600 text-xs sm:text-sm mt-1.5 line-clamp-2 leading-relaxed">
            {item.description}
          </p>
        </div>

        <div className="mt-4 pt-3 border-t border-stone-100 flex items-center justify-between text-xs">
          <span className="text-[11px] text-stone-500 font-medium truncate max-w-[65%]">
            {item.source || "School Archive"}
          </span>
          <span className="text-[#14532D] font-bold inline-flex items-center gap-1 group-hover:translate-x-1 transition-transform">
            <span>Enlarge</span>
            <span>→</span>
          </span>
        </div>
      </div>
    </div>
  );
}

export default function GalleryGrid() {
  const [activeCategory, setActiveCategory] = useState<string>("All");
  const [selectedIdx, setSelectedIdx] = useState<number | null>(null);
  const [lightboxSubIdx, setLightboxSubIdx] = useState<number>(0);
  const [globalAutoPlay, setGlobalAutoPlay] = useState<boolean>(true);
  const [isModalPlaying, setIsModalPlaying] = useState<boolean>(false);
  const closeBtnRef = useRef<HTMLButtonElement>(null);
  const previousFocusRef = useRef<HTMLElement | null>(null);

  const filteredItems = GALLERY_ITEMS.filter((item) => {
    if (activeCategory === "All") return true;
    if (activeCategory === "Campus" || activeCategory === "Facilities") {
      return item.category === "Campus" || item.category === "Facilities";
    }
    return item.category === activeCategory;
  });

  const handleOpen = (idx: number, element: HTMLElement) => {
    previousFocusRef.current = element;
    setSelectedIdx(idx);
    setLightboxSubIdx(0);
  };

  const handleClose = useCallback(() => {
    setSelectedIdx(null);
    setIsModalPlaying(false);
    if (previousFocusRef.current) {
      previousFocusRef.current.focus();
    }
  }, []);

  const handlePrev = useCallback(() => {
    if (selectedIdx !== null) {
      setSelectedIdx((prev) =>
        prev !== null ? (prev === 0 ? filteredItems.length - 1 : prev - 1) : null
      );
      setLightboxSubIdx(0);
    }
  }, [selectedIdx, filteredItems.length]);

  const handleNext = useCallback(() => {
    if (selectedIdx !== null) {
      setSelectedIdx((prev) =>
        prev !== null ? (prev === filteredItems.length - 1 ? 0 : prev + 1) : null
      );
      setLightboxSubIdx(0);
    }
  }, [selectedIdx, filteredItems.length]);

  // Keyboard navigation
  useEffect(() => {
    if (selectedIdx === null) return;
    closeBtnRef.current?.focus();

    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === "Escape") handleClose();
      if (e.key === "ArrowLeft") handlePrev();
      if (e.key === "ArrowRight") handleNext();
    };

    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [selectedIdx, handleClose, handlePrev, handleNext]);

  // Auto-play slideshow inside open lightbox
  useEffect(() => {
    if (selectedIdx === null || !isModalPlaying) return;

    const timer = setInterval(() => {
      handleNext();
    }, 3200);

    return () => clearInterval(timer);
  }, [selectedIdx, isModalPlaying, handleNext]);

  // Lock scroll
  useEffect(() => {
    if (selectedIdx !== null) {
      const original = document.body.style.overflow;
      document.body.style.overflow = "hidden";
      return () => {
        document.body.style.overflow = original;
      };
    }
  }, [selectedIdx]);

  const currentItem: GalleryItem | null =
    selectedIdx !== null && filteredItems[selectedIdx]
      ? filteredItems[selectedIdx]
      : null;

  const currentAlbumImages = currentItem
    ? [currentItem.src, ...(currentItem.altSrcs || [])]
    : [];

  const currentLightboxImg =
    currentAlbumImages[lightboxSubIdx] || currentItem?.src || "";

  return (
    <div className="relative">
      {/* Top Filter & Dynamic Mode Toolbar */}
      <div className="mb-8 flex flex-col md:flex-row items-center justify-between gap-4">
        {/* Category Pills (Touch-optimized scroll on mobile) */}
        <div
          className="w-full md:w-auto overflow-x-auto no-scrollbar scroll-smooth flex items-center gap-2 py-1 px-1"
          role="tablist"
          aria-label="Gallery category filters"
        >
          {categories.map((cat) => {
            const isActive = activeCategory === cat;
            return (
              <button
                key={cat}
                role="tab"
                aria-selected={isActive}
                onClick={() => {
                  setActiveCategory(cat);
                  setSelectedIdx(null);
                }}
                className={`px-4 py-2 rounded-xl text-xs font-semibold whitespace-nowrap transition-all duration-200 cursor-pointer touch-manipulation active:scale-95 ${
                  isActive
                    ? "bg-[#14532D] text-white shadow-md shadow-[#14532D]/20 scale-100"
                    : "glass-pill text-stone-700 hover:bg-[#E8F3EA] border border-stone-200"
                }`}
              >
                {cat}
              </button>
            );
          })}
        </div>

        {/* Interactive Dynamic Auto-Play Toggle */}
        <div className="flex items-center gap-3 shrink-0">
          <button
            type="button"
            onClick={() => setGlobalAutoPlay((prev) => !prev)}
            aria-pressed={globalAutoPlay}
            className={`inline-flex items-center gap-2 px-3 py-1.5 rounded-xl text-xs font-semibold transition-all duration-300 border shadow-xs cursor-pointer ${
              globalAutoPlay
                ? "bg-[#E8F3EA] text-[#14532D] border-[#2F7D4A]/40"
                : "bg-white text-stone-600 border-stone-200 hover:bg-stone-50"
            }`}
          >
            <Sparkles
              className={`w-3.5 h-3.5 transition-transform duration-500 ${
                globalAutoPlay ? "text-[#14532D] rotate-12 scale-110" : "text-stone-400"
              }`}
            />
            <span>
              {globalAutoPlay ? "Auto-Cycle: Active" : "Auto-Cycle: Paused"}
            </span>
            <span
              className={`w-2 h-2 rounded-full ${
                globalAutoPlay ? "bg-[#14532D] animate-ping" : "bg-stone-300"
              }`}
            />
          </button>
        </div>
      </div>

      {/* Grid of Dynamic Multi-Photo Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        {filteredItems.map((item, index) => {
          const isFeatured = index === 0 || index === 4;
          return (
            <DynamicGalleryCard
              key={item.id}
              item={item}
              index={index}
              isFeatured={isFeatured}
              globalAutoPlay={globalAutoPlay}
              onOpen={handleOpen}
            />
          );
        })}
      </div>

      {/* Fullscreen Lightbox Modal */}
      {selectedIdx !== null && currentItem && (
        <div
          role="dialog"
          aria-modal="true"
          aria-label={currentItem.title}
          className="fixed inset-0 z-50 flex items-center justify-center p-3 sm:p-6 bg-black/90 backdrop-blur-2xl transition-all duration-300 animate-fadeIn"
          onClick={handleClose}
        >
          {/* Main Modal Container */}
          <div
            className="relative max-w-5xl w-full bg-stone-900/95 border border-white/15 rounded-3xl overflow-hidden shadow-2xl flex flex-col max-h-[92vh]"
            onClick={(e) => e.stopPropagation()}
          >
            {/* Top Toolbar */}
            <div className="flex items-center justify-between px-5 py-3.5 bg-black/50 border-b border-white/10 text-white z-20">
              <div className="flex items-center gap-2.5">
                <span className="px-2.5 py-1 rounded-full text-xs font-bold bg-[#14532D] text-white">
                  {currentItem.category}
                </span>
                {currentItem.year && (
                  <span className="text-stone-400 text-xs font-medium hidden sm:inline">
                    Session {currentItem.year}
                  </span>
                )}
                {currentItem.isReal && (
                  <span className="px-2 py-0.5 rounded-full text-[10px] font-semibold bg-emerald-950 text-emerald-300 border border-emerald-500/30">
                    Official Photograph
                  </span>
                )}
              </div>

              <div className="flex items-center gap-2">
                {/* Slideshow Toggle */}
                <button
                  type="button"
                  onClick={() => setIsModalPlaying((p) => !p)}
                  className="p-2 rounded-xl bg-white/10 hover:bg-white/20 text-white transition-colors cursor-pointer"
                  title={isModalPlaying ? "Pause Slideshow" : "Start Slideshow"}
                >
                  {isModalPlaying ? (
                    <Pause className="w-4 h-4 text-emerald-400" />
                  ) : (
                    <Play className="w-4 h-4" />
                  )}
                </button>

                {/* Close Button */}
                <button
                  ref={closeBtnRef}
                  onClick={handleClose}
                  className="p-2 rounded-xl bg-white/10 hover:bg-white/20 text-white transition-colors cursor-pointer"
                  aria-label="Close image modal"
                >
                  <X className="w-5 h-5" />
                </button>
              </div>
            </div>

            {/* Lightbox Center Image Viewport */}
            <div className="relative w-full h-[45vh] sm:h-[58vh] bg-black flex items-center justify-center overflow-hidden">
              <Image
                src={currentLightboxImg}
                alt={`${currentItem.title} - Al-Qalam Public School`}
                fill
                sizes="(max-width: 1280px) 100vw, 1200px"
                priority
                className="object-contain"
              />

              {/* Prev / Next Modal Arrows */}
              <button
                onClick={handlePrev}
                aria-label="Previous photo in gallery"
                className="absolute left-3 top-1/2 -translate-y-1/2 p-2.5 rounded-full bg-black/60 hover:bg-black/90 text-white border border-white/20 backdrop-blur-md shadow-lg transition-transform hover:scale-110 active:scale-95 cursor-pointer z-10"
              >
                <ChevronLeft className="w-5 h-5" />
              </button>

              <button
                onClick={handleNext}
                aria-label="Next photo in gallery"
                className="absolute right-3 top-1/2 -translate-y-1/2 p-2.5 rounded-full bg-black/60 hover:bg-black/90 text-white border border-white/20 backdrop-blur-md shadow-lg transition-transform hover:scale-110 active:scale-95 cursor-pointer z-10"
              >
                <ChevronRight className="w-5 h-5" />
              </button>
            </div>

            {/* Sub-image Thumbnails (If Album has multiple photos) */}
            {currentAlbumImages.length > 1 && (
              <div className="px-5 py-2.5 bg-black/60 border-t border-white/10 flex items-center gap-2 overflow-x-auto no-scrollbar">
                <span className="text-[11px] font-semibold text-stone-400 mr-2 shrink-0">
                  Album ({currentAlbumImages.length}):
                </span>
                {currentAlbumImages.map((thumbSrc, tIdx) => (
                  <button
                    key={thumbSrc}
                    type="button"
                    onClick={() => setLightboxSubIdx(tIdx)}
                    className={`relative w-14 h-10 rounded-lg overflow-hidden shrink-0 border-2 transition-all cursor-pointer ${
                      tIdx === lightboxSubIdx
                        ? "border-[#2F7D4A] scale-105 shadow-md"
                        : "border-transparent opacity-60 hover:opacity-100"
                    }`}
                  >
                    <Image
                      src={thumbSrc}
                      alt={`Thumb ${tIdx + 1}`}
                      fill
                      className="object-cover"
                    />
                  </button>
                ))}
              </div>
            )}

            {/* Bottom Caption & Source Bar */}
            <div className="p-5 bg-stone-900 border-t border-white/10 text-white">
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                <div>
                  <h4 className="font-heading font-bold text-lg sm:text-xl text-[#EDE2D3]">
                    {currentItem.title}
                  </h4>
                  <p className="text-stone-300 text-xs sm:text-sm mt-1 max-w-2xl leading-relaxed">
                    {currentItem.description}
                  </p>
                </div>

                {currentItem.source && (
                  <div className="shrink-0 flex sm:flex-col sm:items-end gap-1 text-[11px] text-stone-400">
                    <span className="font-semibold text-stone-300">
                      Source: {currentItem.source}
                    </span>
                    {currentItem.sourceUrl && (
                      <a
                        href={currentItem.sourceUrl}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="text-[#C6E7CE] hover:underline inline-flex items-center gap-1"
                      >
                        <span>View Source Post</span>
                        <ExternalLink className="w-3 h-3" />
                      </a>
                    )}
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
