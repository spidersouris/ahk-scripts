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