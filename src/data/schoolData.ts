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

export interface GalleryItem {
  id: string;
  title: string;
  category: 'School' | 'Classroom' | 'Activities' | 'Events' | 'Facilities';
  description: string;
  tag: string;
  colorScheme: 'forest' | 'earth' | 'mediumGreen' | 'warmBrown' | 'navy' | 'gold' | 'crimson' | 'emerald';
}

export interface AcademicStage {
  id: string;
  stageName: string;
  grades: string;
  focus: string;
  highlights: string[];
  description: string;
}

export const SCHOOL_DATA = {
  name: "Al-Qalam Public School",
  tagline: "We Shape Your Future",
  mottoArabic: "الَّذِي عَلَّمَ بِالْقَلَمِ",
  mottoTranslation: "Who taught by the pen (Surah Al-Alaq)",
  director: {
    name: "Rahat Jahan",
    title: "Director",
    messagePlaceholder: "[Director's message will be added here.]",
  },
  address: {
    line1: "Opposite Jashn Palace Marriage Hall",
    line2: "Agarwal Tola, Loharwa Ghat",
    street: "Ashok Rajpath Rd, Gulzarbagh",
    locality: "Alamganj",
    city: "Patna",
    state: "Bihar",
    pincode: "800007",
    fullAddress: "Opposite Jashn Palace Marriage Hall, Agarwal Tola, Loharwa Ghat, Ashok Rajpath Rd, Gulzarbagh, Alamganj, Patna, Bihar 800007",
    googleMapsUrl: "https://www.google.com/maps/search/?api=1&query=Opposite+Jashn+Palace+Marriage+Hall+Agarwal+Tola+Loharwa+Ghat+Ashok+Rajpath+Rd+Gulzarbagh+Alamganj+Patna+Bihar+800007",
  },
  contactPlaceholders: {
    phone: "[Phone number will be updated by administration]",
    phoneDisplay: "+91 ••••• ••••• (Enquire at campus)",
    email: "[Email address will be updated by administration]",
    emailDisplay: "info@alqalam.placeholder (Campus desk)",
    officeHours: "[Office hours will be updated by administration]",
    officeHoursDisplay: "Monday – Saturday: Standard School Office Hours",
  },
  brand: {
    primaryDarkGreen: "#14532D",
    primaryGreen: "#166534",
    mediumGreen: "#2F7D4A",
    lightGreen: "#E8F3EA",
    creamBg: "#FAF8F2",
    earthBrown: "#6B4226",
    darkBrown: "#4A2C1A",
    lightBrown: "#EDE2D3",
  },
  socialPlaceholders: {
    note: "Official social media channels will be connected when verified links are published.",
  },
  confirmedFacilities: [
    {
      id: "cctv-monitoring",
      title: "CCTV Monitoring",
      badge: "Campus Safety",
      shortDesc: "Continuous security surveillance across key learning spaces and corridors.",
      fullDesc: "Student safety is an indispensable pillar of our educational environment. Our campus is equipped with closed-circuit television (CCTV) cameras covering school corridors, entrance gateways, and communal activity zones, ensuring monitored security and peace of mind for parents.",
      features: [
        "Monitored surveillance covering entry points & corridors",
        "Assists in maintaining disciplined school environment",
        "Supports child safety and campus oversight",
        "Proactive monitoring during school operation hours",
      ],
      isConfirmed: true,
      iconName: "Camera" as const,
    },
    {
      id: "smart-classes",
      title: "Smart Classes",
      badge: "Modern Learning",
      shortDesc: "Technology-supported classrooms designed to make concepts intuitive and interactive.",
      fullDesc: "We incorporate modern audio-visual technology and smart teaching aids to make classroom lessons engaging, visual, and participatory. Technology-enabled instruction helps young primary learners grasp complex concepts through animations, educational media, and interactive dialogue.",
      features: [
        "Audio-visual multimedia learning modules",
        "Visual storytelling for foundational concepts",
        "High-engagement interactive classroom sessions",
        "Fosters early curiosity and digital familiarity",
      ],
      isConfirmed: true,
      iconName: "MonitorPlay" as const,
    },
  ] as FacilityItem[],

  academicStages: [
    {
      id: "foundational-years",
      stageName: "Foundational Learning",
      grades: "Early Childhood (Pre-Primary / Kindergarten Levels)",
      focus: "Curiosity, Language Readiness, & Motor Development",
      description: "A nurturing, playful atmosphere where young learners develop listening, speaking, early phonics, number recognition, and social empathy in a comfortable setting.",
      highlights: [
        "Playful phonics and sensory alphabet activities",
        "Basic numeracy through visual and tactile objects",
        "Encouraging social bonding, sharing, and self-expression",
        "Supportive, attentive guidance from compassionate mentors",
      ],
    },
    {
      id: "primary-education",
      stageName: "Primary Education",
      grades: "Primary Classes (Foundational to Primary Standard)",
      focus: "Concept Clarity, Literacy, & Disciplined Habits",
      description: "Structured academic inquiry combining core subject learning—Languages, Mathematics, Environmental Studies, and Moral Values—with Smart Class visual reinforcement.",
      highlights: [
        "Smart-class visual lessons to solidify core fundamentals",
        "Reading comprehension, vocabulary, and neat penmanship",
        "Inquiry-based thinking and everyday problem solving",
        "Character building, respect, and collaborative classroom habits",
      ],
    },
  ] as AcademicStage[],

  notices: [
    {
      id: "notice-01",
      title: "Admission Enquiry Open for Upcoming Academic Session",
      date: "Current Session",
      category: "Admissions",
      summary: "Parents seeking admission for Foundational and Primary classes may submit an admission enquiry online or visit the school office.",
      details: "Al-Qalam Public School welcomes enquiries from parents for upcoming admissions. Please fill out the online Admission Enquiry form or visit the school premises at Ashok Rajpath Rd, Gulzarbagh, Alamganj, Patna. Exact seat availability and documentation checklists are accessible at the campus desk.",
      isImportant: true,
    },
    {
      id: "notice-02",
      title: "Smart Class Integration in Primary Learning Modules",
      date: "Academic Notice",
      category: "Academic",
      summary: "Technology-enabled Smart Class sessions are scheduled throughout the week to reinforce conceptual topics in science, mathematics, and language.",
      details: "Our audio-visual interactive modules are actively utilized across classes to enhance student comprehension. Parents are invited to discuss their child's engagement during regular parent-school interactions.",
      isImportant: false,
    },
    {
      id: "notice-03",
      title: "Campus Safety & CCTV Monitoring Protocol",
      date: "Safety Guidelines",
      category: "Safety",
      summary: "Security protocols and CCTV surveillance remain actively supervised across all campus premises for student safety.",
      details: "Campus access during school hours is monitored to maintain a secure and peaceful learning sanctuary for every child. Visitors are requested to register at the main gate.",
      isImportant: false,
    },
    {
      id: "notice-04",
      title: "Campus Desk & General Information Notice",
      date: "General Circular",
      category: "General",
      summary: "School circulars, uniform guidelines, and academic schedule details are available for review at the school administrative desk.",
      details: "For any administrative clarification, parent visits are accommodated during standard school office hours at our Gulzarbagh campus.",
      isImportant: false,
    },
  ] as NoticeItem[],

  galleryItems: [
    {
      id: "gal-01",
      title: "Smart Class Interactive Learning",
      category: "Classroom",
      tag: "Smart Classes",
      description: "Interactive audio-visual instruction bringing textbook concepts to life.",
      colorScheme: "forest",
    },
    {
      id: "gal-02",
      title: "School Campus & Learning Spaces",
      category: "School",
      tag: "Campus",
      description: "Safe, disciplined, and nurturing environment located in Gulzarbagh, Patna.",
      colorScheme: "earth",
    },
    {
      id: "gal-03",
      title: "Campus CCTV & Safety Oversight",
      category: "Facilities",
      tag: "CCTV Monitoring",
      description: "Proactive safety monitoring across all school corridors and entrance zones.",
      colorScheme: "mediumGreen",
    },
    {
      id: "gal-04",
      title: "Creative & Foundational Activities",
      category: "Activities",
      tag: "Child Development",
      description: "Hands-on projects and guided creative play that inspire curiosity.",
      colorScheme: "warmBrown",
    },
    {
      id: "gal-05",
      title: "Reading & Writing Development",
      category: "Classroom",
      tag: "Foundational Literacy",
      description: "Cultivating neat handwriting, vocabulary building, and phonics.",
      colorScheme: "forest",
    },
    {
      id: "gal-06",
      title: "School Observances & Student Gatherings",
      category: "Events",
      tag: "School Gatherings",
      description: "Morning assemblies and special cultural observances celebrating discipline.",
      colorScheme: "earth",
    },
  ] as GalleryItem[],

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
