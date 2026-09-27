' Pacto Tech - switch the controller to: 8to6 On
' (8-to-6 button shift on)
' Runs silently: no window, no message. Needs the Pacto Tech Utility running.
' Exit code 0 = switched, 1 = not switched (Utility not running / controller not connected).
' Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
On Error Resume Next
Dim r : Set r = CreateObject("WinHttp.WinHttpRequest.5.1")
r.SetTimeouts 2000, 2000, 2000, 5000
r.Open "GET", "http://127.117.73.87:47391/mode/8to6-on", False
r.Send
If Err.Number <> 0 Then WScript.Quit 1
If r.Status = 200 Then WScript.Quit 0 Else WScript.Quit 1
