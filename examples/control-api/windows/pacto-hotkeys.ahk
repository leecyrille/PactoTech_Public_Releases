; Pacto Tech - controller modes on PC hotkeys (AutoHotkey v2)
; Needs the Pacto Tech Utility running. No token, no setup.
; Ctrl+Alt+1..9 below; change the keys or modes to taste.
; Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
#Requires AutoHotkey v2.0

PactoMode(mode) {
    try {
        req := ComObject("WinHttp.WinHttpRequest.5.1")
        req.SetTimeouts(2000, 2000, 2000, 5000)
        req.Open("GET", "http://127.117.73.87:47391/mode/" mode, false)
        req.Send()
        ToolTip(Trim(req.ResponseText, " `r`n"))
    } catch {
        ToolTip("Pacto Tech Utility not reachable")
    }
    SetTimer(() => ToolTip(), -1500)
}

^!1:: PactoMode("2p")
^!2:: PactoMode("4p")
^!3:: PactoMode("twinstick")
^!4:: PactoMode("dpad")
^!5:: PactoMode("analog-fast")
^!6:: PactoMode("analog-slow")
^!7:: PactoMode("8to6-on")
^!8:: PactoMode("8to6-off")
^!9:: PactoMode("keyboard-on")
^!0:: PactoMode("keyboard-off")
