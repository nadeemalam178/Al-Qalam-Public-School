"use client";

import React, { useState } from "react";
import { Send, CheckCircle2, AlertCircle, RefreshCw, User, Users, Phone, School, MessageSquare } from "lucide-react";

interface FormState {
  studentName: string;
  parentName: string;
  mobile: string;
  grade: string;
  message: string;
}

interface FormErrors {
  studentName?: string;
  parentName?: string;
  mobile?: string;
  grade?: string;
  general?: string;
}

interface SubmissionResult {
  referenceId: string;
  studentName: string;
  parentName: string;
  grade: string;
  mobile: string;
  submittedAt: string;
}

const gradeOptions = [
  "Select Class",
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

export default function AdmissionForm() {
  const [formData, setFormData] = useState<FormState>({
    studentName: "",
    parentName: "",
    mobile: "",
    grade: "",
    message: "",
  });

  const [errors, setErrors] = useState<FormErrors>({});
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submissionResult, setSubmissionResult] = useState<SubmissionResult | null>(null);

  const validate = (): boolean => {
    const errs: FormErrors = {};

    const trimmedStudent = formData.studentName.trim();
    if (!trimmedStudent) {
      errs.studentName = "Please enter student's full name.";
    } else if (trimmedStudent.length < 2) {
      errs.studentName = "Student name must be at least 2 characters.";
    } else if (trimmedStudent.length > 70) {
      errs.studentName = "Student name cannot exceed 70 characters.";
    }

    const trimmedParent = formData.parentName.trim();
    if (!trimmedParent) {
      errs.parentName = "Please enter parent or guardian's full name.";
    } else if (trimmedParent.length < 2) {
      errs.parentName = "Parent/guardian name must be at least 2 characters.";
    } else if (trimmedParent.length > 70) {
      errs.parentName = "Parent name cannot exceed 70 characters.";
    }

    const cleanMobile = formData.mobile.replace(/\D/g, "");
    if (!cleanMobile) {
      errs.mobile = "Please provide a contact mobile number.";
    } else if (!INDIAN_MOBILE_REGEX.test(cleanMobile)) {
      errs.mobile = "Please enter a valid 10-digit Indian mobile number (e.g., 9876543210).";
    }

    if (!formData.grade || formData.grade === "Select Class") {
      errs.grade = "Please select the target class for admission.";
    }

    setErrors(errs);
    return Object.keys(errs).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (isSubmitting) return;

    if (!validate()) {
      return;
    }

    setIsSubmitting(true);
    setErrors({});

    try {
      const response = await fetch("/api/admissions", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          studentName: formData.studentName.trim(),
          parentName: formData.parentName.trim(),
          mobile: formData.mobile.replace(/\D/g, ""),
          grade: formData.grade,
          message: formData.message.trim(),
        }),
      });

      const data = await response.json();

      if (!response.ok || !data.success) {
        if (data.errors) {
          setErrors(data.errors);
        } else {
          setErrors({
            general: data.message || "Failed to submit enquiry. Please try again or visit campus.",
          });
        }
        setIsSubmitting(false);
        return;
      }

      setSubmissionResult({
        referenceId: data.referenceId,
        studentName: data.studentName,
        parentName: data.parentName,
        grade: data.grade,
        mobile: data.mobile,
        submittedAt: data.submittedAt,
      });
      setIsSubmitting(false);
    } catch (err) {
      console.error("Submission error:", err);
      setErrors({
        general: "Network error occurred while submitting enquiry. Please check connection or visit campus desk.",
      });
      setIsSubmitting(false);
    }
  };

  const handleReset = () => {
    setFormData({
      studentName: "",
      parentName: "",
      mobile: "",
      grade: "",
      message: "",
    });
    setErrors({});
    setSubmissionResult(null);
  };

  if (submissionResult) {
    return (
      <div className="bg-white rounded-2xl border border-[#2F7D4A]/40 p-6 sm:p-8 shadow-sm text-center">
        <div className="w-14 h-14 bg-[#E8F3EA] text-[#14532D] rounded-full flex items-center justify-center mx-auto mb-4 border border-[#2F7D4A]/30">
          <CheckCircle2 className="w-8 h-8" />
        </div>

        <span className="inline-block px-3 py-1 bg-[#E8F3EA] text-[#14532D] text-xs font-semibold rounded-md mb-2 border border-[#2F7D4A]/25">
          Enquiry Registered
        </span>

        <h3 className="font-heading font-black text-xl sm:text-2xl text-[#14532D] mb-2">
          Thank You, {submissionResult.parentName}
        </h3>

        <p className="text-sm text-stone-600 max-w-md mx-auto mb-6 leading-relaxed">
          Your admission enquiry for{" "}
          <strong className="text-stone-800">{submissionResult.studentName}</strong> (
          {submissionResult.grade}) has been successfully received by the school administrative desk.
        </p>

        <div className="bg-[#FAF8F2] border border-[#EDE2D3] rounded-xl p-4 max-w-sm mx-auto mb-6 text-left text-xs space-y-2">
          <div className="flex justify-between font-mono text-stone-800 text-sm font-bold border-b border-[#EDE2D3] pb-1.5">
            <span>Enquiry ID:</span>
            <span className="text-[#14532D]">{submissionResult.referenceId}</span>
          </div>
          <div className="flex justify-between text-stone-600">
            <span>Contact Mobile:</span>
            <span className="font-medium text-stone-800">+91 {submissionResult.mobile}</span>
          </div>
          <div className="flex justify-between text-stone-600">
            <span>Status:</span>
            <span className="text-[#166534] font-semibold">Under Administrative Review</span>
          </div>
          <div className="flex justify-between text-stone-500 text-[11px] pt-1">
            <span>Campus:</span>
            <span>Ashok Rajpath Rd, Gulzarbagh</span>
          </div>
        </div>

        <div className="p-3 bg-[#E8F3EA]/70 rounded-lg border border-[#2F7D4A]/20 text-xs text-stone-700 max-w-md mx-auto mb-6 leading-relaxed">
          <strong className="text-[#14532D]">Next Step:</strong> You may visit the campus desk along with the student&apos;s birth certificate copy during school office hours for document verification.
        </div>

        <button
          onClick={handleReset}
          className="inline-flex items-center gap-2 px-5 py-2.5 rounded-lg text-xs font-semibold text-stone-700 bg-[#FAF8F2] border border-[#EDE2D3] hover:bg-white transition-colors cursor-pointer"
        >
          <RefreshCw className="w-3.5 h-3.5 text-[#6B4226]" />
          <span>Submit Another Enquiry</span>
        </button>
      </div>
    );
  }

  return (
    <form
      onSubmit={handleSubmit}
      className="bg-white rounded-2xl border border-stone-200 p-6 sm:p-8 shadow-sm"
      noValidate
    >
      <div className="mb-6">
        <h3 className="font-heading font-black text-xl sm:text-2xl text-[#14532D] tracking-tight">
          Admission Enquiry Form
        </h3>
        <p className="text-xs sm:text-sm text-stone-500 mt-1">
          Complete the form below. Our admissions desk will record your enquiry for the upcoming academic session.
        </p>
      </div>

      {errors.general && (
        <div className="mb-5 p-3 rounded-lg bg-red-50 border border-red-200 text-xs text-red-700 flex items-center gap-2">
          <AlertCircle className="w-4 h-4 shrink-0" />
          <span>{errors.general}</span>
        </div>
      )}

      <div className="space-y-4">
        {/* Student Name */}
        <div>
          <label
            htmlFor="studentName"
            className="block text-xs font-semibold uppercase tracking-wider text-stone-700 mb-1.5"
          >
            Student Full Name *
          </label>
          <div className="relative">
            <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-stone-400">
              <User className="w-4 h-4" />
            </div>
            <input
              id="studentName"
              name="studentName"
              type="text"
              required
              disabled={isSubmitting}
              value={formData.studentName}
              onChange={(e) => {
                setFormData({ ...formData, studentName: e.target.value });
                if (errors.studentName) setErrors({ ...errors, studentName: undefined });
              }}
              placeholder="e.g., Mohammad Ayaan"
              aria-invalid={Boolean(errors.studentName)}
              aria-describedby={errors.studentName ? "studentName-error" : undefined}
              className={`w-full pl-10 pr-4 py-2.5 rounded-lg text-sm bg-[#FAF8F2] border transition-colors focus:bg-white focus:outline-none focus:ring-2 ${
                errors.studentName
                  ? "border-red-400 focus:ring-red-400 text-red-900"
                  : "border-stone-300 focus:ring-[#14532D] text-stone-900"
              }`}
            />
          </div>
          {errors.studentName && (
            <p id="studentName-error" className="mt-1 text-xs text-red-600 flex items-center gap-1">
              <AlertCircle className="w-3.5 h-3.5" />
              <span>{errors.studentName}</span>
            </p>
          )}
        </div>

        {/* Parent / Guardian Name */}
        <div>
          <label
            htmlFor="parentName"
            className="block text-xs font-semibold uppercase tracking-wider text-stone-700 mb-1.5"
          >
            Parent / Guardian Full Name *
          </label>
          <div className="relative">
            <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-stone-400">
              <Users className="w-4 h-4" />
            </div>
            <input
              id="parentName"
              name="parentName"
              type="text"
              required
              disabled={isSubmitting}
              value={formData.parentName}
              onChange={(e) => {
                setFormData({ ...formData, parentName: e.target.value });
                if (errors.parentName) setErrors({ ...errors, parentName: undefined });
              }}
              placeholder="e.g., Tariq Rahman"
              aria-invalid={Boolean(errors.parentName)}
              aria-describedby={errors.parentName ? "parentName-error" : undefined}
              className={`w-full pl-10 pr-4 py-2.5 rounded-lg text-sm bg-[#FAF8F2] border transition-colors focus:bg-white focus:outline-none focus:ring-2 ${
                errors.parentName
                  ? "border-red-400 focus:ring-red-400 text-red-900"
                  : "border-stone-300 focus:ring-[#14532D] text-stone-900"
              }`}
            />
          </div>
          {errors.parentName && (
            <p id="parentName-error" className="mt-1 text-xs text-red-600 flex items-center gap-1">
              <AlertCircle className="w-3.5 h-3.5" />
              <span>{errors.parentName}</span>
            </p>
          )}
        </div>

        {/* Mobile & Class in Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div>
            <label
              htmlFor="mobile"
              className="block text-xs font-semibold uppercase tracking-wider text-stone-700 mb-1.5"
            >
              Contact Mobile Number *
            </label>
            <div className="relative">
              <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-stone-400">
                <Phone className="w-4 h-4" />
              </div>
              <input
                id="mobile"
                name="mobile"
                type="tel"
                required
                maxLength={10}
                disabled={isSubmitting}
                value={formData.mobile}
                onChange={(e) => {
                  const val = e.target.value.replace(/\D/g, "");
                  setFormData({ ...formData, mobile: val });
                  if (errors.mobile) setErrors({ ...errors, mobile: undefined });
                }}
                placeholder="10-digit number"
                aria-invalid={Boolean(errors.mobile)}
                aria-describedby={errors.mobile ? "mobile-error" : undefined}
                className={`w-full pl-10 pr-4 py-2.5 rounded-lg text-sm bg-[#FAF8F2] border transition-colors focus:bg-white focus:outline-none focus:ring-2 ${
                  errors.mobile
                    ? "border-red-400 focus:ring-red-400 text-red-900"
                    : "border-stone-300 focus:ring-[#14532D] text-stone-900"
                }`}
              />
            </div>
            {errors.mobile && (
              <p id="mobile-error" className="mt-1 text-xs text-red-600 flex items-center gap-1">
                <AlertCircle className="w-3.5 h-3.5" />
                <span>{errors.mobile}</span>
              </p>
            )}
          </div>

          <div>
            <label
              htmlFor="grade"
              className="block text-xs font-semibold uppercase tracking-wider text-stone-700 mb-1.5"
            >
              Class Applying For *
            </label>
            <div className="relative">
              <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-stone-400">
                <School className="w-4 h-4" />
              </div>
              <select
                id="grade"
                name="grade"
                required
                disabled={isSubmitting}
                value={formData.grade}
                onChange={(e) => {
                  setFormData({ ...formData, grade: e.target.value });
                  if (errors.grade) setErrors({ ...errors, grade: undefined });
                }}
                aria-invalid={Boolean(errors.grade)}
                aria-describedby={errors.grade ? "grade-error" : undefined}
                className={`w-full pl-10 pr-4 py-2.5 rounded-lg text-sm bg-[#FAF8F2] border transition-colors focus:bg-white focus:outline-none focus:ring-2 appearance-none cursor-pointer ${
                  errors.grade
                    ? "border-red-400 focus:ring-red-400 text-red-900"
                    : "border-stone-300 focus:ring-[#14532D] text-stone-900"
                }`}
              >
                {gradeOptions.map((opt, i) => (
                  <option key={i} value={i === 0 ? "" : opt} disabled={i === 0}>
                    {opt}
                  </option>
                ))}
              </select>
            </div>
            {errors.grade && (
              <p id="grade-error" className="mt-1 text-xs text-red-600 flex items-center gap-1">
                <AlertCircle className="w-3.5 h-3.5" />
                <span>{errors.grade}</span>
              </p>
            )}
          </div>
        </div>

        {/* Query Message */}
        <div>
          <label
            htmlFor="message"
            className="block text-xs font-semibold uppercase tracking-wider text-stone-700 mb-1.5"
          >
            Message or Specific Query (Optional)
          </label>
          <div className="relative">
            <div className="absolute top-3 left-3.5 pointer-events-none text-stone-400">
              <MessageSquare className="w-4 h-4" />
            </div>
            <textarea
              id="message"
              name="message"
              rows={3}
              maxLength={500}
              disabled={isSubmitting}
              value={formData.message}
              onChange={(e) => setFormData({ ...formData, message: e.target.value })}
              placeholder="Any query regarding age criteria, campus visit, or class transfer..."
              className="w-full pl-10 pr-4 py-2 rounded-lg text-sm bg-[#FAF8F2] border border-stone-300 transition-colors focus:bg-white focus:outline-none focus:ring-2 focus:ring-[#14532D] text-stone-900 resize-none"
            />
          </div>
        </div>
      </div>

      <div className="mt-6 pt-2">
        <button
          type="submit"
          disabled={isSubmitting}
          className="btn-primary w-full py-3 px-6 rounded-lg text-sm font-semibold text-white bg-[#14532D] hover:bg-[#0B3B20] shadow-xs active:scale-99 transition-all flex items-center justify-center gap-2 cursor-pointer disabled:opacity-60 disabled:cursor-not-allowed border border-[#0B3B20]"
        >
          {isSubmitting ? (
            <>
              <RefreshCw className="w-4 h-4 animate-spin text-[#EDE2D3]" />
              <span>Registering Enquiry...</span>
            </>
          ) : (
            <>
              <Send className="w-4 h-4 text-[#EDE2D3]" />
              <span>Submit Admission Enquiry</span>
            </>
          )}
        </button>
      </div>

      <p className="text-[11px] text-stone-500 text-center mt-3">
        Enquiries are handled privately by the Al-Qalam Public School admissions desk in Patna.
      </p>
    </form>
  );
}
