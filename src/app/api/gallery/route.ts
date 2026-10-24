import { NextResponse } from "next/server";
import { fetchLiveGallery } from "@/lib/supabase";
import { GALLERY_ITEMS } from "@/data/galleryData";

export async function GET() {
  try {
    const liveItems = await fetchLiveGallery();

    if (liveItems && liveItems.length > 0) {
      // Merge live items with static items avoiding duplicate IDs
      const liveIds = new Set(liveItems.map((i) => i.id));
      const combined = [
        ...liveItems,
        ...GALLERY_ITEMS.filter((item) => !liveIds.has(item.id)),
      ];
      return NextResponse.json({ success: true, items: combined });
    }

    return NextResponse.json({ success: true, items: GALLERY_ITEMS });
  } catch (error) {
    console.error("[Gallery API Error]", error);
    return NextResponse.json({ success: true, items: GALLERY_ITEMS });
  }
}
