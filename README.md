# ahk-scripts

This repository contains a variety of [AutoHotkey](https://www.autohotkey.com/) scripts for my personal use.

**These scripts are compatible with AutoHotkey v2 (the latest version of AutoHotkey) <ins>only</ins>.**

## List of scripts

- **countdown.ahk**: A simple countdown timer with a progress bar that appears on top of all windows.
- **g915_n.ahk**: A script to fix a double typing issue with the N key on the Logitech G915 keyboard.
- **kb_shcut.ahk**: A collection of typed shortcuts (e.g. typing `!time` to print the current time).
- **mouse_move.ahk**: A script to progressively move the mouse cursor to avoid idle detection.
- **procs.ahk**: A script to open or close a selection of processes.
- **run_hotkeys.ahk**: A collection of hotkeys to run programs or scripts.
- **setontop.ahk**: A script to set/unset a window on top of all other windows.
- **typing_hotkeys.ahk**: A collection of hotkeys to type special characters and symbols more easily and quickly.

## Running scripts

Scripts are made available individually so that you can pick and choose which ones you want to use. To run a script, simply download the `.ahk` file and run it with AutoHotkey. You can also add it to your startup folder on Windows to run it on startup (use Windows + R → `shell:startup` to access it).

## Merging scripts with `merge_ahk.py`

You can also run the `merge_ahk.py` Python script to merge all or some of the scripts into a single `.ahk` file. This can be useful if you want to run several scripts at once (for example, `hotkeys.ahk` and `countdown.ahk`).

### Usage

`python merge_ahk.py [-p path] [-o output] [-s settings]`

### Settings

The `settings.json` file can be edited to change the behaviour of the script. There are two main types of settings: general settings and script-specific settings.

#### General Settings

##### ignoreFiles

Takes a list of `.ahk` files not to include in the merged file. Each file name should be a string separated by a comma, like this:

```json
{
    "ignoreFiles": [
        "file1.ahk",
        "file2.ahk"
    ]
}
```

#### Script-Specific Settings

Each script can have its own settings. The settings are stored in a dictionary with the name of the script as the key, and child dictionaries for each setting. For example:

```json
{
    "script1.ahk": {
        "setting1": "value1",
        "setting2": "value2"
    },
    "script2.ahk": {
        "setting1": "value1",
        "setting2": "value2"
    }
}
```

##### procs.ahk

- **processes**: A list of processes to open or close. Each process should be a string separated by a comma, like this:

```json
{
    "procs.ahk": {
        "processes": [
            "notepad.exe",
            "mspaint.exe"
        ]
    }
}
```

- **runPath**: The path from where the processes should be run. (Default: `shell:startup`)

```json
{
    "procs.ahk": {
        "runPath": "C:\\Program Files\\Notepad++\\notepad++.exe"
    }
}
```