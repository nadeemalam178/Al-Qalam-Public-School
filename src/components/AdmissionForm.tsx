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
}

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
  const [isSuccess, setIsSuccess] = useState(false);
  const [referenceId, setReferenceId] = useState("");

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

  const validate = (): boolean => {
    const errs: FormErrors = {};

    if (!formData.studentName.trim()) {
      errs.studentName = "Please enter student's full name";
    } else if (formData.studentName.trim().length < 2) {
      errs.studentName = "Name must be at least 2 characters";
    }

    if (!formData.parentName.trim()) {
      errs.parentName = "Please enter parent or guardian's name";
    }

    const cleanPhone = formData.mobile.replace(/\D/g, "");
    if (!cleanPhone) {
      errs.mobile = "Please provide a contact mobile number";
    } else if (cleanPhone.length !== 10) {
      errs.mobile = "Mobile number must be exactly 10 digits (e.g. 9876543210)";
    }

    if (!formData.grade || formData.grade === "Select Class") {
      errs.grade = "Please select the target class";
    }

    setErrors(errs);
    return Object.keys(errs).length === 0;
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    if (!validate()) {
      return;
    }

    setIsSubmitting(true);

    // Simulate quick submission
    setTimeout(() => {
      setIsSubmitting(false);
      const generatedRef = "AQPS-" + Math.floor(100000 + Math.random() * 900000);
      setReferenceId(generatedRef);
      setIsSuccess(true);
    }, 700);
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
    setIsSuccess(false);
    setReferenceId("");
  };

  if (isSuccess) {
    return (
      <div className="bg-white rounded-3xl border border-[#2F7D4A]/30 p-8 sm:p-10 shadow-md text-center animate-in fade-in zoom-in-95 duration-200">
        <div className="w-16 h-16 bg-[#E8F3EA] text-[#166534] rounded-full flex items-center justify-center mx-auto mb-5 shadow-xs">
          <CheckCircle2 className="w-9 h-9" />
        </div>
        <span className="inline-block px-3.5 py-1 bg-[#E8F3EA] text-[#14532D] text-xs font-bold uppercase rounded-full mb-3 border border-[#2F7D4A]/30">
          Enquiry Received Successfully
        </span>
        <h3 className="text-2xl font-black text-[#14532D] mb-2">
          Thank You, {formData.parentName}!
        </h3>
        <p className="text-sm text-stone-600 max-w-md mx-auto mb-6 leading-relaxed">
          Your admission enquiry for <span className="font-semibold text-stone-800">{formData.studentName}</span> ({formData.grade}) has been recorded. Our admissions desk at Gulzarbagh will contact you shortly.
        </p>

        <div className="bg-[#FAF8F2] border border-[#EDE2D3] rounded-2xl p-4 max-w-sm mx-auto mb-8 text-left text-xs space-y-1.5">
          <p className="text-[#6B4226] font-bold uppercase tracking-wider text-[11px]">
            Reference Details
          </p>
          <div className="flex justify-between font-mono text-stone-800 text-sm font-bold pt-1">
            <span>Enquiry ID:</span>
            <span className="text-[#14532D]">{referenceId}</span>
          </div>
          <div className="flex justify-between text-stone-600 pt-1">
            <span>Mobile:</span>
            <span>+91 {formData.mobile}</span>
          </div>
          <div className="flex justify-between text-stone-600">
            <span>Status:</span>
            <span className="text-[#166534] font-semibold">Under Review</span>
          </div>
        </div>

        <button
          onClick={handleReset}
          className="inline-flex items-center gap-2 px-6 py-2.5 rounded-xl text-xs font-bold text-stone-700 bg-[#FAF8F2] border border-[#EDE2D3] hover:bg-white transition cursor-pointer"
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
      className="bg-white rounded-3xl border border-stone-200 p-6 sm:p-10 shadow-md"
      noValidate
    >
      <div className="mb-6">
        <h3 className="text-xl sm:text-2xl font-black text-[#14532D] tracking-tight">
          Admission Enquiry Form
        </h3>
        <p className="text-xs sm:text-sm text-stone-500 mt-1">
          Submit the form below. We will get in touch with registration details and campus visit scheduling.
        </p>
      </div>

      <div className="space-y-4">
        {/* Student Name */}
        <div>
          <label
            htmlFor="studentName"
            className="block text-xs font-bold uppercase tracking-wider text-stone-700 mb-1.5"
          >
            Student Full Name *
          </label>
          <div className="relative">
            <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-stone-400">
              <User className="w-4 h-4" />
            </div>
            <input
              id="studentName"
              type="text"
              value={formData.studentName}
              onChange={(e) => {
                setFormData({ ...formData, studentName: e.target.value });
                if (errors.studentName) setErrors({ ...errors, studentName: undefined });
              }}
              placeholder="e.g. Ayaan Rahman"
              className={`w-full pl-10 pr-4 py-3 rounded-xl text-sm bg-[#FAF8F2] border transition focus:bg-white focus:outline-none focus:ring-2 ${
                errors.studentName
                  ? "border-red-400 focus:ring-red-400 text-red-900"
                  : "border-stone-300 focus:ring-[#166534] text-stone-900"
              }`}
            />
          </div>
          {errors.studentName && (
            <p className="mt-1 text-xs text-red-600 flex items-center gap-1 font-medium">
              <AlertCircle className="w-3.5 h-3.5" />
              <span>{errors.studentName}</span>
            </p>
          )}
        </div>

        {/* Parent / Guardian Name */}
        <div>
          <label
            htmlFor="parentName"
            className="block text-xs font-bold uppercase tracking-wider text-stone-700 mb-1.5"
          >
            Parent / Guardian Name *
          </label>
          <div className="relative">
            <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-stone-400">
              <Users className="w-4 h-4" />
            </div>
            <input
              id="parentName"
              type="text"
              value={formData.parentName}
              onChange={(e) => {
                setFormData({ ...formData, parentName: e.target.value });
                if (errors.parentName) setErrors({ ...errors, parentName: undefined });
              }}
              placeholder="e.g. Mohammad Rahman"
              className={`w-full pl-10 pr-4 py-3 rounded-xl text-sm bg-[#FAF8F2] border transition focus:bg-white focus:outline-none focus:ring-2 ${
                errors.parentName
                  ? "border-red-400 focus:ring-red-400 text-red-900"
                  : "border-stone-300 focus:ring-[#166534] text-stone-900"
              }`}
            />
          </div>
          {errors.parentName && (
            <p className="mt-1 text-xs text-red-600 flex items-center gap-1 font-medium">
              <AlertCircle className="w-3.5 h-3.5" />
              <span>{errors.parentName}</span>
            </p>
          )}
        </div>

        {/* Mobile Number & Class dropdown in 2 cols */}
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div>
            <label
              htmlFor="mobile"
              className="block text-xs font-bold uppercase tracking-wider text-stone-700 mb-1.5"
            >
              Contact Mobile Number *
            </label>
            <div className="relative">
              <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-stone-400">
                <Phone className="w-4 h-4" />
              </div>
              <input
                id="mobile"
                type="tel"
                maxLength={10}
                value={formData.mobile}
                onChange={(e) => {
                  const val = e.target.value.replace(/\D/g, "");
                  setFormData({ ...formData, mobile: val });
                  if (errors.mobile) setErrors({ ...errors, mobile: undefined });
                }}
                placeholder="10-digit number"
                className={`w-full pl-10 pr-4 py-3 rounded-xl text-sm bg-[#FAF8F2] border transition focus:bg-white focus:outline-none focus:ring-2 ${
                  errors.mobile
                    ? "border-red-400 focus:ring-red-400 text-red-900"
                    : "border-stone-300 focus:ring-[#166534] text-stone-900"
                }`}
              />
            </div>
            {errors.mobile && (
              <p className="mt-1 text-xs text-red-600 flex items-center gap-1 font-medium">
                <AlertCircle className="w-3.5 h-3.5" />
                <span>{errors.mobile}</span>
              </p>
            )}
          </div>

          <div>
            <label
              htmlFor="grade"
              className="block text-xs font-bold uppercase tracking-wider text-stone-700 mb-1.5"
            >
              Class Applying For *
            </label>
            <div className="relative">
              <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-stone-400">
                <School className="w-4 h-4" />
              </div>
              <select
                id="grade"
                value={formData.grade}
                onChange={(e) => {
                  setFormData({ ...formData, grade: e.target.value });
                  if (errors.grade) setErrors({ ...errors, grade: undefined });
                }}
                className={`w-full pl-10 pr-4 py-3 rounded-xl text-sm bg-[#FAF8F2] border transition focus:bg-white focus:outline-none focus:ring-2 appearance-none cursor-pointer ${
                  errors.grade
                    ? "border-red-400 focus:ring-red-400 text-red-900"
                    : "border-stone-300 focus:ring-[#166534] text-stone-900"
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
              <p className="mt-1 text-xs text-red-600 flex items-center gap-1 font-medium">
                <AlertCircle className="w-3.5 h-3.5" />
                <span>{errors.grade}</span>
              </p>
            )}
          </div>
        </div>

        {/* Message / Query */}
        <div>
          <label
            htmlFor="message"
            className="block text-xs font-bold uppercase tracking-wider text-stone-700 mb-1.5"
          >
            Message or Specific Query (Optional)
          </label>
          <div className="relative">
            <div className="absolute top-3 left-3.5 pointer-events-none text-stone-400">
              <MessageSquare className="w-4 h-4" />
            </div>
            <textarea
              id="message"
              rows={3}
              value={formData.message}
              onChange={(e) => setFormData({ ...formData, message: e.target.value })}
              placeholder="Any query regarding class admission, campus visit, or timings..."
              className="w-full pl-10 pr-4 py-2.5 rounded-xl text-sm bg-[#FAF8F2] border border-stone-300 transition focus:bg-white focus:outline-none focus:ring-2 focus:ring-[#166534] text-stone-900 resize-none"
            />
          </div>
        </div>
      </div>

      <div className="mt-6 pt-2">
        <button
          type="submit"
          disabled={isSubmitting}
          className="w-full py-3.5 px-6 rounded-xl font-bold text-white bg-[#166534] hover:bg-[#14532D] shadow-sm hover:shadow-md active:scale-98 transition-all duration-150 flex items-center justify-center gap-2 cursor-pointer disabled:opacity-70"
        >
          {isSubmitting ? (
            <>
              <RefreshCw className="w-4 h-4 animate-spin" />
              <span>Submitting Enquiry...</span>
            </>
          ) : (
            <>
              <Send className="w-4 h-4 text-[#EDE2D3]" />
              <span>Submit Enquiry</span>
            </>
          )}
        </button>
      </div>

      <p className="text-[11px] text-stone-400 text-center mt-4">
        Your enquiry details are handled with privacy by Al-Qalam Public School, Gulzarbagh, Patna.
      </p>
    </form>
  );
}
