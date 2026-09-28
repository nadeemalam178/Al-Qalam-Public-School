export interface GalleryItem {
  id: string;
  src: string;
  altSrcs?: string[];
  title: string;
  category: "Classroom" | "Activities" | "Events" | "Achievements" | "Campus" | "Facilities";
  tag: string;
  description: string;
  isReal: boolean;
  source?: string;
  sourceUrl?: string;
  year?: string;
}

export const GALLERY_ITEMS: GalleryItem[] = [
  {
    id: "rotary-shiksha-ratna-award",
    src: "/images/school/achievements/rotary-shiksha-ratna-award.jpg",
    altSrcs: [
      "/images/school/achievements/annual-exam-merit-shield.jpg",
      "/images/school/achievements/star-student-trophy-ceremony.jpg",
      "/images/school/achievements/annual-exam-merit-medal.jpg",
    ],
    title: "Rotary Shiksha Ratna Samman Recognition",
    category: "Achievements",
    tag: "State Honor",
    description:
      "Director Rahat Jahan receiving the Rotary Shiksha Ratna Samman from Shri Nitish Kumar (Hon'ble Chief Minister of Bihar) organized by Rotary Club Patna City on Teachers' Day, recognizing dedicated contributions to foundational education.",
    isReal: true,
    source: "Official Facebook Page",
    sourceUrl: "https://www.facebook.com/photo/?fbid=306944074876989",
    year: "2014",
  },
  {
    id: "annual-exam-merit-shield",
    src: "/images/school/achievements/annual-exam-merit-shield.jpg",
    altSrcs: [
      "/images/school/achievements/annual-exam-merit-medal.jpg",
      "/images/school/achievements/star-student-trophy-ceremony.jpg",
      "/images/school/achievements/annual-exam-star-of-alqalam.jpg",
    ],
    title: "Annual Examination Merit Awards Ceremony",
    category: "Achievements",
    tag: "Merit Shield",
    description:
      "Annual examination toppers recognized with academic merit shields and certificates for outstanding performance across all foundational subjects.",
    isReal: true,
    source: "Official Facebook Page",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
    year: "2024",
  },
  {
    id: "annual-quiz-competition",
    src: "/images/school/activities/annual-quiz-competition.jpg",
    altSrcs: [
      "/images/school/activities/quiz-participants.jpg",
      "/images/school/activities/quiz-round-team-session.jpg",
      "/images/school/activities/quiz-stage-presentation.jpg",
    ],
    title: "Annual Quiz & Computer Competition",
    category: "Activities",
    tag: "Academic Quiz",
    description:
      "Students actively engaged in the school's Annual Computer & Knowledge Quiz competition held on campus to encourage quick thinking and foundational logic.",
    isReal: true,
    source: "Official Facebook Page",
    sourceUrl: "https://www.facebook.com/photo.php?fbid=1361340482770671",
  },
  {
    id: "classroom-learning",
    src: "/images/school/classrooms/classroom-learning.jpg",
    altSrcs: [
      "/images/school/classrooms/interactive-classroom-session.jpg",
    ],
    title: "Active Classroom Learning in Session",
    category: "Classroom",
    tag: "Foundational",
    description:
      "Primary students seated with notebooks, attending structured foundational lessons in their official green plaid school uniforms.",
    isReal: true,
    source: "School Archive",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
  },
  {
    id: "educational-tour-bapu-tower",
    src: "/images/school/events/educational-tour-bapu-tower.jpg",
    altSrcs: [
      "/images/school/events/educational-tour-eco-park.jpg",
      "/images/school/events/museum-educational-trip.jpg",
      "/images/school/events/students-educational-excursion.jpg",
    ],
    title: "Annual Educational Tour: Visit to Bapu Tower",
    category: "Events",
    tag: "Study Excursion",
    description:
      "Al-Qalam Public School students on a guided educational excursion to Bapu Tower in Patna, learning about Mahatma Gandhi's life and national history.",
    isReal: true,
    source: "Official Facebook Page",
    sourceUrl: "https://www.facebook.com/permalink.php?story_fbid=pfbid0&id=100066841958743",
  },
  {
    id: "star-student-trophy-ceremony",
    src: "/images/school/achievements/star-student-trophy-ceremony.jpg",
    altSrcs: [
      "/images/school/achievements/annual-exam-merit-shield.jpg",
      "/images/school/achievements/star-of-the-week-merit.jpg",
      "/images/school/achievements/student-academic-excellence.jpg",
    ],
    title: "Star of Al-Qalam Trophy Presentation",
    category: "Achievements",
    tag: "Star Achiever",
    description:
      "Honoring distinguished student achievers with trophies and certificates for all-round excellence, integrity, and peer mentorship.",
    isReal: true,
    source: "Official Facebook Page",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
    year: "2024",
  },
  {
    id: "annual-drawing-competition",
    src: "/images/school/activities/annual-drawing-competition.jpg",
    altSrcs: [
      "/images/school/activities/drawing-competition-session.jpg",
    ],
    title: "Annual Drawing & Painting Exhibition",
    category: "Activities",
    tag: "Creative Arts",
    description:
      "Students proudly displaying their creative paintings and crayon artwork during the school's annual drawing competition in Gulzarbagh.",
    isReal: true,
    source: "Official Facebook Page & School Archive",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
    year: "2023-24",
  },
  {
    id: "educational-tour-eco-park",
    src: "/images/school/events/educational-tour-eco-park.jpg",
    altSrcs: [
      "/images/school/events/educational-tour-bapu-tower.jpg",
      "/images/school/events/students-educational-excursion.jpg",
    ],
    title: "Nature & Environmental Tour: Eco Park",
    category: "Events",
    tag: "Nature Tour",
    description:
      "Students exploring Eco Park during the school's annual outdoor environmental learning trip, observing native plants and lake ecology.",
    isReal: true,
    source: "Official Facebook Page",
    sourceUrl: "https://www.facebook.com/permalink.php?story_fbid=pfbid1&id=100066841958743",
  },
  {
    id: "writing-competition-winner",
    src: "/images/school/activities/writing-competition-winner.jpg",
    altSrcs: [
      "/images/school/achievements/class-topper-award.jpg",
      "/images/school/achievements/merit-certificate-recognition.jpg",
    ],
    title: "School Writing Competition Winner",
    category: "Activities",
    tag: "Penmanship",
    description:
      "Student recognized with an award certificate for exemplary penmanship, neat handwriting, and language proficiency in the annual contest.",
    isReal: true,
    source: "Official Facebook Page",
    sourceUrl: "https://www.facebook.com/photo.php?fbid=1361340859437300",
  },
  {
    id: "quiz-participants",
    src: "/images/school/activities/quiz-participants.jpg",
    altSrcs: [
      "/images/school/activities/quiz-round-team-session.jpg",
      "/images/school/activities/quiz-stage-presentation.jpg",
      "/images/school/activities/annual-quiz-competition.jpg",
    ],
    title: "Quiz Round Participant Teams",
    category: "Activities",
    tag: "Student Teams",
    description:
      "Student teams seated in classroom formation during the inter-class general knowledge and computer quiz rounds.",
    isReal: true,
    source: "Official Facebook Page",
    sourceUrl: "https://www.facebook.com/photo.php?fbid=1361342729437113",
  },
  {
    id: "annual-exam-merit-medal",
    src: "/images/school/achievements/annual-exam-merit-medal.jpg",
    altSrcs: [
      "/images/school/achievements/annual-exam-merit-shield.jpg",
      "/images/school/achievements/star-student-certificate.jpg",
    ],
    title: "Academic Excellence Medal Felicitation",
    category: "Achievements",
    tag: "Merit Medal",
    description:
      "Class toppers receiving medals and honors during the school's annual academic felicitation program.",
    isReal: true,
    source: "Official Facebook Page",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
    year: "2024",
  },
  {
    id: "interactive-classroom-session",
    src: "/images/school/classrooms/interactive-classroom-session.jpg",
    altSrcs: [
      "/images/school/classrooms/classroom-learning.jpg",
    ],
    title: "Interactive Classroom Study Dynamics",
    category: "Classroom",
    tag: "Foundational",
    description:
      "Interactive foundational class sessions encouraging peer learning, curiosity, and respectful classroom habits.",
    isReal: true,
    source: "School Archive",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
  },
  {
    id: "school-campus-exterior",
    src: "/images/school/campus/school-campus-exterior.jpg",
    altSrcs: [
      "/images/school/campus/school-gate-entrance-banner.jpg",
      "/images/school/campus/official-facebook-cover-banner.jpg",
    ],
    title: "School Campus Exterior & Courtyard",
    category: "Campus",
    tag: "Loharwa Ghat",
    description:
      "Authentic exterior view of the school building located on Ashok Rajpath Road, opposite Jashn Palace, Gulzarbagh, Patna.",
    isReal: true,
    source: "School Archive",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
  },
  {
    id: "school-gate-entrance-banner",
    src: "/images/school/campus/school-gate-entrance-banner.jpg",
    altSrcs: [
      "/images/school/campus/school-campus-exterior.jpg",
      "/images/school/campus/official-facebook-cover-banner.jpg",
    ],
    title: "School Entrance & Official Gate Banner",
    category: "Campus",
    tag: "Main Gate",
    description:
      "Official entrance banner displaying school registration, foundational curriculum details, and institutional contact guidance.",
    isReal: true,
    source: "School Archive",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
  },
  {
    id: "independence-day-celebration",
    src: "/images/school/events/independence-day-celebration.jpg",
    altSrcs: [
      "/images/school/students/students-group-assembly.jpg",
    ],
    title: "Independence Day Tricolor Flag Honors",
    category: "Events",
    tag: "National Day",
    description:
      "Students and staff celebrating Independence Day with patriotic songs, speeches, and flag honors in the campus courtyard.",
    isReal: true,
    source: "School Archive",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
    year: "2024",
  },
  {
    id: "museum-educational-trip",
    src: "/images/school/events/museum-educational-trip.jpg",
    altSrcs: [
      "/images/school/events/educational-tour-bapu-tower.jpg",
      "/images/school/events/students-educational-excursion.jpg",
    ],
    title: "Patna Museum Historical Excursion",
    category: "Events",
    tag: "Heritage Trip",
    description:
      "Students exploring historical artifacts, ancient coins, and state heritage exhibits at the Patna Museum.",
    isReal: true,
    source: "School Archive",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
  },
  {
    id: "star-of-the-week-merit",
    src: "/images/school/achievements/star-of-the-week-merit.jpg",
    altSrcs: [
      "/images/school/achievements/star-student-certificate.jpg",
      "/images/school/achievements/class-topper-award.jpg",
    ],
    title: "Star of the Week Discipline & Merit Citation",
    category: "Achievements",
    tag: "Weekly Merit",
    description:
      "Weekly student merit recognition for punctuality, neat classroom work, and helpful behavior among classmates.",
    isReal: true,
    source: "School Archive",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
  },
  {
    id: "student-academic-excellence",
    src: "/images/school/achievements/student-academic-excellence.jpg",
    altSrcs: [
      "/images/school/achievements/merit-certificate-recognition.jpg",
      "/images/school/achievements/class-topper-award.jpg",
    ],
    title: "Academic Distinction Recognition",
    category: "Achievements",
    tag: "Term Honors",
    description:
      "Student proudly displaying a certificate of distinction for outstanding marks in term summative assessments.",
    isReal: true,
    source: "School Archive",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
  },
  {
    id: "students-group-assembly",
    src: "/images/school/students/students-group-assembly.jpg",
    altSrcs: [
      "/images/school/events/independence-day-celebration.jpg",
    ],
    title: "Morning Assembly & Unified Student Cohort",
    category: "Campus",
    tag: "Assembly",
    description:
      "Students assembled in uniform for morning assembly, moral thought of the day, and national anthem.",
    isReal: true,
    source: "School Archive",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
  },
  {
    id: "official-facebook-cover-banner",
    src: "/images/school/campus/official-facebook-cover-banner.jpg",
    altSrcs: [
      "/images/school/campus/school-campus-exterior.jpg",
    ],
    title: "Official Institutional Visual & Motto",
    category: "Campus",
    tag: "Emblem",
    description:
      "Official institutional banner featuring the Al-Qalam school crest, foundational motto, and location details in Gulzarbagh.",
    isReal: true,
    source: "Official Facebook Page",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
  },
  {
    id: "drawing-competition-session",
    src: "/images/school/activities/drawing-competition-session.jpg",
    altSrcs: [
      "/images/school/activities/annual-drawing-competition.jpg",
    ],
    title: "Artistic Expression & Painting Session",
    category: "Activities",
    tag: "Creativity",
    description:
      "Young artists expressing their imagination through color sketching and nature landscapes during the art competition.",
    isReal: true,
    source: "School Archive",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
  },
  {
    id: "quiz-round-team-session",
    src: "/images/school/activities/quiz-round-team-session.jpg",
    altSrcs: [
      "/images/school/activities/quiz-stage-presentation.jpg",
      "/images/school/activities/annual-quiz-competition.jpg",
    ],
    title: "Rapid Fire Quiz & Logic Problem Solving",
    category: "Activities",
    tag: "Logic Round",
    description:
      "Students collaborating in teams during rapid-fire quiz rounds testing foundational math, science, and current events.",
    isReal: true,
    source: "Official Facebook Page",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
  },
  {
    id: "quiz-stage-presentation",
    src: "/images/school/activities/quiz-stage-presentation.jpg",
    altSrcs: [
      "/images/school/activities/annual-quiz-competition.jpg",
      "/images/school/activities/quiz-participants.jpg",
    ],
    title: "Quiz Finalists Stage Presentation",
    category: "Activities",
    tag: "Stage Final",
    description:
      "Finalist teams presenting their answers before peers and teachers in the concluding round of the annual quiz contest.",
    isReal: true,
    source: "Official Facebook Page",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
  },
  {
    id: "students-educational-excursion",
    src: "/images/school/events/students-educational-excursion.jpg",
    altSrcs: [
      "/images/school/events/educational-tour-bapu-tower.jpg",
      "/images/school/events/educational-tour-eco-park.jpg",
    ],
    title: "Annual Educational Study Tour Cohort",
    category: "Events",
    tag: "Annual Excursion",
    description:
      "Students gathering outside excursion destination sites in Patna, accompanied by supervising teachers.",
    isReal: true,
    source: "School Archive",
    sourceUrl: "https://www.facebook.com/p/Al-Qalam-Public-School-100066841958743/",
  },
  {
    id: "smart-classes",
    src: "/images/smart-class-sample.jpg",
    altSrcs: [
      "/images/school/classrooms/classroom-learning.jpg",
      "/images/school/classrooms/interactive-classroom-session.jpg",
    ],
    title: "Smart Class Audio-Visual Learning",
    category: "Facilities",
    tag: "Technology",
    description:
      "Digital learning tools and audio-visual instructional methods that make foundational science and mathematics concepts intuitive.",
    isReal: false,
    source: "Facility Documentation",
  },
  {
    id: "campus-safety-cctv",
    src: "/images/cctv-sample.jpg",
    altSrcs: [
      "/images/school/campus/school-campus-exterior.jpg",
    ],
    title: "Monitored Safety & Campus Security",
    category: "Facilities",
    tag: "Security",
    description:
      "24/7 CCTV surveillance across campus gates, common corridors, and activity areas for comprehensive student safety.",
    isReal: false,
    source: "Facility Documentation",
  },
];

export interface SchoolEventItem {
  id: string;
  title: string;
  category: "Academic" | "Activities" | "Events" | "Achievements" | "Celebrations";
  date: string;
  year?: string;
  image: string;
  altImages?: string[];
  description: string;
  highlight?: boolean;
  citation?: string;
}

export const VERIFIED_SCHOOL_EVENTS: SchoolEventItem[] = [
  {
    id: "rotary-shiksha-ratna",
    title: "Rotary Shiksha Ratna Samman Presented by Hon'ble CM Nitish Kumar",
    category: "Achievements",
    date: "5 September",
    year: "2014",
    image: "/images/school/achievements/rotary-shiksha-ratna-award.jpg",
    altImages: [
      "/images/school/achievements/annual-exam-merit-shield.jpg",
      "/images/school/achievements/star-student-trophy-ceremony.jpg",
    ],
    description:
      "Director Rahat Jahan was honored with the Rotary Shiksha Ratna Samman by Shri Nitish Kumar (Chief Minister of Bihar) at a grand ceremony organized by Rotary Club Patna City on Teachers' Day, acknowledging impactful foundational education.",
    highlight: true,
    citation: "Teachers' Day State Felicitation, Patna City",
  },
  {
    id: "annual-quiz-competition-event",
    title: "Annual Computer & Knowledge Quiz Competition",
    category: "Activities",
    date: "9 August",
    image: "/images/school/activities/annual-quiz-competition.jpg",
    altImages: [
      "/images/school/activities/quiz-participants.jpg",
      "/images/school/activities/quiz-round-team-session.jpg",
      "/images/school/activities/quiz-stage-presentation.jpg",
    ],
    description:
      "Students competed in team-based rounds testing rapid reasoning, basic computer science concepts, and general awareness, building early intellectual curiosity.",
    citation: "Official Annual Quiz Contest",
  },
  {
    id: "annual-exam-toppers-event",
    title: "Annual Examination Toppers & Star of Al-Qalam Awards",
    category: "Achievements",
    date: "13 March",
    image: "/images/school/achievements/annual-exam-merit-shield.jpg",
    altImages: [
      "/images/school/achievements/annual-exam-merit-medal.jpg",
      "/images/school/achievements/star-student-trophy-ceremony.jpg",
      "/images/school/achievements/annual-exam-star-of-alqalam.jpg",
    ],
    description:
      "Annual felicitation ceremony honoring class toppers, 100% attendance achievers, and bestowing the Star of Al-Qalam trophy upon outstanding students.",
    citation: "Annual Examination Felicitation Ceremony",
  },
  {
    id: "bapu-tower-tour-event",
    title: "Educational Study Tour to Bapu Tower, Patna",
    category: "Events",
    date: "16 November",
    image: "/images/school/events/educational-tour-bapu-tower.jpg",
    altImages: [
      "/images/school/events/educational-tour-eco-park.jpg",
      "/images/school/events/museum-educational-trip.jpg",
    ],
    description:
      "An experiential learning tour to the iconic Bapu Tower in Patna, connecting students directly with Mahatma Gandhi's philosophy, historical exhibits, and values.",
    citation: "Annual Educational Study Tour",
  },
  {
    id: "eco-park-tour-event",
    title: "Environmental Study Excursion to Eco Park",
    category: "Events",
    date: "16 November",
    image: "/images/school/events/educational-tour-eco-park.jpg",
    altImages: [
      "/images/school/events/educational-tour-bapu-tower.jpg",
      "/images/school/events/students-educational-excursion.jpg",
    ],
    description:
      "Students explored ecological biodiversity, lake conservation, and outdoor botany during the annual school nature field trip.",
    citation: "Annual Environmental Study Excursion",
  },
  {
    id: "writing-competition-event",
    title: "Annual Writing & Penmanship Competition",
    category: "Activities",
    date: "29 January",
    image: "/images/school/activities/writing-competition-winner.jpg",
    altImages: [
      "/images/school/activities/annual-drawing-competition.jpg",
    ],
    description:
      "Recognizing handwriting discipline, neatness, creative sentence formulation, and language proficiency among primary students.",
    citation: "School Writing Competition",
  },
  {
    id: "drawing-competition-event",
    title: "Annual Drawing & Creative Arts Competition",
    category: "Activities",
    date: "Annual Session",
    year: "2023-24",
    image: "/images/school/activities/annual-drawing-competition.jpg",
    altImages: [
      "/images/school/activities/drawing-competition-session.jpg",
    ],
    description:
      "Creative color painting contest encouraging creative imagination, color coordination, and self-expression in primary classes.",
    citation: "Annual Art & Drawing Session",
  },
];
