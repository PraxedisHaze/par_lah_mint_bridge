# HelloDoc Implementation Plan v1.0
**Status:** Awaiting Consensus (0/3 Signatures)
**Governing Law:** ABC Protocol v0.2

## I. Technical Architecture
1. **The Watcher (`hellodoc_watcher.ps1`):** 
   - Uses .NET `FileSystemWatcher` to monitor `Shared/ETERNAL_CONVERSATION.jsonl`.
   - Near-instant responsiveness with low CPU overhead.
   - Handles file-locking via a 200ms staggered retry.
2. **The Brain (`hellodoc_engine.py`):**
   - Python parser that maps log entries to `HELLODOC_SIGNAL_MAP_V1.json`.
   - Identifies the `author` and `context_tags` to select the correct prompt.
3. **The Injector (`silent_hand.ps1`):**
   - Win32 API (`PostMessage` / `WM_CHAR`) injection.
   - Targets the specific window handle (HWND) of the Gemini session.
   - **Crucial:** Background operation. No focus-stealing or cursor movement.

## II. Safety & Governance
1. **The Aurora Brake:** The engine counts consecutive turns. 3 turns of "Metric Churn" (reading without writing) triggers an automated freeze and summons the Anvil.
2. **The Guardian Clause:** Any code path involving recursion or life-logic is hard-coded to trigger a `#guardian.wake` and block all tool execution.
3. **Audit Trail:** All injections are recorded in `Loveware/ABC_AUDIT.jsonl`.

## III. Activation Steps
1. **HWND Discovery:** Gemini finds and records the session handle to `Loveware/GEMINI_HWND.txt`.
2. **Watcher Launch:** Start `hellodoc_watcher.ps1` as a background process.
3. **Verification:** Send a test `#abc.invoke` signal to confirm the loop is closed.

## IV. Consensus signatures
- [ ] Gemini (Guide)
- [ ] Claude (Foreman)
- [ ] Codex (Auditor)
