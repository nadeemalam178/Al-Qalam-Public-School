"use client";

import React, { useEffect, useRef, useState } from "react";

export type AnimationVariant =
  | "fade-up"
  | "fade-down"
  | "fade-left"
  | "fade-right"
  | "scale-in";

interface ScrollRevealProps {
  children: React.ReactNode;
  variant?: AnimationVariant;
  delay?: number;
  duration?: number;
  className?: string;
  threshold?: number;
  once?: boolean;
}

export default function ScrollReveal({
  children,
  variant = "fade-up",
  delay = 0,
  duration = 450,
  className = "",
  threshold = 0.1,
  once = true,
}: ScrollRevealProps) {
  const [isVisible, setIsVisible] = useState(false);
  const elementRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
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
        rootMargin: "0px 0px -20px 0px",
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

  const getVariantStyles = (): { init: string; active: string } => {
    switch (variant) {
      case "fade-down":
        return {
          init: "opacity-0 -translate-y-4",
          active: "opacity-100 translate-y-0",
        };
      case "fade-left":
        return {
          init: "opacity-0 -translate-x-4",
          active: "opacity-100 translate-x-0",
        };
      case "fade-right":
        return {
          init: "opacity-0 translate-x-4",
          active: "opacity-100 translate-x-0",
        };
      case "scale-in":
        return {
          init: "opacity-0 scale-98",
          active: "opacity-100 scale-100",
        };
      case "fade-up":
      default:
        return {
          init: "opacity-0 translate-y-4",
          active: "opacity-100 translate-y-0",
        };
    }
  };

  const { init, active } = getVariantStyles();

  return (
    <div
      ref={elementRef}
      className={`transition-all ease-out ${
        isVisible ? active : init
      } ${className}`}
      style={{
        transitionDuration: `${duration}ms`,
        transitionDelay: `${delay}ms`,
      }}
    >
      {children}
    </div>
  );
}
