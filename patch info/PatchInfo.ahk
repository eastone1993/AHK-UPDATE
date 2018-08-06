;v3.0

#Persistent
#SingleInstance, force 
#include %A_ScriptDir%\library\updaterlib.ahk 

;version := FileReadLine, vcontrol, %A_ScriptDir%\PatchInfo.ahk, 1

MsgBox, PATCH INFO CALLED 

dir := A_ScriptDir . "\updates"
des := A_Desktop . "\test stuff"

FileMoveDir, %dir%, %des%, 2

ClearUpdateDir()

ExitApp 
