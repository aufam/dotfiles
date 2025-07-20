#!/usr/bin/env python3

import subprocess
import sys
from dataclasses import dataclass
from typing import Self


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

    def input(self, is_password=False) -> str:
        return subprocess.run(
            ["rofi", "-dmenu", "-password" if is_password else "", "-p", self.prompt],
            stdout=subprocess.PIPE,
        ).stdout.decode()


@dataclass
class Connection:
    active: bool
    name: str
    type: str

    def __str__(self) -> str:
        return f"{'*' if self.active else ' '} {self.type} - {self.name}"

    @classmethod
    def parse_list(cls) -> list[Self]:
        output = subprocess.run(
            ["nmcli", "-t", "-f", "ACTIVE,NAME,TYPE", "connection", "show"],
            stdout=subprocess.PIPE,
            check=True,
        ).stdout.decode()

        lines = [line.strip().split(":", 2) for line in output.splitlines()]
        return [
            cls(active=active == "yes", name=name, type=type)
            for active, name, type in lines
        ]

    def toggle(self) -> str:
        cmd = ["nmcli", "connection", "down" if self.active else "up", self.name]
        return subprocess.run(
            cmd,
            stdout=subprocess.PIPE,
        ).stdout.decode()


@dataclass
class Wifi:
    in_use: bool
    bars: str
    ssid: str

    def __str__(self) -> str:
        return f"{'*' if self.in_use else ' '} {self.bars} {self.ssid}"

    @classmethod
    def parse_list(cls) -> list[Self]:
        output = subprocess.run(
            ["nmcli", "-t", "-f", "IN-USE,BARS,SSID", "device", "wifi", "list"],
            stdout=subprocess.PIPE,
            check=True,
        ).stdout.decode()

        lines = [line.strip().split(":", 2) for line in output.splitlines()]
        return [
            cls(in_use=in_use == "*", bars=bars, ssid=ssid)
            for in_use, bars, ssid in lines
        ]

    def connect(self) -> str:
        if self.ssid in [
            c.name for c in Connection.parse_list() if c.type == "802-11-wireless"
        ]:
            cmd = ["nmcli", "connection", "up", self.ssid]
        else:
            password = Rofi(f"Password for {self.ssid}").input(is_password=True)
            cmd = [
                "nmcli",
                "device",
                "wifi",
                "connect",
                self.ssid,
                "password",
                password,
            ]

        return subprocess.run(
            cmd,
            stdout=subprocess.PIPE,
        ).stdout.decode()


def main():
    if len(sys.argv) != 2 or sys.argv[1] not in {"wifi", "connection"}:
        print(f"Usage {sys.argv[0]} [wifi|connection]")
        sys.exit(1)

    if sys.argv[1] == "wifi":
        title = "  Wi-Fi"
        w: Wifi | None = Rofi(title).select(Wifi.parse_list())
        msg: str | None = w.connect() if w is not None else None
    else:
        title = "  Connection"
        cons = [c for c in Connection.parse_list() if not c.type.startswith("802")]
        c: Connection | None = Rofi(title).select(cons)
        msg: str | None = c.toggle() if c is not None else None

    if msg is not None:
        subprocess.run(["notify-send", "-u", "normal", title, msg])


if __name__ == "__main__":
    main()
