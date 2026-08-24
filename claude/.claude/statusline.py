#!/usr/bin/env python3
# Claude Code statusLine: shows model, cwd, git branch, session token usage and cost (when available).
# Reads the statusLine JSON payload from stdin (see Claude Code docs).
# Colors follow the Catppuccin Mocha palette (matches starship in this dotfiles setup).
import json
import os
import subprocess
import sys


def rgb(hex_color):
    r = int(hex_color[0:2], 16)
    g = int(hex_color[2:4], 16)
    b = int(hex_color[4:6], 16)
    return f"\033[38;2;{r};{g};{b}m"


BLUE = rgb("89b4fa")
PEACH = rgb("fab387")
GREEN = rgb("a6e3a1")
YELLOW = rgb("f9e2af")
RED = rgb("f38ba8")
TEAL = rgb("94e2d5")
MAUVE = rgb("cba6f7")
OVERLAY0 = rgb("6c7086")
RESET = "\033[0m"

try:
    data = json.load(sys.stdin)
except Exception:
    data = {}

model = data.get("model", {}).get("display_name") or "?"

workspace = data.get("workspace", {}) or {}
cwd = data.get("cwd") or workspace.get("current_dir") or os.getcwd()
home = os.path.expanduser("~")
display_dir = cwd
if display_dir.startswith(home):
    display_dir = "~" + display_dir[len(home):]
dir_name = os.path.basename(display_dir.rstrip("/")) or display_dir


def git_branch(path):
    try:
        result = subprocess.run(
            ["git", "--no-optional-locks", "-C", path, "branch", "--show-current"],
            capture_output=True,
            text=True,
            timeout=0.5,
        )
        if result.returncode == 0:
            return result.stdout.strip() or None
    except Exception:
        pass
    return None


branch = git_branch(cwd)

ctx = data.get("context_window", {}) or {}
total_input = ctx.get("total_input_tokens", 0)
total_output = ctx.get("total_output_tokens", 0)
used_pct = ctx.get("used_percentage")

cost_usd = (data.get("cost") or {}).get("total_cost_usd")

rate_limits = data.get("rate_limits") or {}
five_hour_pct = (rate_limits.get("five_hour") or {}).get("used_percentage")
seven_day_pct = (rate_limits.get("seven_day") or {}).get("used_percentage")


def pct_color(pct):
    if pct < 50:
        return GREEN
    elif pct < 80:
        return YELLOW
    return RED


sep = f"{OVERLAY0} | {RESET}"

out = f"{BLUE}{model}{RESET}"
out += sep
out += f"{TEAL}{dir_name}{RESET}"
if branch:
    out += sep
    out += f"{MAUVE} {branch}{RESET}"
out += sep
out += f"{PEACH}tok: {total_input}in/{total_output}out{RESET}"

if used_pct is not None:
    pct = round(used_pct)
    out += f" {pct_color(pct)}({pct}% ctx){RESET}"

if cost_usd is not None:
    out += sep
    out += f"{GREEN}${cost_usd:.4f}{RESET}"

if five_hour_pct is not None or seven_day_pct is not None:
    out += sep
    limits = []
    if five_hour_pct is not None:
        p = round(five_hour_pct)
        limits.append(f"{pct_color(p)}5h:{p}%{RESET}")
    if seven_day_pct is not None:
        p = round(seven_day_pct)
        limits.append(f"{pct_color(p)}7d:{p}%{RESET}")
    out += " ".join(limits)

print(out)
