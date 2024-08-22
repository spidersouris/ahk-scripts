#Requires AutoHotkey v2.0

^+C:: {
    Suspend(1)
    A_Clipboard := ""
    Send "^c"
    ClipWait(50)
    A_Clipboard := RegExReplace(A_Clipboard, "(\R)", " ")
    Suspend(0)
    return
}