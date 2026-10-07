import { NextResponse } from "next/server";

interface GradeEligibility {
  minAgeYears: number;
  maxAgeYears: number;
  grade: string;
  category: "Foundational" | "Primary";
  monthlyTuition: string;
  annualCharges: string;
  documentsRequired: string[];
}

const GRADE_RULES: GradeEligibility[] = [
  {
    grade: "Nursery / Pre-School",
    category: "Foundational",
    minAgeYears: 3,
    maxAgeYears: 4,
    monthlyTuition: "₹750",
    annualCharges: "₹1,500",
    documentsRequired: [
      "Municipal / Hospital Birth Certificate",
      "Child's Aadhaar Card (if available)",
      "Parent's ID & Address Proof",
      "4 Recent Passport-size Photographs",
    ],
  },
  {
    grade: "Lower Kindergarten (LKG)",
    category: "Foundational",
    minAgeYears: 4,
    maxAgeYears: 5,
    monthlyTuition: "₹850",
    annualCharges: "₹1,500",
    documentsRequired: [
      "Birth Certificate",
      "Child & Parent Aadhaar Card",
      "Previous School Progress Card (if attended Pre-School)",
      "4 Passport-size Photographs",
    ],
  },
  {
    grade: "Upper Kindergarten (UKG)",
    category: "Foundational",
    minAgeYears: 5,
    maxAgeYears: 6,
    monthlyTuition: "₹950",
    annualCharges: "₹1,800",
    documentsRequired: [
      "Birth Certificate",
      "Transfer Certificate / LKG Report Card",
      "Child & Parent Aadhaar Card",
      "4 Passport-size Photographs",
    ],
  },
  {
    grade: "Class 1",
    category: "Primary",
    minAgeYears: 6,
    maxAgeYears: 7,
    monthlyTuition: "₹1,100",
    annualCharges: "₹2,000",
    documentsRequired: [
      "Birth Certificate & Aadhaar Card",
      "UKG Completion Marksheet / Report Card",
      "Transfer Certificate (TC)",
      "Parent ID & Address Proof",
    ],
  },
  {
    grade: "Class 2",
    category: "Primary",
    minAgeYears: 7,
    maxAgeYears: 8,
    monthlyTuition: "₹1,150",
    annualCharges: "₹2,000",
    documentsRequired: [
      "Class 1 Passed Report Card / Marksheet",
      "Transfer Certificate (Original)",
      "Child Aadhaar Card",
      "4 Passport-size Photographs",
    ],
  },
  {
    grade: "Class 3",
    category: "Primary",
    minAgeYears: 8,
    maxAgeYears: 9,
    monthlyTuition: "₹1,200",
    annualCharges: "₹2,200",
    documentsRequired: [
      "Class 2 Passed Report Card",
      "Transfer Certificate (Original)",
      "Child Aadhaar Card",
      "4 Passport-size Photographs",
    ],
  },
  {
    grade: "Class 4",
    category: "Primary",
    minAgeYears: 9,
    maxAgeYears: 10,
    monthlyTuition: "₹1,250",
    annualCharges: "₹2,200",
    documentsRequired: [
      "Class 3 Passed Report Card",
      "Transfer Certificate (Original)",
      "Child Aadhaar Card",
      "4 Passport-size Photographs",
    ],
  },
  {
    grade: "Class 5",
    category: "Primary",
    minAgeYears: 10,
    maxAgeYears: 11.5,
    monthlyTuition: "₹1,300",
    annualCharges: "₹2,200",
    documentsRequired: [
      "Class 4 Passed Report Card",
      "Transfer Certificate (Original)",
      "Child Aadhaar Card",
      "4 Passport-size Photographs",
    ],
  },
];

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { dob, sessionYear = 2026 } = body;

    if (!dob || typeof dob !== "string") {
      return NextResponse.json(
        { success: false, message: "Please select a valid Date of Birth." },
        { status: 400 }
      );
    }

    const birthDate = new Date(dob);
    if (isNaN(birthDate.getTime())) {
      return NextResponse.json(
        { success: false, message: "Invalid date format provided." },
        { status: 400 }
      );
    }

    // Cutoff reference: March 31st of the target academic year (NEP norm)
    const cutoffDate = new Date(Number(sessionYear), 2, 31); // Month 2 is March (0-indexed)

    if (birthDate > cutoffDate) {
      return NextResponse.json(
        {
          success: false,
          message: "Date of birth cannot be after the academic cutoff date (31st March).",
        },
        { status: 400 }
      );
    }

    // Calculate age in total months and years
    const diffMs = cutoffDate.getTime() - birthDate.getTime();
    const totalDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
    const totalYearsExact = totalDays / 365.25;
    const years = Math.floor(totalYearsExact);
    const months = Math.floor((totalYearsExact - years) * 12);

    // Find recommended grade
    let recommended = GRADE_RULES.find(
      (rule) => totalYearsExact >= rule.minAgeYears && totalYearsExact < rule.maxAgeYears
    );

    let statusText = "Eligible";
    let guidance = "";

    if (totalYearsExact < 3) {
      statusText = "Below Minimum Age";
      guidance = `Child is currently ${years}y ${months}m old. Minimum age for Nursery is 3 years as of 31st March ${sessionYear}. You may pre-register for upcoming academic sessions.`;
    } else if (totalYearsExact > 12) {
      statusText = "Above Primary Scope";
      recommended = GRADE_RULES[GRADE_RULES.length - 1];
      guidance = "Child is above the standard Class 5 age threshold. Special evaluation or direct interaction with Principal is recommended.";
    } else if (recommended) {
      guidance = `Based on NEP 2020 guidelines, your child is eligible for direct admission in ${recommended.grade} for session ${sessionYear}-${Number(sessionYear) + 1}.`;
    }

    return NextResponse.json({
      success: true,
      cutoffDate: `31st March ${sessionYear}`,
      ageCalculated: {
        years,
        months,
        totalYearsExact: Number(totalYearsExact.toFixed(1)),
        display: `${years} Years, ${months} Months`,
      },
      statusText,
      guidance,
      recommendedGrade: recommended ? recommended.grade : "Nursery / Pre-School",
      gradeDetails: recommended || null,
      nepCompliant: true,
      allGrades: GRADE_RULES.map((g) => ({
        grade: g.grade,
        ageBracket: `${g.minAgeYears}+ to ${g.maxAgeYears} Years`,
        category: g.category,
      })),
    });
  } catch (error) {
    console.error("[Eligibility Calculator Error]", error);
    return NextResponse.json(
      { success: false, message: "Error calculating admission eligibility." },
      { status: 500 }
    );
  }
}
