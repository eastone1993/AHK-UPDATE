;v2.0

#Persistent
#SingleInstance, force 


MsgBox, PATCH INFO CALLED 

FileDelete, %A_WorkingDir%\updates
FileCreateDir, %A_WorkingDir%\updates

ExitApp 