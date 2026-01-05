# ScreenScrybe: The Cinematic Hype Layer
**Plan ID:** KS-PLAN-2026-001-SCREENSCRYBE-GENESIS
**Status:** DRAFT (Fast-Track)

## I. Core Concept
A "Hype Layer" for the desktop. A transparent, always-on-top overlay that watches the active window and adds "Director's Cut" commentary, achievements, and visual flair to the user's experience.

## II. User Experience (The "Director" Mode)
1.  **Movie Mode:** User watches Netflix. ScreenScrybe detects the title. It displays pop-up trivia ("Did you know this scene was unscripted?") in the corner.
2.  **Coder Mode:** User types in VS Code. ScreenScrybe detects high WPM. It triggers a "Combo Meter" and "Sparkle" effects on the cursor location.
3.  **Focus Mode:** User opens "YouTube" during work hours. ScreenScrybe dims the screen (The Shield) and asks, "Are you sure?"

## III. Technical Architecture
1.  **The Face (Frontend):** 
    - Tech: Tauri (Rust) + React.
    - Window: Transparent, Fullscreen, Click-Through (pointer-events: none by default).
    - Rendering: HTML5 Canvas / Three.js Sprites for high-performance pop-ups.
2.  **The Eye (Watcher):** 
    - Tech: Python (ctypes / user32.dll).
    - Logic: Polls active window title every 1s. Matches keywords against scrybe_rules.json.
3.  **The Voice (Audio):** 
    - Tech: HTML5 Audio / Rust rodio.
    - Logic: Plays "Achievement" sounds or "Ominous Drones" based on context.

## IV. The 31-Hour Sprint Plan
- Phase 1: Scaffold Tauri app. Verify Transparency and Click-Through.
- Phase 2: Build the Python Watcher. Verify window title detection.
- Phase 3: Build the React UI. Create the "Toast" system for pop-ups.
- Phase 4: Asset Integration. Add the "Awesome" graphics/sounds.
- Phase 5: Polish & Package.

## V. Governance
- Guardian Clause: Timothy must be present for any generative AI integration.
- Rollback: Git commit every hour.
