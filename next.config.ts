import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  async redirects() {
    return [
      {
        source: "/Al-Qalam-Public-School-Release.apk",
        destination:
          "https://github.com/nadeemalam178/Al-Qalam-Public-School/releases/download/v1.1.0/Al-Qalam-Public-School-Release.apk",
        permanent: false,
      },
    ];
  },
};

export default nextConfig;
