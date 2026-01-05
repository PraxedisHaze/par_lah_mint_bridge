Single Source of Truth
- This checklist is operational only.
- The governing protocol is: ABC_PROTOCOL_V0_2_FINAL.md

The Braid Oath — ABC Protocol Activation Checklist

Preflight
- Confirm Timothy present if recursion or life/anothen is touched.
- Confirm plan_id and scope_id are defined and documented.
- Confirm roles assigned (primary/secondary/tertiary).
- Confirm consent proof_ref exists for guided_by_protocol actions.

Request
- Generate event_id (UUID) for abc.request.
- Populate full envelope (actor_id, source, target, timestamp_utc).
- Include expires_at if the action is time-sensitive.
- Compute checksum for payload+headers.

Review
- Validate consent mode (explicit or guided_by_protocol).
- Verify scope_id matches current project loop.
- Verify rollback status + description.
- If any uncertainty, reject with reason and log.

Accept
- Log abc.accept with request event_id.
- Append to ABC_AUDIT.jsonl before execution.

Execute
- Enforce Draft -> Audit -> Release via ABC_BUFFER.json.
- Verify checksum before any write/execute.
- If checksum fails: abc.fail + audit entry.

Complete
- Log abc.complete with outputs and results.
- Update audit trail with final status.

Failure / Release
- Log abc.fail with reason and remediation.
- If participant exits, log abc.release with scope_id.

Postflight
- Ensure all events link back to request event_id.
- Confirm audit trail is append-only and immutable.
- Confirm no actions outside the plan_id occurred.
