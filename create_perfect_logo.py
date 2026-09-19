import os
import cv2
import numpy as np
import asyncio
from playwright.async_api import async_playwright
from PIL import Image

def generate_perfect_svg():
    src = cv2.imread("clean_logo.png", cv2.IMREAD_UNCHANGED)
    h, w, _ = src.shape
    b, g, r, a = cv2.split(src)

    # 1. Pristine isolation of the authentic Arabic Calligraphy:
    # "الَّذِي عَلَّمَ بِالْقَلَمِ" (Surah Al-'Alaq, Ayah 4)
    mask = np.zeros((h, w), dtype=np.uint8)
    for y in range(60, 93):
        for x in range(75, 260):
            if a[y, x] > 100 and r[y, x] < 140 and g[y, x] < 140 and b[y, x] < 140:
                mask[y, x] = 255

    # 4x bicubic supersampling for silky smooth vector contours
    mask_4x = cv2.resize(mask, (w * 4, h * 4), interpolation=cv2.INTER_CUBIC)
    _, bin_4x = cv2.threshold(mask_4x, 110, 255, cv2.THRESH_BINARY)
    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (3, 3))
    closed_4x = cv2.morphologyEx(bin_4x, cv2.MORPH_CLOSE, kernel)
    blur_4x = cv2.GaussianBlur(closed_4x, (5, 5), 1.0)
    _, smooth_4x = cv2.threshold(blur_4x, 127, 255, cv2.THRESH_BINARY)

    cnts, hier = cv2.findContours(smooth_4x, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_TC89_KCOS)
    scale = 1000.0 / (w * 4.0)

    callig_path_data = []
    if cnts and hier is not None:
        hier = hier[0]
        for cnt in cnts:
            if cv2.contourArea(cnt) < 25:
                continue
            arc = cv2.arcLength(cnt, True)
            approx = cv2.approxPolyDP(cnt, max(0.001 * arc, 0.45), True)
            pts = approx[:, 0, :]
            if len(pts) < 3:
                continue
            d = f"M {pts[0][0]*scale:.1f} {pts[0][1]*scale:.1f} "
            for pt in pts[1:]:
                d += f"L {pt[0]*scale:.1f} {pt[1]*scale:.1f} "
            d += "Z"
            callig_path_data.append(d)
            
    callig_svg_d = " ".join(callig_path_data)

    # 2. Smooth Book Wings (Symmetric Bezier Curves)
    left_blue_d = (
        "M 195,420 "
        "C 220,530 255,630 292,696 "
        "C 335,684 410,676 476,685 "
        "C 425,665 345,664 310,668 "
        "C 270,610 235,510 213,412 "
        "Z"
    )
    right_blue_d = (
        "M 805,420 "
        "C 780,530 745,630 708,696 "
        "C 665,684 590,676 524,685 "
        "C 575,665 655,664 690,668 "
        "C 730,610 765,510 787,412 "
        "Z"
    )

    left_red_d = (
        "M 213,363 "
        "C 238,480 270,570 312,646 "
        "C 350,646 430,650 495,684 "
        "C 445,640 370,626 330,613 "
        "C 290,530 265,450 252,390 "
        "C 256,380 275,372 291,369 "
        "C 340,364 380,365 399,366 "
        "C 365,355 338,349 321,348 "
        "C 275,352 235,358 213,363 "
        "Z"
    )
    right_red_d = (
        "M 787,363 "
        "C 762,480 730,570 688,646 "
        "C 650,646 570,650 505,684 "
        "C 555,640 630,626 670,613 "
        "C 710,530 735,450 748,390 "
        "C 744,380 725,372 709,369 "
        "C 660,364 620,365 601,366 "
        "C 635,355 662,349 679,348 "
        "C 725,352 765,358 787,363 "
        "Z"
    )

    # 3. Primary SVG Construction
    svg_code = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000" width="1000" height="1000">
  <defs>
    <!-- Metallic Gold Ring Gradient -->
    <linearGradient id="goldRimGradient" x1="18%" y1="12%" x2="82%" y2="88%">
      <stop offset="0%" stop-color="#C59A27" />
      <stop offset="22%" stop-color="#F7E692" />
      <stop offset="48%" stop-color="#D4AF37" />
      <stop offset="76%" stop-color="#A57A16" />
      <stop offset="100%" stop-color="#F2DD7E" />
    </linearGradient>

    <!-- Metallic Gold Bevel/Highlight -->
    <linearGradient id="goldBevel" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#FFF8D6" stop-opacity="0.9" />
      <stop offset="50%" stop-color="#C59A27" stop-opacity="0.4" />
      <stop offset="100%" stop-color="#7A560B" stop-opacity="0.8" />
    </linearGradient>

    <!-- Inner Silver/White Plate Gradient -->
    <radialGradient id="silverCenterPlate" cx="48%" cy="42%" r="58%">
      <stop offset="0%" stop-color="#FFFFFF" />
      <stop offset="70%" stop-color="#F8FAFC" />
      <stop offset="100%" stop-color="#E2E8F0" />
    </radialGradient>

    <!-- Pen Maroon Body Gradient -->
    <linearGradient id="penMaroonGrad" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#5B1313" />
      <stop offset="45%" stop-color="#881313" />
      <stop offset="70%" stop-color="#991B1B" />
      <stop offset="100%" stop-color="#5B1313" />
    </linearGradient>

    <!-- Pen Nib Gold Gradient -->
    <linearGradient id="penNibGrad" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#A57A16" />
      <stop offset="50%" stop-color="#F5E080" />
      <stop offset="100%" stop-color="#C59A27" />
    </linearGradient>

    <!-- Blue Wing Gradient -->
    <linearGradient id="blueWingGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#1E3A8A" />
      <stop offset="100%" stop-color="#2563EB" />
    </linearGradient>

    <!-- Red Wing Gradient -->
    <linearGradient id="redWingGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#991B1B" />
      <stop offset="100%" stop-color="#DC2626" />
    </linearGradient>

    <!-- Arc Path for the Curved School Name (Centered at 500,500, radius 376) -->
    <path id="schoolTitleArc" d="M 160,650 A 376,376 0 0,0 840,650" fill="none" />
  </defs>

  <g id="Al-Qalam-Public-School-Emblem">
    <!-- Outer Metallic Gold Ring -->
    <circle cx="500" cy="500" r="488" fill="url(#goldRimGradient)" />
    <circle cx="500" cy="500" r="488" fill="none" stroke="url(#goldBevel)" stroke-width="2.5" />
    <circle cx="500" cy="500" r="433" fill="none" stroke="#7A560B" stroke-width="1.5" opacity="0.4" />

    <!-- Inner Silver/White Shield Plate -->
    <circle cx="500" cy="500" r="432" fill="url(#silverCenterPlate)" stroke="#C59A27" stroke-width="2" />
    <circle cx="500" cy="500" r="428" fill="none" stroke="#FFFFFF" stroke-width="1.5" opacity="0.8" />

    <!-- Top Arabic Calligraphy: Alladhi 'allama bil-qalam (الَّذِي عَلَّمَ بِالْقَلَمِ) -->
    <path id="ArabicCalligraphy" d="{callig_svg_d}" fill="#18181B" fill-rule="evenodd" />

    <!-- Open Book - Outer Blue Wings -->
    <path id="BlueWingLeft" d="{left_blue_d}" fill="url(#blueWingGrad)" />
    <path id="BlueWingRight" d="{right_blue_d}" fill="url(#blueWingGrad)" />

    <!-- Open Book - Inner Red Wings -->
    <path id="RedWingLeft" d="{left_red_d}" fill="url(#redWingGrad)" />
    <path id="RedWingRight" d="{right_red_d}" fill="url(#redWingGrad)" />

    <!-- Letters AQ and PS -->
    <text x="385" y="518" font-family="-apple-system, BlinkMacSystemFont, 'Arial Black', 'Montserrat', 'Inter', sans-serif" font-weight="900" font-size="74" fill="#1F2937" text-anchor="middle" letter-spacing="1">AQ</text>
    <text x="618" y="518" font-family="-apple-system, BlinkMacSystemFont, 'Arial Black', 'Montserrat', 'Inter', sans-serif" font-weight="900" font-size="74" fill="#1F2937" text-anchor="middle" letter-spacing="1">PS</text>

    <!-- Center Fountain Pen (Qalam) -->
    <g id="FountainPen">
      <!-- Gold Top Finial -->
      <rect x="487" y="303" width="26" height="5" rx="2" fill="url(#penNibGrad)" stroke="#7A560B" stroke-width="0.8" />

      <!-- Pen Cap (Maroon with gentle round top) -->
      <path d="M 488,308 Q 500,305 512,308 L 512,330 L 488,330 Z" fill="url(#penMaroonGrad)" />

      <!-- Sleek Gold Clip on Right -->
      <path d="M 512,310 L 515,312 L 515,378 C 515,381 512,381 512,378 Z" fill="url(#penNibGrad)" stroke="#7A560B" stroke-width="0.8" />

      <!-- Upper Barrel (Maroon) -->
      <rect x="487" y="330" width="26" height="105" fill="url(#penMaroonGrad)" />
      
      <!-- Gold Band Trim -->
      <rect x="484" y="435" width="32" height="16" fill="url(#penNibGrad)" stroke="#7A560B" stroke-width="1" />
      <rect x="486" y="440" width="28" height="6" fill="#18181B" />

      <!-- Lower Barrel / Grip Section -->
      <rect x="488" y="451" width="24" height="64" fill="url(#penMaroonGrad)" />

      <!-- Metallic Gold Nib -->
      <polygon points="488,515 512,515 500,652" fill="url(#penNibGrad)" stroke="#A57A16" stroke-width="1" />
      <!-- Nib Breather Hole -->
      <circle cx="500" cy="580" r="3.5" fill="#18181B" />
      <!-- Nib Slit Line -->
      <line x1="500" y1="583.5" x2="500" y2="652" stroke="#18181B" stroke-width="1.8" />
    </g>

    <!-- Bottom Arched School Title: AL-QALAM PUBLIC SCHOOL -->
    <text font-family="-apple-system, BlinkMacSystemFont, 'Arial Black', 'Trebuchet MS', 'Montserrat', sans-serif" font-weight="900" font-size="53" fill="#047857" letter-spacing="3.5">
      <textPath href="#schoolTitleArc" startOffset="50%" text-anchor="middle">
        AL-QALAM PUBLIC SCHOOL
      </textPath>
    </text>
  </g>
</svg>'''

    with open("public/branding/al-qalam-logo.svg", "w", encoding="utf-8") as f:
        f.write(svg_code)
    print("Updated public/branding/al-qalam-logo.svg")

    svg_light = svg_code.replace(
        '<circle cx="500" cy="500" r="488" fill="url(#goldRimGradient)" />',
        '<circle cx="500" cy="500" r="494" fill="#FFFFFF" opacity="0.2" />\n    <circle cx="500" cy="500" r="488" fill="url(#goldRimGradient)" stroke="#FFFFFF" stroke-width="3" />'
    )
    with open("public/branding/al-qalam-logo-light.svg", "w", encoding="utf-8") as f:
        f.write(svg_light)
    print("Updated public/branding/al-qalam-logo-light.svg")

    with open("public/branding/al-qalam-icon.svg", "w", encoding="utf-8") as f:
        f.write(svg_code)
    print("Updated public/branding/al-qalam-icon.svg")

async def render():
    generate_perfect_svg()
    async with async_playwright() as p:
        browser = await p.chromium.launch()
        page = await browser.new_page(viewport={"width": 2048, "height": 2048}, device_scale_factor=1)
        file_url = "file:///" + os.path.abspath("public/branding/render.html").replace("\\", "/")
        await page.goto(file_url)
        await page.wait_for_timeout(800)
        
        png_path = os.path.abspath("public/branding/al-qalam-logo.png")
        await page.screenshot(path=png_path, omit_background=True)
        print(f"Rendered 2048x2048 PNG at: {png_path}")
        await browser.close()

    img = Image.open(png_path)
    img.save("public/branding/favicon.ico", format="ICO", sizes=[(16, 16), (32, 32), (48, 48), (64, 64), (128, 128), (256, 256)])
    img.save("public/favicon.ico", format="ICO", sizes=[(16, 16), (32, 32), (48, 48)])
    
    img_512 = img.resize((512, 512), Image.Resampling.LANCZOS)
    img_512.save("public/icon.png", format="PNG")
    img_512.save("src/app/icon.png", format="PNG")
    print("Updated all icon and favicon assets")

    # Update artifact preview
    img.thumbnail((600, 600), Image.Resampling.LANCZOS)
    img.save(r"C:\Users\alamn\.gemini\antigravity-ide\brain\93b0d66a-fc7f-4e0c-90ad-c9be65fe48fd\logo_preview.png")
    print("Updated logo_preview.png in artifacts")

if __name__ == "__main__":
    asyncio.run(render())
