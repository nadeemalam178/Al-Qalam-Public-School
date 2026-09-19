/**
 * Centralized Image Configuration for Al-Qalam Public School
 *
 * HOW TO REPLACE TEMPORARY SAMPLE IMAGES WITH REAL PHOTOGRAPHS:
 * -------------------------------------------------------------
 * 1. Drop your authentic school photo into the `/public/images/` directory
 *    using the same filename (e.g. `hero-sample.jpg` or `about-sample.jpg`).
 *    - OR -
 * 2. Add your new photo file (e.g. `my-real-school-exterior.jpg`) into `/public/images/`
 *    and update the corresponding path in the `schoolImages` object below.
 *
 * None of the components, layouts, or animation effects need to be rewritten.
 * All animations, responsive styles, and aspect ratios adapt automatically.
 */

export interface SchoolImageItem {
  id: string;
  src: string;
  alt: string;
  title: string;
  category: "Campus" | "Classroom" | "Facilities" | "Activities" | "Academics" | "Safety";
  description: string;
  tag: string;
}

export const schoolImages = {
  // Hero section background & visual highlight
  hero: {
    src: "/images/hero-sample.jpg",
    alt: "Al-Qalam Public School Campus Building in Gulzarbagh, Patna",
    caption: "Modern educational environment in Patna, Bihar",
    width: 1376,
    height: 768,
  },

  // About page & overview features
  about: {
    src: "/images/about-sample.jpg",
    alt: "Classroom learning atmosphere at Al-Qalam Public School",
    caption: "Attentive student mentoring and foundational literacy",
    width: 1200,
    height: 896,
  },

  // Smart Classes confirmed facility
  smartClass: {
    src: "/images/smart-class-sample.jpg",
    alt: "Interactive Smart Board in classroom at Al-Qalam Public School",
    caption: "Smart class digital technology facilitating interactive visual learning",
    width: 1200,
    height: 896,
  },

  // CCTV Monitoring confirmed facility
  cctv: {
    src: "/images/cctv-sample.jpg",
    alt: "CCTV security cameras and safety monitoring in school corridors",
    caption: "Continuous monitored safety surveillance for complete peace of mind",
    width: 1200,
    height: 896,
  },

  // Academics page & curriculum feature
  academics: {
    src: "/images/academics-sample.jpg",
    alt: "Students studying foundational mathematics and language in class",
    caption: "Structured foundational learning with dedicated mentorship",
    width: 1200,
    height: 896,
  },

  // Admission enquiry & counseling desk
  admission: {
    src: "/images/admission-sample.jpg",
    alt: "Al-Qalam Public School admission enquiry and counseling desk",
    caption: "Welcoming parent-teacher dialogue and admission desk",
    width: 1200,
    height: 896,
  },

  // Director's desk placeholder (Dignified leadership office placeholder - NO fake human face!)
  director: {
    src: "/images/director-placeholder.jpg",
    alt: "Director's office desk and leadership at Al-Qalam Public School",
    caption: "Office of Director Rahat Jahan",
    width: 1200,
    height: 896,
    isPlaceholder: true,
  },

  // Official school logo & crest suite
  branding: {
    primarySvg: "/branding/al-qalam-logo.svg",
    masterPng: "/branding/al-qalam-logo.png",
    lightSvg: "/branding/al-qalam-logo-light.svg",
    iconSvg: "/branding/al-qalam-icon.svg",
    faviconIco: "/branding/favicon.ico",
  },

  // Gallery collection of sample images
  gallery: [
    {
      id: "gal-1",
      src: "/images/gallery-01.jpg",
      alt: "Al-Qalam Public School Campus Facade",
      title: "School Campus & Architecture",
      category: "Campus" as const,
      description: "Clean, secure, and disciplined educational campus located in Gulzarbagh, Patna.",
      tag: "Campus Architecture",
    },
    {
      id: "gal-2",
      src: "/images/gallery-02.jpg",
      alt: "Active Classroom Mentoring",
      title: "Interactive Classroom Learning",
      category: "Classroom" as const,
      description: "Encouraging curiosity, active participation, and conceptual clarity in primary grades.",
      tag: "Foundational Learning",
    },
    {
      id: "gal-3",
      src: "/images/gallery-03.jpg",
      alt: "Interactive Smart Board Session",
      title: "Smart Class Technology",
      category: "Facilities" as const,
      description: "Digital audio-visual interactive smart boards bringing textbook concepts to life.",
      tag: "Smart Classes",
    },
    {
      id: "gal-4",
      src: "/images/gallery-04.jpg",
      alt: "Creative Art & Craft Session",
      title: "Creative Art & Expression",
      category: "Activities" as const,
      description: "Nurturing motor skills, imagination, and artistic expression through painting and crafts.",
      tag: "Creative Arts",
    },
    {
      id: "gal-5",
      src: "/images/gallery-05.jpg",
      alt: "Reading Corner & Library",
      title: "Student Reading Corner",
      category: "Academics" as const,
      description: "Developing early reading habits with diverse illustrated storybooks and reference readers.",
      tag: "Reading Corner",
    },
    {
      id: "gal-6",
      src: "/images/gallery-06.jpg",
      alt: "Monitored School Hallway & Corridors",
      title: "CCTV Campus Surveillance",
      category: "Safety" as const,
      description: "Continuous monitored cameras safeguarding corridors, gates, and school common areas.",
      tag: "Safety & Security",
    },
    {
      id: "gal-7",
      src: "/images/gallery-07.jpg",
      alt: "Campus Courtyard & Green Garden",
      title: "School Courtyard & Garden",
      category: "Campus" as const,
      description: "Fresh air, green surroundings, and safe outdoor circulation during break times.",
      tag: "Outdoor Courtyard",
    },
    {
      id: "gal-8",
      src: "/images/gallery-08.jpg",
      alt: "Digital Literacy & Computer Basics",
      title: "Digital Literacy Foundation",
      category: "Academics" as const,
      description: "Introducing foundational digital literacy, typing basics, and educational software.",
      tag: "Computer Basics",
    },
  ],
};
