import type { Metadata, Viewport } from "next";
import { Inter, Plus_Jakarta_Sans } from "next/font/google";
import Header from "@/components/Header";
import Footer from "@/components/Footer";
import MobileAppNav from "@/components/MobileAppNav";
import QuickHelpFloating from "@/components/QuickHelpFloating";
import { getSiteUrl } from "@/lib/siteConfig";
import "./globals.css";

const inter = Inter({
  subsets: ["latin"],
  display: "swap",
  variable: "--font-inter",
});

const plusJakartaSans = Plus_Jakarta_Sans({
  subsets: ["latin"],
  weight: ["500", "600", "700", "800"],
  display: "swap",
  variable: "--font-heading",
});

export const viewport: Viewport = {
  themeColor: "#14532D",
  width: "device-width",
  initialScale: 1,
  maximumScale: 5,
};

const siteUrl = getSiteUrl();

export const metadata: Metadata = {
  metadataBase: new URL(siteUrl),
  title: {
    default: "Al-Qalam Public School | Gulzarbagh, Patna",
    template: "%s | Al-Qalam Public School, Patna",
  },
  description:
    "Al-Qalam Public School is a trusted primary school in Gulzarbagh, Alamganj, Patna, Bihar. Foundational learning, interactive Smart Classes, and monitored campus safety.",
  keywords: [
    "Al-Qalam Public School",
    "Al Qalam Public School Patna",
    "school in Gulzarbagh",
    "school in Alamganj",
    "school on Ashok Rajpath",
    "primary school Patna",
    "smart classes school Patna",
  ],
  authors: [{ name: "Al-Qalam Public School Administration" }],
  creator: "Al-Qalam Public School",
  publisher: "Al-Qalam Public School",
  alternates: {
    canonical: "./",
  },
  verification: {
    google: "googlede28790a2b70fee9",
  },
  formatDetection: {
    email: false,
    address: true,
    telephone: true,
  },
  icons: {
    icon: [
      { url: "/favicon.ico", sizes: "any" },
      { url: "/logo.png", type: "image/png" },
      { url: "/icon.png", sizes: "512x512", type: "image/png" },
    ],
    shortcut: "/favicon.ico",
    apple: "/icon.png",
  },
  openGraph: {
    title: "Al-Qalam Public School | Gulzarbagh, Patna",
    description:
      "Where Learning Builds Character. Trusted foundational and primary education in Gulzarbagh, Patna with Smart Classes and CCTV campus oversight.",
    url: siteUrl,
    siteName: "Al-Qalam Public School",
    images: [
      {
        url: "/images/real/students-classroom.jpg",
        width: 1200,
        height: 900,
        alt: "Students attending class at Al-Qalam Public School, Gulzarbagh, Patna",
      },
    ],
    locale: "en_IN",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Al-Qalam Public School | Gulzarbagh, Patna",
    description:
      "Where Learning Builds Character. Trusted foundational and primary schooling in Gulzarbagh, Patna, Bihar.",
    images: ["/images/real/students-classroom.jpg"],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-video-preview": -1,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },
};

const jsonLd = {
  "@context": "https://schema.org",
  "@type": "EducationalOrganization",
  name: "Al-Qalam Public School",
  alternateName: "Al-Qalam School Patna",
  url: siteUrl,
  logo: `${siteUrl}/logo.png`,
  image: `${siteUrl}/images/real/students-classroom.jpg`,
  description:
    "Foundational and primary educational institution in Gulzarbagh, Alamganj, Patna, Bihar, providing disciplined learning, caring mentorship, and modern Smart Classes.",
  address: {
    "@type": "PostalAddress",
    streetAddress: "Opposite Jashn Palace Marriage Hall, Agarwal Tola, Loharwa Ghat, Ashok Rajpath Rd",
    addressLocality: "Gulzarbagh, Alamganj",
    addressRegion: "Bihar",
    postalCode: "800007",
    addressCountry: "IN",
  },
  geo: {
    "@type": "GeoCoordinates",
    latitude: 25.6025,
    longitude: 85.1912,
  },
  hasMap:
    "https://www.google.com/maps/search/?api=1&query=Opposite+Jashn+Palace+Marriage+Hall+Agarwal+Tola+Loharwa+Ghat+Ashok+Rajpath+Rd+Gulzarbagh+Alamganj+Patna+Bihar+800007",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={`${inter.variable} ${plusJakartaSans.variable} h-full antialiased`}>
      <head>
        <meta name="google-site-verification" content="googlede28790a2b70fee9" />
        <meta name="google-site-verification" content="googlede28790a2b70fee9.html" />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
      </head>
      <body className="min-h-full flex flex-col font-sans bg-white text-[#292524] selection:bg-[#14532D] selection:text-white relative">
        {/* Ambient atmospheric lighting orbs for depth & spatial feel */}
        <div className="fixed inset-0 pointer-events-none overflow-hidden -z-10" aria-hidden="true">
          <div className="absolute -top-24 -left-24 w-96 h-96 rounded-full bg-emerald-500/[0.07] blur-3xl animate-ambient-orb" />
          <div className="absolute top-1/3 -right-24 w-80 h-80 rounded-full bg-[#D9C2B0]/20 blur-3xl" />
          <div className="absolute bottom-10 left-1/4 w-96 h-96 rounded-full bg-emerald-600/[0.05] blur-3xl" />
        </div>

        <a
          href="#main-content"
          className="sr-only focus:not-sr-only focus:fixed focus:top-3 focus:left-3 focus:z-50 focus:px-4 focus:py-2 focus:bg-[#14532D] focus:text-white focus:rounded-md focus:shadow-lg focus:outline-none"
        >
          Skip to main content
        </a>
        <Header />
        <main id="main-content" className="flex-1 pb-16 md:pb-0">
          {children}
        </main>
        <Footer />
        {/* Floating Quick Helpline & WhatsApp Desk */}
        <QuickHelpFloating />
        {/* Mobile App-like Bottom Navigation Dock */}
        <MobileAppNav />
      </body>
    </html>
  );
}

