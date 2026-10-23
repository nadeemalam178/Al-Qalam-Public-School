/**
 * Centralized Site URL Configuration
 *
 * Automatically resolves the active production domain:
 * 1. Explicit NEXT_PUBLIC_SITE_URL (if configured in environment)
 * 2. Vercel Production Project Domain (VERCEL_PROJECT_PRODUCTION_URL)
 * 3. Default active deployment: https://alqalampublicschool.vercel.app
 */
export function getSiteUrl(): string {
  if (process.env.NEXT_PUBLIC_SITE_URL) {
    return process.env.NEXT_PUBLIC_SITE_URL.replace(/\/$/, "");
  }
  if (process.env.VERCEL_PROJECT_PRODUCTION_URL) {
    return `https://${process.env.VERCEL_PROJECT_PRODUCTION_URL}`.replace(/\/$/, "");
  }
  if (process.env.VERCEL_URL) {
    return `https://${process.env.VERCEL_URL}`.replace(/\/$/, "");
  }
  return "https://alqalampublicschool.vercel.app";
}
