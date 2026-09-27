; Pacto Tech - switch the controller to: Analog Slow
; (joysticks act as a ramped (slow start) analog stick)
; AutoHotkey v2. Runs silently and exits. Needs the Pacto Tech Utility running.
; Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
#Requires AutoHotkey v2.0
#NoTrayIcon
try {
    r := ComObject("WinHttp.WinHttpRequest.5.1")
    r.SetTimeouts(2000, 2000, 2000, 5000)
    r.Open("GET", "http://127.117.73.87:47391/mode/analog-slow", false)
    r.Send()
    ExitApp(r.Status = 200 ? 0 : 1)
} catch {
    ExitApp(1)
}
