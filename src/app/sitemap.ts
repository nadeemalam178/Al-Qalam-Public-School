import { MetadataRoute } from "next";

export default function sitemap(): MetadataRoute.Sitemap {
  const baseUrl = "https://alqalam-patna.edu.in";
  const routes = [
    "",
    "/about",
    "/academics",
    "/facilities",
    "/gallery",
    "/notices",
    "/admissions",
    "/contact",
  ];

  return routes.map((route) => ({
    url: `${baseUrl}${route}`,
    lastModified: new Date(),
    changeFrequency: route === "" || route === "/notices" ? "daily" : "weekly",
    priority: route === "" ? 1.0 : route === "/admissions" ? 0.9 : 0.8,
  }));
}
