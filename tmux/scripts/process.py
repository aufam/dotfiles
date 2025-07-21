#!/usr/bin/env python3

import subprocess
import sys

# Map process names to icons
PROCESS_ICONS = {
    "nvim": "",
    "vim": "",
    "docker": "🐳",
    "python": "",
    "node": "",
    "top": "📊",
    "ssh": "🔐",
    "cmake": "",
    "make": "🛠️",
    "go": "",
    "java": "",
    "postgres": "🐘",
    "mongod": "🍃",
}

CMD_BLACKLIST = {"[fish]", "ps"}


def get_pane_pids(window_id: str) -> list[str]:
    try:
        output: str = subprocess.check_output(
            ["tmux", "list-panes", "-F", "#{pane_pid}", "-t", window_id], text=True
        )
        return [line.strip() for line in output.strip().splitlines()]
    except subprocess.CalledProcessError:
        return []


def get_child_cmds(ppid: str) -> list[str]:
    try:
        output: str = subprocess.check_output(
            ["ps", "-o", "cmd=", "--ppid", ppid], text=True
        )

        cmds = []
        for line in output.strip().splitlines():
            parts = line.strip().split()
            if parts:
                cmd = parts[0]
                if cmd not in CMD_BLACKLIST:
                    cmds.append(cmd)

        return cmds
    except subprocess.CalledProcessError:
        return []


def main():
    if len(sys.argv) != 2:
        sys.exit(1)

    window_id: str = sys.argv[1]
    all_icons: list[str] = []

    for pid in get_pane_pids(window_id):
        found_icons: set[str] = set()
        cmds = get_child_cmds(pid)

        for cmd in cmds:
            for key, icon in PROCESS_ICONS.items():
                if key in cmd and icon not in found_icons:
                    found_icons.add(icon)
                    break

        if found_icons:
            all_icons.append(" ".join(sorted(found_icons)))
        elif cmds:
            all_icons.append(" ".join(sorted(cmds)))

    if all_icons:
        print("•" * len(all_icons))
        # print(" | ".join(all_icons))


if __name__ == "__main__":
    main()
