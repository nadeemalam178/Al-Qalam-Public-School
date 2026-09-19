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

  // About page & overview features (Real classroom photo)
  about: {
    src: "/images/real/students-classroom.jpg",
    alt: "Al-Qalam Public School students learning inside classroom in Gulzarbagh",
    caption: "Real classroom learning atmosphere and attentive student mentoring",
    width: 2048,
    height: 1536,
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

  // Academics page & curriculum feature (Real classroom photo)
  academics: {
    src: "/images/real/students-classroom.jpg",
    alt: "Foundational primary students of Al-Qalam Public School",
    caption: "Structured foundational learning with dedicated teacher guidance",
    width: 2048,
    height: 1536,
  },

  // Admission enquiry & counseling desk
  admission: {
    src: "/images/admission-sample.jpg",
    alt: "Al-Qalam Public School admission enquiry and counseling desk",
    caption: "Admission guidance desk for parents in Gulzarbagh",
    width: 1200,
    height: 896,
  },

  // Director Rahat Jahan message section
  director: {
    src: "/images/director-placeholder.jpg",
    alt: "Director Rahat Jahan - Al-Qalam Public School",
    caption: "Office of Director Rahat Jahan",
    width: 1200,
    height: 896,
    isPlaceholder: true,
  },

  // Digitally Rebuilt Official School Banner
  rebuiltBanner: {
    src: "/images/rebuilt-school-banner.png",
    alt: "Al-Qalam Public School Rebuilt Official Banner",
    caption: "Official Al-Qalam Public School Banner with Urdu calligraphy and Arabic verse",
    width: 1920,
    height: 800,
  },

  // Official school logo & crest suite (Original authentic badge)
  branding: {
    primarySvg: "/logo.png",
    masterPng: "/logo.png",
    lightSvg: "/logo.png",
    iconSvg: "/icon.png",
    faviconIco: "/icon.png",
  },

  // Real School Photos & Gallery collection
  gallery: [
    {
      id: "real-1",
      src: "/images/real/drawing-competition.jpg",
      alt: "Drawing Competition 2023-24 at Al-Qalam Public School",
      title: "Annual Drawing Competition 2023-24",
      category: "Activities" as const,
      description: "Students proudly presenting their creative art entries in the school's annual drawing event.",
      tag: "School Event",
      isReal: true,
    },
    {
      id: "real-2",
      src: "/images/real/students-classroom.jpg",
      alt: "Students attending class in Al-Qalam Public School uniform",
      title: "Classroom Learning in Session",
      category: "Classroom" as const,
      description: "Disciplined and engaged primary learners in their green plaid school uniform.",
      tag: "Classroom Life",
      isReal: true,
    },
    {
      id: "real-3",
      src: "/images/real/educational-trip.jpg",
      alt: "Al-Qalam students on an educational field trip",
      title: "Educational Excursion & Field Trip",
      category: "Activities" as const,
      description: "Experiential learning beyond textbooks as students explore historical and cultural heritage.",
      tag: "Field Trip",
      isReal: true,
    },
    {
      id: "real-4",
      src: "/images/real/star-student-certificate.jpg",
      alt: "Student receiving Star of the Al-Qalam Certificate and Achievement Folder",
      title: "Star of the Al-Qalam Award",
      category: "Academics" as const,
      description: "Recognizing academic diligence, good conduct, and foundational excellence with medals and certificates.",
      tag: "Student Merit",
      isReal: true,
    },
    {
      id: "real-5",
      src: "/images/real/class-topper-certificate.jpg",
      alt: "Class Topper Annual Award with School Medal and Lanyard",
      title: "Annual Examination Class Topper",
      category: "Academics" as const,
      description: "Celebrating top performance in annual foundational examinations with official school honor medals.",
      tag: "Academic Topper",
      isReal: true,
    },
    {
      id: "gal-1",
      src: "/images/gallery-01.jpg",
      alt: "Al-Qalam Public School Campus Facade",
      title: "School Campus Environment",
      category: "Campus" as const,
      description: "Clean, secure, and disciplined educational campus located in Gulzarbagh, Patna.",
      tag: "Campus Architecture",
    },
    {
      id: "gal-3",
      src: "/images/smart-class-sample.jpg",
      alt: "Interactive Smart Board Session",
      title: "Interactive Smart Class Technology",
      category: "Facilities" as const,
      description: "Digital audio-visual interactive smart boards bringing textbook concepts to life.",
      tag: "Smart Classes",
    },
    {
      id: "gal-6",
      src: "/images/cctv-sample.jpg",
      alt: "Monitored School Hallway & Corridors",
      title: "CCTV Campus Surveillance",
      category: "Safety" as const,
      description: "Continuous monitored cameras safeguarding corridors, gates, and school common areas.",
      tag: "Safety & Security",
    },
  ],
};
