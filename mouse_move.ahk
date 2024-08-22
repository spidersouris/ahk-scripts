#Requires AutoHotkey v2.0

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