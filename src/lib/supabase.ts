import { createClient, SupabaseClient } from "@supabase/supabase-js";
import { NoticeItem } from "@/data/schoolData";

const SUPABASE_URL =
  process.env.NEXT_PUBLIC_SUPABASE_URL ||
  "https://zarvozaaexpblrhjsfzq.supabase.co";

const SUPABASE_ANON_KEY =
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ||
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InphcnZvemFhZXhwYmxyaGpzZnpxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTA3MzUyNDUsImV4cCI6MjEwNjMxMTI0NX0.wKeHy1cUddFjeoVIZc4uUioFFImicSjL3-TuaRJl8oc";

let supabaseInstance: SupabaseClient | null = null;

export function getSupabaseClient(): SupabaseClient {
  if (!supabaseInstance) {
    supabaseInstance = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
      auth: {
        persistSession: false,
      },
    });
  }
  return supabaseInstance;
}

export interface AdmissionEnquiryPayload {
  studentName: string;
  parentName: string;
  mobile: string;
  grade: string;
  email?: string;
  message?: string;
  referenceNo?: string;
}

/**
 * Inserts an admission lead into the unified Supabase PostgreSQL admission_enquiries table.
 * The enquiry is immediately visible to School Administrators inside the mobile app!
 */
export async function insertAdmissionEnquiry(payload: AdmissionEnquiryPayload) {
  const client = getSupabaseClient();
  const refNo =
    payload.referenceNo || `AQPS-${Date.now().toString().slice(-6)}`;

  const { data, error } = await client
    .from("admission_enquiries")
    .insert([
      {
        reference_no: refNo,
        student_name: payload.studentName,
        parent_name: payload.parentName,
        grade_applying: payload.grade,
        phone: payload.mobile,
        email: payload.email || null,
        message: payload.message || null,
        status: "pending",
      },
    ])
    .select()
    .single();

  if (error) {
    console.error("[Supabase insertAdmissionEnquiry Error]", error);
    throw error;
  }

  return { data, referenceNo: refNo };
}

/**
 * Inserts a general contact enquiry into the unified Supabase PostgreSQL table.
 */
export async function insertCampusContact(payload: {
  name: string;
  mobile: string;
  message: string;
  referenceNo?: string;
}) {
  const client = getSupabaseClient();
  const refNo =
    payload.referenceNo || `CAMPUS-${Date.now().toString().slice(-6)}`;

  const { data, error } = await client
    .from("admission_enquiries")
    .insert([
      {
        reference_no: refNo,
        student_name: "General Enquiry",
        parent_name: payload.name,
        grade_applying: "Campus Enquiry / General",
        phone: payload.mobile,
        message: payload.message,
        status: "pending",
      },
    ])
    .select()
    .single();

  if (error) {
    console.error("[Supabase insertCampusContact Error]", error);
    throw error;
  }

  return { data, referenceNo: refNo };
}

/**
 * Fetches published circulars and notices from Supabase notices table.
 * Shared between Admin (mobile app broadcast) and Website visitors.
 */
export async function fetchLiveNotices(): Promise<NoticeItem[]> {
  try {
    const client = getSupabaseClient();
    const { data, error } = await client
      .from("notices")
      .select("*")
      .in("target_role", ["all", "guardian"])
      .eq("is_active", true)
      .order("publish_date", { ascending: false });

    if (error || !data) {
      console.warn("[Supabase fetchLiveNotices Warning]", error);
      return [];
    }

    return data.map((n: Record<string, unknown>) => {
      const rawDate = (n.publish_date as string) || new Date().toISOString();
      const formattedDate = new Date(rawDate).toLocaleDateString("en-IN", {
        day: "numeric",
        month: "short",
        year: "numeric",
      });

      let category: "Admissions" | "Academic" | "Safety" | "General" = "General";
      const catLower = String(n.category || "").toLowerCase();
      if (catLower.includes("admiss")) category = "Admissions";
      else if (catLower.includes("acad") || catLower.includes("exam")) category = "Academic";
      else if (catLower.includes("safe")) category = "Safety";

      return {
        id: (n.id as string) || String(n.reference_no || Math.random()),
        title: (n.title as string) || "Notice",
        date: formattedDate,
        category,
        summary: (n.content as string) || (n.title as string),
        details: (n.content as string) || "",
        isImportant: Boolean(n.is_important ?? true),
      };
    });
  } catch (err) {
    console.error("[Supabase fetchLiveNotices Exception]", err);
    return [];
  }
}


/**
 * Fetches published gallery photographs from Supabase gallery_items table.
 * Live sync with Mobile App CMS where Admin adds/removes photos.
 */
export async function fetchLiveGallery(): Promise<Array<{
  id: string;
  src: string;
  title: string;
  category: "Classroom" | "Activities" | "Events" | "Achievements" | "Campus" | "Facilities";
  tag: string;
  description: string;
  isReal: boolean;
}>> {
  try {
    const client = getSupabaseClient();
    const { data, error } = await client
      .from("gallery_items")
      .select("*")
      .eq("is_active", true)
      .order("created_at", { ascending: false });

    if (error || !data) {
      return [];
    }

    return data.map((item: Record<string, unknown>) => {
      let category: "Classroom" | "Activities" | "Events" | "Achievements" | "Campus" | "Facilities" = "Campus";
      const cat = String(item.category || "").toLowerCase();
      if (cat.includes("achieve")) category = "Achievements";
      else if (cat.includes("activ")) category = "Activities";
      else if (cat.includes("class")) category = "Classroom";
      else if (cat.includes("event")) category = "Events";
      else if (cat.includes("facil")) category = "Facilities";

      return {
        id: String(item.id || Math.random()),
        src: String(item.src || "/images/school/classroom/classroom-learning.jpg"),
        title: String(item.title || "School Life"),
        category,
        tag: String(item.tag || "Campus Life"),
        description: String(item.description || ""),
        isReal: true,
      };
    });
  } catch (err) {
    console.error("[Supabase fetchLiveGallery Exception]", err);
    return [];
  }
}
