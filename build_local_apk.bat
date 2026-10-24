@echo off
setlocal enabledelayedexpansion
echo ===================================================
echo   Al-Qalam Public School - Local APK Release Build
echo ===================================================

set "JAVA_HOME=C:\Program Files\Microsoft\jdk-17.0.20.101-hotspot"
set "ANDROID_HOME=C:\Android"
set "ANDROID_SDK_ROOT=C:\Android"
set "PATH=C:\flutter\bin;C:\Android\platform-tools;C:\Android\cmdline-tools\latest\bin;C:\Program Files\Microsoft\jdk-17.0.20.101-hotspot\bin;%PATH%"

cd /d "%~dp0"

for /f "tokens=2 delims= " %%a in ('findstr /r "^version:" mobile_app\pubspec.yaml') do set FULL_VERSION=%%a
for /f "tokens=1 delims=+" %%a in ("%FULL_VERSION%") do set APP_VERSION=%%a

echo Version detected: v%APP_VERSION%
echo.

cd mobile_app

echo [1/4] Getting Flutter packages...
call flutter pub get

echo [2/4] Building Release APK...
call flutter build apk --release

if %ERRORLEVEL% equ 0 (
    cd ..
    echo [3/4] Copying APK to root folder...
    copy /y "mobile_app\build\app\outputs\flutter-apk\app-release.apk" "Al-Qalam-Public-School-Release.apk"

    echo [4/4] Publishing to GitHub Releases (v%APP_VERSION%)...
    gh release view "v%APP_VERSION%" >nul 2>&1
    if !ERRORLEVEL! equ 0 (
        echo Updating existing GitHub release v%APP_VERSION%...
        gh release upload "v%APP_VERSION%" "Al-Qalam-Public-School-Release.apk" --clobber
    ) else (
        echo Creating new GitHub release v%APP_VERSION%...
        gh release create "v%APP_VERSION%" "Al-Qalam-Public-School-Release.apk" --title "Al-Qalam Mobile Suite v%APP_VERSION%" --notes "Official Release v%APP_VERSION% built locally."
    )

    echo.
    echo ===================================================
    echo  SUCCESS! 
    echo  1. Local APK: %~dp0Al-Qalam-Public-School-Release.apk
    echo  2. GitHub Release: https://github.com/nadeemalam178/Al-Qalam-Public-School/releases/tag/v%APP_VERSION%
    echo ===================================================
) else (
    echo.
    echo ===================================================
    echo  BUILD FAILED!
    echo  If the error mentions "Developer Mode",
    echo  please turn ON "Developer Mode" in Windows Settings.
    echo ===================================================
)

pause
