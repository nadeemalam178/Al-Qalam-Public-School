"use client";

import React from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { Home, BookOpen, Images, Sparkles, PhoneCall } from "lucide-react";

interface NavItem {
  name: string;
  href: string;
  icon: React.ComponentType<{ className?: string }>;
  badge?: string;
}

const navItems: NavItem[] = [
  { name: "Home", href: "/", icon: Home },
  { name: "Academics", href: "/academics", icon: BookOpen },
  { name: "Gallery", href: "/gallery", icon: Images, badge: "25+" },
  { name: "Admissions", href: "/admissions", icon: Sparkles, badge: "Open" },
  { name: "Contact", href: "/contact", icon: PhoneCall },
];

export default function MobileAppNav() {
  const pathname = usePathname();

  return (
    <nav
      aria-label="Mobile Bottom App Navigation"
      className="fixed bottom-0 left-0 right-0 z-50 md:hidden glass-dock border-t border-stone-200/70 pb-[env(safe-area-inset-bottom,0.5rem)] pt-1 px-2 transition-all duration-300 shadow-[0_-8px_30px_rgba(0,0,0,0.08)]"
    >
      <div className="flex items-center justify-around max-w-md mx-auto">
        {navItems.map((item) => {
          const isActive =
            item.href === "/" ? pathname === "/" : pathname.startsWith(item.href);
          const Icon = item.icon;

          return (
            <Link
              key={item.name}
              href={item.href}
              className={`relative flex flex-col items-center justify-center py-1.5 px-3 rounded-xl transition-all duration-200 active:scale-90 touch-manipulation group ${
                isActive
                  ? "text-[#14532D] font-bold"
                  : "text-stone-500 hover:text-stone-800 font-medium"
              }`}
            >
              {/* Active Indicator Glow Background */}
              {isActive && (
                <span className="absolute inset-0 bg-[#E8F3EA]/90 rounded-xl -z-10 shadow-xs scale-100 transition-all duration-300" />
              )}

              {/* Icon Container with Badge */}
              <div className="relative flex items-center justify-center">
                <Icon
                  className={`w-5 h-5 transition-transform duration-200 ${
                    isActive ? "scale-110 text-[#14532D]" : "group-hover:scale-105"
                  }`}
                />

                {item.badge && (
                  <span
                    className={`absolute -top-1.5 -right-3.5 px-1 py-0.2 rounded-full text-[9px] font-extrabold leading-tight shadow-xs ${
                      isActive
                        ? "bg-[#14532D] text-white"
                        : "bg-[#2F7D4A] text-white animate-pulse"
                    }`}
                  >
                    {item.badge}
                  </span>
                )}
              </div>

              {/* Label */}
              <span className="text-[10px] mt-0.5 tracking-tight">{item.name}</span>

              {/* Active Dot */}
              {isActive && (
                <span className="w-1 h-1 bg-[#14532D] rounded-full mt-0.5 animate-pulse" />
              )}
            </Link>
          );
        })}
      </div>
    </nav>
  );
}
