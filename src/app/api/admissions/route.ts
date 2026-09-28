import { NextResponse } from "next/server";

const VALID_GRADES = [
  "Nursery / Pre-School",
  "Lower Kindergarten (LKG)",
  "Upper Kindergarten (UKG)",
  "Class 1",
  "Class 2",
  "Class 3",
  "Class 4",
  "Class 5",
];

const INDIAN_MOBILE_REGEX = /^[6-9]\d{9}$/;

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { studentName, parentName, mobile, grade, message } = body;

    const errors: Record<string, string> = {};

    // Validate student name
    const trimmedStudent = typeof studentName === "string" ? studentName.trim() : "";
    if (!trimmedStudent) {
      errors.studentName = "Student full name is required.";
    } else if (trimmedStudent.length < 2 || trimmedStudent.length > 70) {
      errors.studentName = "Student name must be between 2 and 70 characters.";
    }

    // Validate parent name
    const trimmedParent = typeof parentName === "string" ? parentName.trim() : "";
    if (!trimmedParent) {
      errors.parentName = "Parent or guardian name is required.";
    } else if (trimmedParent.length < 2 || trimmedParent.length > 70) {
      errors.parentName = "Parent/guardian name must be between 2 and 70 characters.";
    }

    // Validate mobile number
    const cleanMobile = typeof mobile === "string" ? mobile.replace(/\D/g, "") : "";
    if (!cleanMobile) {
      errors.mobile = "Contact mobile number is required.";
    } else if (!INDIAN_MOBILE_REGEX.test(cleanMobile)) {
      errors.mobile = "Please provide a valid 10-digit Indian mobile number (e.g., 9876543210).";
    }

    // Validate grade
    if (!grade || !VALID_GRADES.includes(grade)) {
      errors.grade = "Please select a valid class for admission.";
    }

    // Optional message sanitization
    const cleanMessage = typeof message === "string" ? message.trim().slice(0, 500) : "";

    if (Object.keys(errors).length > 0) {
      return NextResponse.json(
        {
          success: false,
          errors,
          message: "Please correct the highlighted fields.",
        },
        { status: 400 }
      );
    }

    // Generate reference ID with timestamp
    const referenceId = `AQPS-${Date.now().toString().slice(-6)}`;
    const submissionTime = new Date().toISOString();

    // Log structured lead server-side for school administration
    console.info("[Admissions Lead]", {
      referenceId,
      studentName: trimmedStudent,
      parentName: trimmedParent,
      mobile: `+91 ${cleanMobile}`,
      grade,
      hasMessage: Boolean(cleanMessage),
      submissionTime,
    });

    return NextResponse.json({
      success: true,
      referenceId,
      studentName: trimmedStudent,
      parentName: trimmedParent,
      grade,
      mobile: cleanMobile,
      submittedAt: submissionTime,
      message: "Admission enquiry registered successfully. School desk will contact you.",
    });
  } catch (error) {
    console.error("[Admissions API Error]", error);
    return NextResponse.json(
      {
        success: false,
        message: "An unexpected error occurred while processing your enquiry. Please try again or visit campus.",
      },
      { status: 500 }
    );
  }
}
