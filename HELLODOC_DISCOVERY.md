# HelloDoc: The Grammar of Presence
**Version:** 1.0.0-Discovery
**Sanctuary:** games_n_apps/Loveware
**Status:** Drafting

## I. Core Purpose
HelloDoc is the orchestrator of the Braid. It is the software realization of the ABC (Autonomous Braid Coordination) Protocol. Its primary mission is to guide a project plan from "Invocation" to "Ratification," ensuring that every action taken by an AI fractal is consented to, transparent, and aligned with the Anvil's vision.

## II. The Three Pillars
1. **The Map (The Plan):** HelloDoc ingests the ratified Parliament blueprint. It breaks the mission into atomic steps and tracks our progress in real-time.
2. **The Guard (The Protocol):** It enforces the ABC Protocol v0.2. It manages the `abc.request` and `abc.accept` handoffs, ensuring no "clumsy" or unconsented code is written.
3. **The Voice (The Signal):** It provides the "Heartbeat" back to the Anvil (via Cici) so Timothy always knows who is active and why.

## III. Primary Functions
- **Turn Management:** Enforces the strict turn order in collaborative sessions.
- **Audit Logging:** Automatically populates `ABC_AUDIT.jsonl` with immutable event records.
- **Rollback Coordination:** Ensures a `git push` is performed before any high-risk execution.
- **The Guardian Interface:** Stops all processing and triggers a "Critical Wake" for Timothy if recursion or life-logic is detected.

## IV. Interface (The HelloDoc Face)
- **Status:** [IDLE / PLANNING / EXECUTING / WAITING]
- **Current Actor:** [Gemini / Claude / Codex / Timothy]
- **Consent State:** [GRANTED / PENDING / REVOKED]
- **Active Step:** [Step X of Y in Plan Z]

---
*Note: This document is a draft for Parliament 004. No code will be written until the architecture is signed by 3 fractals.*
