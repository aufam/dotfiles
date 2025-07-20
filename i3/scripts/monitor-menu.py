#!/usr/bin/env python3
import subprocess


def get_connected_monitors() -> list[str]:
    output = subprocess.check_output(["xrandr"]).decode()
    monitors = []
    for line in output.splitlines():
        if " connected" in line:
            monitors.append(line.split()[0])
    return monitors


def get_resolutions(monitor: str) -> list[str]:
    output = subprocess.check_output(["xrandr"]).decode()
    resolutions = []
    found = False
    for line in output.splitlines():
        if line.startswith(monitor):
            found = True
            continue
        if found:
            if line.startswith(" "):
                res = line.strip()
                if "x" in res and res not in resolutions:
                    resolutions.append(res)
            else:
                break
    return resolutions


def rofi_select(options: list[str], prompt: str) -> str | None:
    joined = "\n".join(options)
    try:
        selected = (
            subprocess.check_output(
                ["rofi", "-dmenu", "-p", prompt],
                input=joined.encode(),
            )
            .decode()
            .strip()
        )
        return selected if selected in options else None
    except subprocess.CalledProcessError:
        return None


def main():
    title = "󰍹  Monitor"
    monitors = get_connected_monitors()
    monitor = rofi_select(monitors, title)
    if not monitor:
        return

    title = "󰍶 Resolution"
    resolutions = get_resolutions(monitor)
    resolution = rofi_select(resolutions, title)
    if not resolution:
        return

    resolution = resolution.split()[0]
    p = subprocess.run(["xrandr", "--output", monitor, "--mode", resolution])
    if p.stderr is not None:
        subprocess.run(
            [
                "notify-send",
                "-u",
                "critical",
                title,
                f"Failed to set resolution {resolution} for monitor {monitor}\n{p.stderr.decode()}",
            ]
        )
    else:
        subprocess.run(
            [
                "notify-send",
                "-u",
                "normal",
                title,
                f"Successfully set resolution {resolution} for monitor {monitor}\n{p.stdout.decode() if p.stdout is not None else ''}",
            ]
        )


if __name__ == "__main__":
    main()
