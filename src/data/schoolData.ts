export interface FacilityItem {
  id: string;
  title: string;
  badge: string;
  shortDesc: string;
  fullDesc: string;
  features: string[];
  isConfirmed: boolean;
  iconName: 'Camera' | 'MonitorPlay' | 'BookOpen' | 'ShieldCheck' | 'Sparkles';
}

export interface NoticeItem {
  id: string;
  title: string;
  date: string;
  category: 'Admissions' | 'Academic' | 'Safety' | 'General';
  summary: string;
  details: string;
  isImportant?: boolean;
}

import { GALLERY_ITEMS, GalleryItem } from "./galleryData";
export type { GalleryItem };

export interface AcademicStage {
  id: string;
  stageName: string;
  grades: string;
  focus: string;
  highlights: string[];
  description: string;
  curriculumPoints: string[];
}

export interface AdmissionStep {
  step: string;
  title: string;
  subtitle: string;
  description: string;
}

export const SCHOOL_DATA = {
  name: "Al-Qalam Public School",
  shortName: "Al-Qalam",
  tagline: "We Shape Your Future",
  mottoArabic: "الَّذِي عَلَّمَ بِالْقَلَمِ",
  mottoTranslation: "Who taught by the pen (Surah Al-Alaq)",
  institutionType: "Foundational & Primary School",
  affiliationStatus: "Independent Primary Institution",

  director: {
    name: "Kausar Jahan",
    title: "Director",
    roleDescription: "Executive leadership and administrative stewardship.",
    // Note: No personal quote is fabricated. Component uses institutional description.
    hasPersonalQuote: false,
    institutionalStatement:
      "Al-Qalam Public School was founded to offer children in Gulzarbagh and Patna a disciplined, caring, and values-centered start to formal schooling. Our objective is to develop sound foundational literacy, arithmetic comprehension, and moral character in every student.",
  },

  address: {
    line1: "Opposite Jashn Palace Marriage Hall",
    line2: "Agarwal Tola, Loharwa Ghat",
    street: "Ashok Rajpath Rd, Gulzarbagh",
    locality: "Alamganj",
    city: "Patna",
    state: "Bihar",
    pincode: "800007",
    landmark: "Opposite Jashn Palace Marriage Hall",
    fullAddress:
      "Opposite Jashn Palace Marriage Hall, Agarwal Tola, Loharwa Ghat, Ashok Rajpath Rd, Gulzarbagh, Alamganj, Patna, Bihar 800007",
    googleMapsUrl:
      "https://www.google.com/maps/search/?api=1&query=Opposite+Jashn+Palace+Marriage+Hall+Agarwal+Tola+Loharwa+Ghat+Ashok+Rajpath+Rd+Gulzarbagh+Alamganj+Patna+Bihar+800007",
    coordinates: {
      lat: 25.6025,
      lng: 85.1912,
    },
  },

  // Contact visibility policy: Only verified contact modes are rendered publicly.
  // Unverified placeholders like [Phone will be updated...] or fake emails are hidden.
  contact: {
    hasVerifiedPhone: false,
    phone: null as string | null,
    hasVerifiedEmail: false,
    email: null as string | null,
    hasVerifiedOfficeHours: false,
    officeHours: null as string | null,
    campusDeskNote:
      "Admissions, circulars, and general enquiries are received in person at the school administrative desk on Ashok Rajpath Rd during school operation hours.",
  },

  social: {
    facebook: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
    facebookPageId: "100066841958743",
  },

  brandColors: {
    deepForest: "#14532D",
    darkForest: "#0B3B20",
    mediumGreen: "#2F7D4A",
    softGreen: "#E8F3EA",
    cream: "#FAFAF9",
    warmBeige: "#E7E5E4",
    earthBrown: "#14532D",
    charcoal: "#292524",
    slate: "#57534E",
    lightBorder: "#E7E5E4",
    white: "#FFFFFF",
  },

  // 4 concise principles per prompt specifications
  whyAlQalam: [
    {
      id: "strong-foundations",
      title: "Strong Foundations",
      desc: "Systematic mastery of early literacy, phonics, number sense, and conceptual reasoning built step-by-step.",
      icon: "BookOpen" as const,
    },
    {
      id: "caring-mentorship",
      title: "Caring Mentorship",
      desc: "Patient, attentive teachers who understand young children and foster positive learning habits with respect.",
      icon: "Sparkles" as const,
    },
    {
      id: "smart-learning",
      title: "Smart Learning",
      desc: "Audio-visual smart classroom modules that illustrate core concepts with clarity and keep children engaged.",
      icon: "MonitorPlay" as const,
    },
    {
      id: "safe-disciplined-campus",
      title: "Safe & Disciplined Campus",
      desc: "A calm, structured learning sanctuary backed by monitored CCTV cameras across school corridors and entry gates.",
      icon: "ShieldCheck" as const,
    },
  ],

  confirmedFacilities: [
    {
      id: "smart-classes",
      title: "Interactive Smart Classes",
      badge: "Modern Learning",
      shortDesc: "Multimedia audio-visual teaching aids that make lessons clear, engaging, and memorable.",
      fullDesc:
        "Students learn through regular classroom practice, guided activities, and technology-supported lessons. Smart class modules allow teachers to demonstrate scientific concepts, mathematical patterns, and language stories visually.",
      features: [
        "Audio-visual multimedia learning modules",
        "Visual storytelling for foundational subjects",
        "Interactive diagrams reinforcing textbook lessons",
        "Encourages active student participation",
      ],
      isConfirmed: true,
      iconName: "MonitorPlay" as const,
    },
    {
      id: "cctv-monitoring",
      title: "Campus CCTV & Safety Oversight",
      badge: "Campus Safety",
      shortDesc: "Monitored security cameras safeguarding school entry points, gates, and corridors.",
      fullDesc:
        "Campus safety is an essential aspect of daily school management. Closed-circuit cameras monitor main entrance gates and primary hallways, supporting a secure, disciplined, and well-supervised school environment.",
      features: [
        "Monitored cameras covering campus gates and corridors",
        "Assists in maintaining disciplined school operations",
        "Supports child safety and structured campus movement",
        "Continuous supervision during school hours",
      ],
      isConfirmed: true,
      iconName: "Camera" as const,
    },
  ] as FacilityItem[],

  academicStages: [
    {
      id: "foundational-learning",
      stageName: "Foundational Learning",
      grades: "Pre-Primary / Kindergarten Levels",
      focus: "Language Readiness, Early Numeracy & Motor Skills",
      description:
        "A warm and encouraging introductory stage where young learners build curiosity, learn to communicate with confidence, and develop social and physical coordination through guided play and phonics.",
      highlights: [
        "Phonetic sound recognition and sensory letter writing",
        "Hands-on number counting and shape identification",
        "Social habits: sharing, listening, and polite expression",
        "Attentive supervision from caring early-childhood educators",
      ],
      curriculumPoints: [
        "Early English & Urdu phonetic awareness",
        "Pre-math tactile exercises & sorting games",
        "Gross & fine motor development activities",
        "Story listening & vocabulary enrichment",
      ],
    },
    {
      id: "primary-education",
      stageName: "Primary Education",
      grades: "Class 1 through Class 5",
      focus: "Conceptual Clarity, Core Literacy & Disciplined Habits",
      description:
        "Structured primary schooling combining language fluency, mathematics, environmental studies, and moral values. Lessons are reinforced with audio-visual Smart Class sessions to ensure deep conceptual grasp.",
      highlights: [
        "Smart Class visual demonstrations for science and arithmetic",
        "Grammar, vocabulary, and legible penmanship practice",
        "Environmental awareness and everyday problem-solving",
        "Character building, respect, honesty, and civic awareness",
      ],
      curriculumPoints: [
        "Languages: Reading comprehension, spelling, and oral expression",
        "Mathematics: Arithmetic operations, word problems, and logic",
        "Environmental Studies (EVS): Nature, community, and health",
        "Moral Science & General Knowledge: Values and awareness",
      ],
    },
  ] as AcademicStage[],

  admissionProcess: [
    {
      step: "01",
      title: "Enquiry",
      subtitle: "Submit enquiry form or visit campus",
      description:
        "Parents submit an online Admission Enquiry form or collect the enquiry prospectus from the school office at Ashok Rajpath Rd.",
    },
    {
      step: "02",
      title: "Interaction",
      subtitle: "Friendly parent & child dialogue",
      description:
        "A pleasant, informal interaction with our teachers to understand the child's developmental readiness and class placement.",
    },
    {
      step: "03",
      title: "Document Verification",
      subtitle: "Review of foundational documents",
      description:
        "Submission of the child's birth certificate, photographs, and parent address verification documents at the school desk.",
    },
    {
      step: "04",
      title: "Admission Confirmation",
      subtitle: "Registration & session start",
      description:
        "Formal enrollment completion, issuance of admission receipt, class section allocation, and syllabus orientation.",
    },
  ] as AdmissionStep[],

  notices: [] as NoticeItem[],

  galleryItems: GALLERY_ITEMS,

  navLinks: [
    { label: "Home", href: "/" },
    { label: "About", href: "/about" },
    { label: "Academics", href: "/academics" },
    { label: "Facilities", href: "/facilities" },
    { label: "Gallery", href: "/gallery" },
    { label: "Notices", href: "/notices" },
    { label: "Admissions", href: "/admissions" },
    { label: "Contact", href: "/contact" },
  ],
};
