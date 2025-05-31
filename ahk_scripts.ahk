; ================================================================================
; # countdown.ahk
; ================================================================================
^F3:: {
    SetT := InputBox('How long from now? (minutes)', 'w250 h100').value * 60

    MyGui := Gui('+AlwaysOnTop -Caption -Border -SysMenu +ToolWindow', 'Sleep Time Left')
    MyGui.MarginX := 2
    MyGui.MarginY := 0
    MyGui.SetFont('s24 bold', 'Verdana')

    MyGui.TX := MyGui.AddText('x2 y6 h40 cGreen Center', Frmt(MyGui.initSecs := SetT))
    MyGui.TX.OnEvent('Click', (*) => PostMessage(0xA1, 2,,, 'A'))

    MyGui.Progress1 := MyGui.AddProgress('x0 y0 wp h5 -Smooth Range0-' SetT ' vProgress1', MyGui.ProgNum := SetT)

    Cuar          := Floor(SetT/4)
    MyGui.Cuar1   := Cuar*1
    MyGui.Cuar2   := Cuar*2
    MyGui.Cuar3   := Cuar*3

    MyGui.TX.SetFont('s23')
    MyGui.Show

    MyGui.Progress1.GetPos(,, &w)
    MyGui.Progress1.Move(,, w+MyGui.MarginX*2)

    ; start countdown
    SetTimer(SubtractTime, 1000)

    SubtractTime()
    {
        MyGui.Progress1.value-- ; subtract one tick from progress bar
        MyGui.TX.Value := Frmt(--MyGui.initSecs) ; update time

        if MyGui.TX.Value = '00:00' { ; if time is up
            Sleep(1000) ; wait one more second
            SetTimer(SubtractTime, 0) ; stop countdown timer
            MyGui.Destroy() ; destroy gui
            return Msgbox("End of countdown!", 'Reminder', '64') ; show reminder message
        }

        switch MyGui.initSecs
        {
            case MyGui.Cuar2:
                MyGui.TX.SetFont('s24 cFFA500')
                MyGui.Progress1.Opt('cFFA500')

            case MyGui.Cuar1:
                MyGui.TX.SetFont('s24 cRed')
                MyGui.Progress1.Opt('cRed')
        }
    }

    Frmt(secs)
    {
        time := 20000101
        time := DateAdd(time, secs, 'Seconds')
        mmss := FormatTime(time, (secs < 3600 ? 'mm:ss' : 'HH:mm:ss'))
        return mmss
    }
}

; ================================================================================
; # g915_n.ahk
; ================================================================================
; Fix repeating key problem with Logitech G915
; https://stackoverflow.com/questions/68349486/how-to-make-an-autohotkey-script-to-fix-my-keyboard-repeating-key-problem
*n:: ; When 'n' is pressed (with or without modifiers like `Shift` or `Alt`)
{
    Send("{Blind}n") ; Send 'n' blindly to the computer
    Sleep(100) ; Then delay for a duration of one second [change to taste]
    return
}

; ================================================================================
; # kb_shcut.ahk
; ================================================================================
; Print current date
:*:!date::
{
    CurrentDateTime := FormatTime(, "dddd, yyyy-MM-dd")
    SendInput(CurrentDateTime)
    return
}

; Print current time
:*:!time::
{
    CurrentDateTime := FormatTime(, "HH:mm:ss")
    SendInput(CurrentDateTime)
    return
}

; Open Google Calendar
:*:!gc::
{
    Run "firefox.exe https://calendar.google.com/calendar/u/0/"
    return
}

; ================================================================================
; # mouse_move.ahk
; ================================================================================
n := 10 ; number of intervals
w := A_ScreenWidth / n

move_5px()
{
    MouseGetPos(&xpos, &ypos)
    MouseMove(-5, 0, 10, "R")
    Sleep(100)
}

^M:: {
    SetTimer(move_5px, 1000)
}

; ================================================================================
; # procs.ahk
; ================================================================================
^!Up:: {
    procs := ['turtl.exe', 'Spotify.exe', 'firefox.exe', 'DiscordCanary.exe', 'Routine.exe', 'Antidote.exe', 'slack.exe', 'Spike.exe', 'Telegram.exe', 'KeePass.exe']

    DoProcs(*) {
        Input := MyInput.Text
        if (Input = "close") {
            CloseProcs()
            OpenCloseGui.Hide
        } else if (Input = "open") {
            RunProcs()
            OpenCloseGui.Hide
        } else {
            MsgBox("Invalid input. Need 'open' or 'close'")
        }
        return
    }

    CloseProcs(*) {
        for p in procs
            if (PID := ProcessExist(p)) {
                ProcessClose(PID)
            }
        return
    }

    RunProcs(*) {
        for p in procs
            if (!PID := ProcessExist(p)) {
                Run "shell:startup" p
            }
        return
    }

    OpenCloseGui := Gui('+ToolWindow', 'Open/Close')
    MyInput := OpenCloseGui.AddEdit("vInputField")
    MyBtn := OpenCloseGui.AddButton("Default w80", "OK")
    MyBtn.OnEvent("Click", DoProcs)
    OpenCloseGui.Show
}

; ================================================================================
; # run_hotkeys.ahk
; ================================================================================
#C::
{
    Run "C:\Program Files\PowerShell\7\pwsh.exe"
}

; ================================================================================
; # setontop.ahk
; ================================================================================
^SPACE::WinSetAlwaysOnTop -1, "A"

; ================================================================================
; # typing_hotkeys.ahk
; ================================================================================
; Note: these hotkeys were designed with the French AZERTY keyboard layout in mind.

^!Space::Send("{U+00A0}") ; CTRL + ALT + Space = non-breaking space (nbsp)

^!SC00A::Send("{U+00C7}") ; CTRL + ALT + ç = uppercase C-cedilla (Ç)

^SC00B::Send("{U+00C0}") ; CTRL + à = uppercase A with grave accent (À)

^!SC008::Send("{U+00C8}") ; CTRL + ALT + è = uppercase E with grave accent (È)

^!SC003::Send("{U+00C9}") ; CTRL + ALT + é = uppercase E with acute accent (É)

^<!SC032::Send("{U+00A0}{U+003F}") ; CTRL + ALT + , = nbsp + question mark

^<!SC035::Send("{U+00A0}{U+0021}") ; CTRL + ALT + ! = nbsp + exclamation mark

^<!SC033::Send("{U+00A0}{U+003B}{U+0020}") ; CTRL + ALT + ; = nbsp + semicolon + normal space

^<!SC034::Send("{U+00A0}{U+003A}{U+0020}") ; CTRL + ALT + : = nbsp + colon + normal space

^!SC056::Send("{U+00AB}{U+00A0}") ; CTRL + ALT + < = French opening quotation mark + nbsp

^SC056::Send("{U+00A0}{U+00BB}") ; CTRL + < = nbsp + French closing quotation mark

^<!SC02D::Send("{U+00A0}{U+00D7}{U+00A0}") ; CTRL + ALT + x = nbsp + multiplication sign + nbsp

^SC04A::Send("{U+2013}") ; CTRL + - (Numpad) = en-dash (–)

^<!SC04A::Send("{U+2014}") ; CTRL + ALT + - (Numpad) = em-dash (—)

<+SC04A::Send("{U+2212}") ; RShift + - (Numpad) = minus sign (−)

<!SC009::Send("{U+005C}") ; ALT + _ = backslash (\)

<!SC033::Send("{U+00B7}") ; ALT + ; = interpunct (·)

<!SC008::Send("{U+0060}") ; ALT + è = backtick (`)

<!SC003::Send("{U+007E}") ; ALT + é = tilde (~)

>+SC00C::Send("{U+00BA}") ; RShift + ) = ordinal indicator (º)

!SC012::Send("{U+1D49}") ; ALT + e = superscript e (ᵉ)

!SC013::Send("{U+02B3}") ; ALT + r = superscript r (ʳ)

:*:!oe::{U+0153} ; exclamation mark + oe = œ

:*:...::{U+2026} ; 3 full stops = ellipsis as 1 character (…)

:*:->::{U+2192} ; hyphen + > = right arrow (→)

; ================================================================================
; # uncopy_newlines.ahk
; ================================================================================
^+C:: {
    Suspend(1)
    A_Clipboard := ""
    Send "^c"
    ClipWait(50)
    A_Clipboard := RegExReplace(A_Clipboard, "(\R)", " ")
    Suspend(0)
    return
}