#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

run C:\Program Files\OpenVPN\bin\openvpn-gui.exe --connect phaseii.ovpn
run reset-button.exe
run F1SwapMode.ahk
run QRes.exe /x:2133 /y:1600 /R:60
run pegasus-fe.exe
