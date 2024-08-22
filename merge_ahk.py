"""
Merges all .ahk files in the selected directory into a single file
Usage: python merge_ahk.py [-p path] [-o output] [-s settings]
"""

import glob
import argparse
import os
import sys
import json
import re

REGEX_PATTERNS = {
    "procs.ahk": {"processes": r"\[[\s\S]*?[\n\r].*\]", "runPath": r"shell:startup"}
}

parser = argparse.ArgumentParser(
    prog="merge_ahk.py",
    description="""Merges all .ahk files in the
                                 current directory into a single file""",
)
parser.add_argument(
    "-p", "--path", help="Path to the directory containing the .ahk files", default="."
)
parser.add_argument(
    "-o", "--output", help="Output file name", default="ahk_scripts.ahk"
)
parser.add_argument(
    "-s", "--settings", help="Path to the settings file", default="settings.json"
)
args = parser.parse_args()

AHK_FILES = [
    os.path.basename(file) for file in glob.glob(os.path.join(args.path, "*.ahk"))
]

if args.settings:
    with open(args.settings, "r", encoding="utf8") as s:
        SETTINGS: dict = json.load(s)
else:
    SETTINGS = {}

if not AHK_FILES:
    print("No .ahk files found in the directory")
    sys.exit(1)

if os.path.exists(args.output):
    print(f"File {args.output} already exists. Overwrite? (y/n)")
    if input().lower() != "y":
        sys.exit(0)

# remove the output file from the list of files to merge if overwritten
# so that the merged file does not include an empty section
# with a comment about itself
AHK_FILES = [file for file in AHK_FILES if file != args.output]

if SETTINGS["ignoreFiles"]:
    AHK_FILES = [file for file in AHK_FILES if file not in SETTINGS["ignoreFiles"]]


def apply_script_replacements(ahk_file: str, file_name: str) -> str:
    """
    Applies script replacements corresponding to the contents of the settings file
    to the given AHK file based on the specified file name.

    Args:
        ahk_file (str): The content of the AHK file.
        file_name (str): The name of the file.

    Returns:
        str: The modified AHK file content after applying the replacements.
    """
    patterns = REGEX_PATTERNS.get(file_name)

    if patterns:
        for header, pattern in patterns.items():
            match = re.search(pattern, ahk_file, re.MULTILINE)
            if match:
                ahk_file = re.sub(pattern, str(SETTINGS[file_name][header]), ahk_file)

    return ahk_file


def main():
    """
    Merge multiple .ahk files into a single output file.

    Reads each .ahk file specified in the AHK_FILES list and merges their contents
    into the output file specified in the args.output parameter.
    Also applies script-specific replacements if specified in the settings.
    """
    with open(args.output, "w", encoding="utf8") as merged:
        for i, file in enumerate(AHK_FILES):
            with open(file, "r", encoding="utf8") as f:
                # skip the first two lines ("require")
                for _ in range(2):
                    next(f)
                merged.write("; " + "=" * 80 + "\n")
                merged.write("; " + f"# {file}\n")
                merged.write("; " + "=" * 80 + "\n")

                if file in SETTINGS and SETTINGS[file]:
                    new_content = apply_script_replacements(f.read(), file)
                    merged.write(new_content)
                else:
                    merged.write(f.read())

                if i != len(AHK_FILES) - 1:
                    merged.write("\n\n")

    print(f".ahk files successfully merged into {args.output}")

    if SETTINGS["ignoreFiles"]:
        print(f"Ignored files: {', '.join(SETTINGS['ignoreFiles'])}")


if __name__ == "__main__":
    main()
