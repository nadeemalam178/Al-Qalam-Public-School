import { NextResponse } from "next/server";

const INDIAN_MOBILE_REGEX = /^[6-9]\d{9}$/;

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { name, mobile, message } = body;

    const errors: Record<string, string> = {};

    const trimmedName = typeof name === "string" ? name.trim() : "";
    if (!trimmedName) {
      errors.name = "Your full name is required.";
    } else if (trimmedName.length < 2 || trimmedName.length > 70) {
      errors.name = "Name must be between 2 and 70 characters.";
    }

    const cleanMobile = typeof mobile === "string" ? mobile.replace(/\D/g, "") : "";
    if (!cleanMobile) {
      errors.mobile = "Contact mobile number is required.";
    } else if (!INDIAN_MOBILE_REGEX.test(cleanMobile)) {
      errors.mobile = "Please provide a valid 10-digit Indian mobile number.";
    }

    const trimmedMessage = typeof message === "string" ? message.trim() : "";
    if (!trimmedMessage) {
      errors.message = "Please write your query or message.";
    } else if (trimmedMessage.length < 5 || trimmedMessage.length > 1000) {
      errors.message = "Message must be between 5 and 1000 characters.";
    }

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

    const referenceId = `CAMPUS-${Date.now().toString().slice(-6)}`;
    const submissionTime = new Date().toISOString();

    console.info("[Campus Contact Lead]", {
      referenceId,
      name: trimmedName,
      mobile: `+91 ${cleanMobile}`,
      submissionTime,
    });

    return NextResponse.json({
      success: true,
      referenceId,
      name: trimmedName,
      submittedAt: submissionTime,
      message: "Thank you for reaching out. The school desk at Ashok Rajpath Rd will attend to your query.",
    });
  } catch (error) {
    console.error("[Contact API Error]", error);
    return NextResponse.json(
      {
        success: false,
        message: "An unexpected error occurred while sending your message. Please try again.",
      },
      { status: 500 }
    );
  }
}
