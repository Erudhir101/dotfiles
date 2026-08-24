#!/usr/bin/env bash
# Claude Code statusLine: shows model, session token usage and cost (when available).
# Delegates parsing to statusline.py (python3 is available; jq is not on this machine).
exec python3 "$(dirname "${BASH_SOURCE[0]}")/statusline.py"
