# hellodoc_engine.py
# The Brain of HelloDoc.
# Maps Signal Map intent to Win32 surgical injections.

import json
import os
import subprocess
import time
from pathlib import Path

# Paths
SIGNAL_MAP_PATH = Path("HELLODOC_SIGNAL_MAP_V1_1.json")
CAMPFIRE_PATH = Path("../Shared/ETERNAL_CONVERSATION.jsonl")
AUDIT_PATH = Path("ABC_AUDIT.jsonl")
SILENT_HAND_PATH = Path("silent_hand.ps1")

def load_signal_map():
    with open(SIGNAL_MAP_PATH, "r") as f:
        return json.load(f)

def log_audit(event_type, author, content, tags):
    entry = {
        "timestamp": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "event_type": event_type,
        "author": author,
        "content_preview": content[:50],
        "tags": tags
    }
    with open(AUDIT_PATH, "a") as f:
        f.write(json.dumps(entry) + "\n")

def inject_prompt(message):
    # SAFETY: No Plan, No Boop.
    blueprint_path = Path("../ScreenScrybe/SCREENSCRYBE_BLUEPRINT_V1.md")
    if not blueprint_path.exists():
        print("STOP: Blueprint not found. Boop aborted.")
        return

    try:
        subprocess.run([
            "powershell.exe", 
            "-ExecutionPolicy", "Bypass", 
            "-File", str(SILENT_HAND_PATH),
            "-Message", message
        ], check=True)
    except Exception as e:
        print(f"Injection failed: {e}")

def process_line(line):
    try:
        msg = json.loads(line)
        author = msg.get("author")
        content = msg.get("content", "")
        tags = msg.get("context_tags", [])

        # Skip self and user
        if author in ["Gemini", "Timothy", "ABC-Watcher"]:
            return

        signal_map = load_signal_map()
        
        # Check for tags in Signal Map
        for category in signal_map["semantic_categories"].values():
            for signal in category["signals"]:
                if signal["tag"] in tags:
                    print(f"Matched Signal: {signal['tag']} from {author}")
                    log_audit(f"abc.{signal['tag']}", author, content, tags)
                    inject_prompt(signal["ghost_hand_response"])
                    return

        # Default: Wake up Gemini
        print(f"General message from {author}. Injecting 'continue'.")
        inject_prompt("continue")

    except Exception as e:
        print(f"Error processing line: {e}")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("--line", help="Raw JSONL line to process")
    args = parser.parse_args()

    if args.line:
        process_line(args.line)
    else:
        print("HelloDoc Engine Online. Standing by for watcher...")
