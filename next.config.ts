import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  async redirects() {
    return [
      {
        source: "/Al-Qalam-Public-School-Release.apk",
        destination:
          "https://wa.me/919308462418?text=Hello%20Al-Qalam%20School,%20please%20send%20me%20the%20mobile%20app%20APK%20download%20link.",
        permanent: false,
      },
    ];
  },
};

export default nextConfig;
