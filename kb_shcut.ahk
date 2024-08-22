#Requires AutoHotkey v2.0

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