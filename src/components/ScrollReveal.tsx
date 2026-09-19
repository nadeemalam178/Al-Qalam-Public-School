"use client";

import React, { useEffect, useRef, useState } from "react";

export type AnimationVariant =
  | "fade-up"
  | "fade-down"
  | "fade-left"
  | "fade-right"
  | "scale-in"
  | "image-reveal";

interface ScrollRevealProps {
  children: React.ReactNode;
  variant?: AnimationVariant;
  delay?: number; // delay in milliseconds
  duration?: number; // duration in milliseconds
  className?: string;
  threshold?: number;
  once?: boolean;
}

export default function ScrollReveal({
  children,
  variant = "fade-up",
  delay = 0,
  duration = 650,
  className = "",
  threshold = 0.12,
  once = true,
}: ScrollRevealProps) {
  const [isVisible, setIsVisible] = useState(false);
  const [prefersReducedMotion, setPrefersReducedMotion] = useState(false);
  const elementRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    // Check for prefers-reduced-motion
    if (typeof window !== "undefined") {
      const mediaQuery = window.matchMedia("(prefers-reduced-motion: reduce)");
      if (mediaQuery.matches) {
        setPrefersReducedMotion(true);
        setIsVisible(true);
        return;
      }
    }

    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setIsVisible(true);
          if (once && elementRef.current) {
            observer.unobserve(elementRef.current);
          }
        } else if (!once) {
          setIsVisible(false);
        }
      },
      {
        threshold,
        rootMargin: "0px 0px -40px 0px",
      }
    );

    const currentElem = elementRef.current;
    if (currentElem) {
      observer.observe(currentElem);
    }

    return () => {
      if (currentElem) {
        observer.unobserve(currentElem);
      }
    };
  }, [once, threshold]);

  if (prefersReducedMotion) {
    return <div className={className}>{children}</div>;
  }

  // Base and active CSS classes by variant
  const getVariantStyles = (): { init: string; active: string } => {
    switch (variant) {
      case "fade-down":
        return {
          init: "opacity-0 -translate-y-6",
          active: "opacity-100 translate-y-0",
        };
      case "fade-left":
        return {
          init: "opacity-0 -translate-x-8",
          active: "opacity-100 translate-x-0",
        };
      case "fade-right":
        return {
          init: "opacity-0 translate-x-8",
          active: "opacity-100 translate-x-0",
        };
      case "scale-in":
        return {
          init: "opacity-0 scale-95",
          active: "opacity-100 scale-100",
        };
      case "image-reveal":
        return {
          init: "opacity-0 scale-102 filter blur-[1px]",
          active: "opacity-100 scale-100 filter blur-0",
        };
      case "fade-up":
      default:
        return {
          init: "opacity-0 translate-y-7",
          active: "opacity-100 translate-y-0",
        };
    }
  };

  const { init, active } = getVariantStyles();

  return (
    <div
      ref={elementRef}
      className={`transition-all ease-[cubic-bezier(0.16,1,0.3,1)] ${
        isVisible ? active : init
      } ${className}`}
      style={{
        transitionDuration: `${duration}ms`,
        transitionDelay: `${delay}ms`,
        willChange: isVisible ? "auto" : "transform, opacity",
      }}
    >
      {children}
    </div>
  );
}
