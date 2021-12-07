
; on crée ou on catch les images


; l'image pour la tollbar, c'est le separator.
If CreateImage(#img_barre,1,20)
  If StartDrawing(ImageOutput(#img_barre))
    Box (0,0,1,20,RGB(160,160,160))
    Box (1,0,1,20,RGB(190,190,190))
    StopDrawing()
  EndIf
EndIf

LoadImage(#img_Logo, "Icons\logo.png")


; les icones (toolbar essentiellement et autres gadget)

; files
LoadImage(#ico_New,  "Icons\New.ico")
LoadImage(#ico_Open, "Icons\Open.ico")
LoadImage(#ico_Save,  "Icons\save.ico")

; Tracks
LoadImage(#ico_Mute,  "Icons\mute.ico")
LoadImage(#ico_Solo,  "Icons\yes.ico")
LoadImage(#ico_File,  "Icons\file.ico")

; divers
LoadImage(#ico_Ok,      "Icons\yes.ico")
LoadImage(#ico_Cancel,  "Icons\cancel.ico")
LoadImage(#ico_Cancel2, "Icons\no.png")
LoadImage(#ico_Add,     "Icons\addkey.png")
LoadImage(#ico_Snap,    "Icons\snap.ico")

; barre de lecture
LoadImage(#ico_Play,    "Icons\Play.png")
LoadImage(#ico_Pause,   "Icons\Pause.png")
LoadImage(#ico_Stop,    "Icons\Stop.png")
LoadImage(#ico_End,     "Icons\end.png")
LoadImage(#ico_Record,  "Icons\Record.png")
LoadImage(#ico_Start,   "Icons\start.png")
LoadImage(#ico_Loop,    "Icons\loop.png")

; icone tool ( pour éditer la partie du track sélectionnée)
LoadImage(#ico_Set,   "Icons\set.png")
LoadImage(#ico_move,  "Icons\move.png")
LoadImage(#ico_Select,"Icons\selected.png")
LoadImage(#ico_Paint, "Icons\pencil.ico")
LoadImage(#Ico_Volume,"Icons\Volume.png")
LoadImage(#ico_Pan,   "Icons\pan.png")
LoadImage(#ico_Erase, "Icons\eraser.png")

; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 31
; FirstLine = 8
; Folding = -
; EnableXP