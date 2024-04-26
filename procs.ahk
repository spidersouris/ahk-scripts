^!Up:: {
    procs := ["turtl.exe", "DiscordCanary.exe", "firefox.exe",
    "Routine.exe", "Spotify.exe", "Telegram.exe", "KeePass.exe",
    "Antidote.exe", "slack.exe", "Spike.exe"]

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