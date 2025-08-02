#!/usr/bin/env python3

import sys
import subprocess
from dataclasses import dataclass
from typing import Literal, Self


class Rofi:
    def __init__(self, prompt: str) -> None:
        self.prompt = prompt

    def select[T](self, options: list[T]) -> T | None:
        options_str = [str(option) + "\n" for option in options]
        result = subprocess.run(
            ["rofi", "-dmenu", "-i", "-p", self.prompt],
            input="".join(options_str).encode(),
            stdout=subprocess.PIPE,
        ).stdout.decode()

        return options[options_str.index(result)] if result in options_str else None


@dataclass
class Audio:
    kind: str
    id: int
    name: str
    module: str
    type: str
    status: str

    def __str__(self) -> str:
        return f"{self.id: >2} {self.status} - {self.name}"

    @classmethod
    def parse_list(cls, kind: Literal["sink", "source"]) -> list[Self]:
        output = subprocess.run(
            ["pactl", "list", "short", kind + "s"],
            stdout=subprocess.PIPE,
            check=True,
        ).stdout.decode()

        lines = [line.strip().split("\t") for line in output.strip().splitlines()]
        return [
            cls(
                kind=kind,
                id=int(id),
                name=name,
                module=module,
                type=type,
                status=status,
            )
            for id, name, module, type, status in lines
        ]

    def set_default(self) -> tuple[str | None, str | None]:
        p = subprocess.run(
            ["pactl", "set-default-" + self.kind, self.name],
            stdout=subprocess.PIPE,
        )
        return (
            p.stdout.decode() if p.stdout is not None else None,
            p.stderr.decode() if p.stderr is not None else None,
        )


def get_audio_sinks():
    """Gets available audio sinks using pactl."""
    try:
        output = subprocess.check_output(["pactl", "list", "short", "sinks"]).decode()
        sinks = [line.split("\t")[1] for line in output.strip().split("\n")]
        return sinks
    except FileNotFoundError:
        print("Error: pactl not found.  Make sure pulseaudio is installed.")
        return []
    except subprocess.CalledProcessError:
        print("Error: Could not retrieve audio sinks using pactl.")
        return []


def set_default_sink(sink_name):
    """Sets the default audio sink using pactl."""
    try:
        subprocess.run(["pactl", "set-default-sink", sink_name], check=True)
        print(f"Successfully set default sink to: {sink_name}")
    except subprocess.CalledProcessError:
        print(f"Error: Could not set default sink to: {sink_name}")


def show_rofi_menu(sinks):
    """Shows a Rofi menu to select an audio sink."""
    rofi_input = "\n".join(sinks)
    try:
        rofi_process = subprocess.Popen(
            ["rofi", "-dmenu", "-p", "Audio Sink:"],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
        )
        rofi_output, _ = rofi_process.communicate(input=rofi_input.encode("utf-8"))
        selected_sink = rofi_output.decode("utf-8").strip()

        if selected_sink:
            set_default_sink(selected_sink)

    except FileNotFoundError:
        print("Error: rofi not found. Please install rofi.")
    except Exception as e:
        print(f"An error occurred: {e}")


if __name__ == "__main__":
    if len(sys.argv) != 2 or sys.argv[1] not in {"sink", "source"}:
        print(f"Usage {sys.argv[0]} [sink|source]")
        sys.exit(1)

    kind = "sink" if sys.argv[1] == "sink" else "source"
    title = "  Audio " + kind

    audio_list = Audio.parse_list(kind)
    selected = Rofi(title).select(audio_list)
    if selected is None:
        sys.exit(0)

    out, err = selected.set_default()
    if out is not None:
        subprocess.run(
            [
                "notify-send",
                "-u",
                "normal",
                title,
                "Successfully set audio "
                + kind
                + " to be "
                + selected.name
                + "\n"
                + out,
            ]
        )
    if err is not None:
        subprocess.run(
            [
                "notify-send",
                "-u",
                "critical",
                title,
                "Failed to set audio " + kind + " to be " + selected.name + "\n" + err,
            ]
        )
