ABC Protocol v0.2 (FINAL)
Ratified in Parliament 003

Purpose
A minimal, auditable handoff protocol that preserves consent, provenance, and fail-safe behavior across agents, tools, and sessions.

Core Principles
- Consent-first: every action requires explicit consent context.
- Auditability: all events are immutable and logged.
- Fail-safe: ambiguity -> no action.
- Trust-based resilience: continuity through defined Plan B/C roles.

Guardian Clause (Non-Negotiable)
We NEVER touch recursion or life (including anothen) without Timothy at the keyboard.
Operational Companion
- The checklist "BRAID_OATH_ABC_CHECKLIST.md" is a procedural guide only.
- This document remains the single source of truth for ABC Protocol v0.2.

Event Envelope (required for every ABC event)
- event_id: string (UUID)
- event_type: enum (see below)
- timestamp_utc: ISO-8601
- actor_id: string (agent or user)
- source: string (app/tool/session)
- target: string (app/tool/session)
- plan_id: string (ratified plan identifier)
- scope_id: string (project loop identifier)
- consent:
  - mode: enum {explicit, guided_by_protocol, none}
  - scope: string (human-readable)
  - proof_ref: string | null (pointer to consent record)
- payload: object (event-specific)
- status: enum {pending, accepted, rejected, failed}
- checksum: string (sha256 of payload+headers)
- expires_at: ISO-8601 (optional, used with abc.extend)

Event Types
- abc.request: proposes a handoff/action
- abc.accept: explicit acceptance
- abc.reject: explicit refusal
- abc.execute: actual execution
- abc.complete: completion + results
- abc.fail: failure + reason
- abc.extend: explicit renewal of a request past expires_at
- abc.release: voluntary release from a project loop

Consent Model
- guided_by_protocol replaces inferred.
- guided_by_protocol = explicit consent to follow the ratified plan (plan_id + scope_id).
- Any action outside the plan requires a new abc.request + explicit acceptance.

Payload Fields (minimum set)
- intent: string
- rationale: string
- constraints: string[]
- dependencies: string[]
- outputs: string[] (paths/URIs)
- risks: string[]
- rollback:
  - status: enum {reversible, partial, irreversible}
  - description: string
- roles:
  - primary: string
  - secondary: string
  - tertiary: string

Failure Modes (must be handled)
- Missing consent -> reject with reason
- Missing target -> reject with reason
- Invalid checksum -> fail
- Expired request -> reject unless abc.extend is logged
- Unknown event_type -> reject

Audit Requirements
- Append-only log (Loveware/ABC_AUDIT.jsonl)
- Every accept/reject/fail must link to request via event_id
- All payloads immutable after accept
- Any Silent Hand injection must create an audit entry first

Buffer Requirement
- Draft -> Audit -> Release must be enforced via Loveware/ABC_BUFFER.json
- No write/execute event may bypass the buffer.
