/**
 * Centralized Image Configuration for Al-Qalam Public School
 *
 * Prioritizes authentic school photographs from `/public/images/real/`
 * for the hero section, classroom previews, academic overviews, and gallery.
 */

export interface SchoolImageItem {
  id: string;
  src: string;
  alt: string;
  title: string;
  category: "Campus" | "Classroom" | "Facilities" | "Activities" | "Academics" | "Achievements" | "Events";
  description: string;
  tag: string;
  isReal?: boolean;
}

export const schoolImages = {
  // Hero section primary visual - Authentic students in classroom
  hero: {
    src: "/images/real/students-classroom.jpg",
    alt: "Students attending class in uniform at Al-Qalam Public School, Gulzarbagh, Patna",
    caption: "Authentic classroom atmosphere at Al-Qalam Public School",
    width: 2048,
    height: 1536,
  },

  // About page & institutional introduction
  about: {
    src: "/images/real/students-classroom.jpg",
    alt: "Students engaged in foundational lessons at Al-Qalam Public School",
    caption: "Caring classroom instruction and student mentorship in Gulzarbagh",
    width: 2048,
    height: 1536,
  },

  // School story & creative activities
  drawingCompetition: {
    src: "/images/real/drawing-competition.jpg",
    alt: "Students presenting their creative entries in the Annual Drawing Competition at Al-Qalam Public School",
    caption: "Annual Drawing Competition showcasing student creativity",
    width: 1200,
    height: 900,
  },

  // Educational excursion & field activities
  educationalTrip: {
    src: "/images/real/educational-trip.jpg",
    alt: "Students and teachers of Al-Qalam Public School on an educational field trip",
    caption: "Experiential learning and field trip excursion outside campus",
    width: 1600,
    height: 1200,
  },

  // Student merit and certificates
  starStudent: {
    src: "/images/real/star-student-certificate.jpg",
    alt: "Student receiving Star of the Al-Qalam merit certificate and medal",
    caption: "Star of the Al-Qalam recognition for diligence and conduct",
    width: 1200,
    height: 900,
  },

  // Class topper annual examination
  classTopper: {
    src: "/images/real/class-topper-certificate.jpg",
    alt: "Student holding Class Topper Certificate and honor medal at Al-Qalam Public School",
    caption: "Honoring academic excellence in foundational examinations",
    width: 1200,
    height: 900,
  },

  // Smart Classes verified facility
  smartClass: {
    src: "/images/smart-class-sample.jpg",
    alt: "Interactive Smart Class teaching module display at Al-Qalam Public School",
    caption: "Interactive audio-visual learning module",
    width: 1200,
    height: 896,
  },

  // CCTV Monitoring verified facility
  cctv: {
    src: "/images/cctv-sample.jpg",
    alt: "Campus CCTV security cameras and corridor monitoring at Al-Qalam Public School",
    caption: "Monitored campus surveillance supporting student safety",
    width: 1200,
    height: 896,
  },

  // Academics page feature
  academics: {
    src: "/images/real/students-classroom.jpg",
    alt: "Foundational primary students learning at Al-Qalam Public School",
    caption: "Structured foundational learning with dedicated teacher guidance",
    width: 2048,
    height: 1536,
  },

  // Admission enquiry desk
  admission: {
    src: "/images/admission-sample.jpg",
    alt: "Al-Qalam Public School campus admission enquiry desk",
    caption: "Admission guidance desk for parents in Gulzarbagh",
    width: 1200,
    height: 896,
  },

  // Director Rahat Jahan desk presentation
  director: {
    src: "/images/director-placeholder.jpg",
    alt: "Office of the Director, Al-Qalam Public School",
    caption: "Directorate of Al-Qalam Public School",
    width: 1200,
    height: 896,
    isPlaceholder: true,
  },

  // Digitally Rebuilt Official School Banner
  rebuiltBanner: {
    src: "/images/rebuilt-school-banner.png",
    alt: "Al-Qalam Public School Rebuilt Official Banner with Urdu calligraphy and Arabic motto",
    caption: "Official Al-Qalam Public School Banner with motto 'الَّذِي عَلَّمَ بِالْقَلَمِ'",
    width: 1920,
    height: 800,
  },

  // Official school logo & crest suite
  branding: {
    primarySvg: "/logo.png",
    masterPng: "/logo.png",
    lightSvg: "/logo.png",
    iconSvg: "/icon.png",
    faviconIco: "/icon.png",
  },
};
