#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title XPass
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Get 1password
# @raycast.icon 🔑
# @raycast.argument1 { "type": "text", "placeholder": "search" }

# Documentation:
# @raycast.author Nirantak Raghav
# @raycast.authorURL https://nirantak.com
# @raycast.description Autofill password from 1password wherever the cursor is

import logging
import subprocess
import sys
from pathlib import Path
import json


class XPass:
    def __init__(self):
        self.script = Path(__file__)
        self.log_file = self.script.parent / "xpass.log"

        logging.basicConfig(
            filename=self.log_file,
            encoding="utf-8",
            level=logging.DEBUG,
        )
        self.log = logging.getLogger(__name__)

    def search(self, search: str):
        try:
            out = subprocess.run(
                f"op item list --format=json",
                shell=True,
                capture_output=True,
                check=True,
            )
        except Exception as e:
            self.log.error(f"search Exception: {e}")
            raise e
        items: list[dict] = json.loads(out.stdout.decode())

        resp = list(filter(lambda x: search in x["title"].lower(), items))
        if len(resp) < 1:
            raise Exception(f"Could not find item '{search}'!")
        elif len(resp) > 1:
            raise Exception(f"Found {len(resp)} items for '{search}'!")

        return resp[0]["title"]

    def get_pass(self, title: str):
        title = self.search(title.strip().lower())
        self.log.info(f"Fetching password for '{title}'")
        try:
            pswd = subprocess.run(
                f"op item get '{title}' --fields password",
                shell=True,
                capture_output=True,
                check=True,
            )
            return title, pswd.stdout.decode().strip()
        except Exception as e:
            self.log.error(f"get_pass Exception: {e}")
            raise e

    def type_pass(self, title: str, pswd: str):
        self.log.info(f"Typing password for '{title}'")
        try:
            subprocess.run(
                f'osascript -e \'tell Application "System Events" to keystroke "{pswd}"\'',
                shell=True,
                check=True,
            )
        except Exception as e:
            self.log.error(f"type_pass Exception: {e}")
            raise e
        print(f"Password for '{title}' entered")


if __name__ == "__main__":
    xpass = XPass()
    try:
        xpass.type_pass(*xpass.get_pass(sys.argv[1]))
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)
