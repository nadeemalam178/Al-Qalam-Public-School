import type { Metadata, Viewport } from "next";
import { Inter } from "next/font/google";
import Header from "@/components/Header";
import Footer from "@/components/Footer";
import "./globals.css";

const inter = Inter({
  subsets: ["latin"],
  display: "swap",
  variable: "--font-inter",
});

export const viewport: Viewport = {
  themeColor: "#14532d",
  width: "device-width",
  initialScale: 1,
  maximumScale: 5,
};

export const metadata: Metadata = {
  metadataBase: new URL("https://alqalam-patna.edu.in"),
  title: {
    default: "Al-Qalam Public School | Gulzarbagh, Patna",
    template: "%s | Al-Qalam Public School, Patna",
  },
  description:
    "Al-Qalam Public School in Gulzarbagh, Alamganj, Patna, Bihar. Explore the school's academics, facilities, activities, admissions and contact information.",
  keywords: [
    "Al-Qalam Public School",
    "Al Qalam Patna",
    "Primary School Gulzarbagh",
    "School in Alamganj Patna",
    "Ashok Rajpath School",
    "Smart Classes School Patna",
    "CCTV Monitored School Patna",
  ],
  icons: {
    icon: [
      { url: "/favicon.ico", sizes: "any" },
      { url: "/branding/al-qalam-logo.svg", type: "image/svg+xml" },
      { url: "/icon.png", sizes: "512x512", type: "image/png" },
    ],
    shortcut: "/favicon.ico",
    apple: "/icon.png",
  },
  openGraph: {
    title: "Al-Qalam Public School | Gulzarbagh, Patna",
    description:
      "Official public portal for Al-Qalam Public School, Gulzarbagh, Alamganj, Patna. 'We Shape Your Future' with Smart Classes and CCTV campus safety.",
    url: "https://alqalam-patna.edu.in",
    siteName: "Al-Qalam Public School",
    images: [
      {
        url: "/branding/al-qalam-logo.png",
        width: 2048,
        height: 2048,
        alt: "Al-Qalam Public School Official Emblem",
      },
    ],
    locale: "en_IN",
    type: "website",
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={`${inter.variable} h-full antialiased`}>
      <body className="min-h-full flex flex-col font-sans bg-white text-stone-800 selection:bg-[#166534] selection:text-white">
        <Header />
        <main className="flex-1">{children}</main>
        <Footer />
      </body>
    </html>
  );
}
