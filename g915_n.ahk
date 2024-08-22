#Requires AutoHotkey v2.0

; Fix repeating key problem with Logitech G915
; https://stackoverflow.com/questions/68349486/how-to-make-an-autohotkey-script-to-fix-my-keyboard-repeating-key-problem
*n:: ; When 'n' is pressed (with or without modifiers like `Shift` or `Alt`)
{
    Send("{Blind}n") ; Send 'n' blindly to the computer
    Sleep(100) ; Then delay for a duration of one second [change to taste]
    return
}