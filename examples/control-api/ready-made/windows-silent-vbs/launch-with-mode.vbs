' Pacto Tech - run a game in a controller mode, then switch back. Completely silent.
'
' Front-end launcher command:
'   wscript.exe "C:\Pacto\launch-with-mode.vbs" 4p "C:\Emulators\MAME\mame.exe" sf2
'
' Argument 1 = the mode for this game:
'   keyboard-on keyboard-off 2p 4p analog-fast dpad analog-slow 8to6-on 8to6-off
'   (also twinstick twinstick-1p twinstick-2p interlock-on interlock-off)
' The rest   = the program and its arguments.
' When the program exits, the controller goes back to AFTER_MODE below.
' Needs the Pacto Tech Utility running. Docs: https://leecyrille.github.io/PactoTech_Public_Releases/control-api.html
Const AFTER_MODE = "2p"

Sub SetMode(m)
    On Error Resume Next
    Dim r : Set r = CreateObject("WinHttp.WinHttpRequest.5.1")
    r.SetTimeouts 2000, 2000, 2000, 5000
    r.Open "GET", "http://127.117.73.87:47391/mode/" & m, False
    r.Send
End Sub

Dim a : Set a = WScript.Arguments
If a.Count < 2 Then WScript.Quit 1
Dim cmd, i
cmd = ""
For i = 1 To a.Count - 1
    If InStr(a(i), " ") > 0 Then
        cmd = cmd & " " & Chr(34) & a(i) & Chr(34)
    Else
        cmd = cmd & " " & a(i)
    End If
Next
SetMode a(0)
Dim code : code = CreateObject("WScript.Shell").Run(Trim(cmd), 1, True)
SetMode AFTER_MODE
WScript.Quit code
