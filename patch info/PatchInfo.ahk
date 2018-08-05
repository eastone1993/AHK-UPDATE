;v2.0

#Persistent
#SingleInstance, force 


MsgBox, PATCH INFO CALLED 

FileRemoveDir, %A_ScriptDir%\updates, 1 ;deletes the update if same version 
FileCreateDir, %A_ScriptDir%\updates ;recreates empty update directory 

MsgBox, FILES DELETED

ExitApp 