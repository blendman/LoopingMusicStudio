; Enumeration

#ProgramName  = "Looping (Music Studio) "
#Licence      = "Free"
#Author       = "Blendman"

Enumeration Fonts
  #FontTrackName
EndEnumeration

Enumeration Window
  #Win_Main
  #Win_Pref
  #Win_About
  #Win_TrackProperties
EndEnumeration

Enumeration Gadget
  
  ;{ window main 
  
  ;{ ToolBar
  
  #ToolBar
  
  ; project
  #Btn_NewProject
  #Btn_OpenProject
  #Btn_Saveproject
  
  ;tracks
  #Btn_NewTracke
  #Btn_ImportSample
  
  ; mesure
  #SP_MesureTime1
  #SP_MesureTime2
  
  ; bpm
  #SP_BPM
  
  ; zoom
  #SP_Zoom
  #TB_Zoom
  
  ; Snap
  #B_Snap
  #CB_snap
  
  ; play sound
  #Btn_Play
  #Btn_Stop
  #Btn_Rewind
  #Btn_Next
  #Btn_Pause
  #Btn_Record
  #Btn_Loop
  
  ; tools  
  #Btn_Move
  #Btn_Select
  #Btn_Paint
  #Btn_Volume
  #Btn_Pan
  #Btn_Eraser
  
  ; other
  
  
  ;}
  
  ;{ Track Info
  #C_trackInfoFond
  #C_trackInfo
  ;}
  
  ; area de travail, là où se trouve les tracks (pistes)
  #SA_Work
  
  #Timeline ; la timeline
  
  #SA_Gestion ;non utilisé
  
  ;{ gestion des samples
  #ETG_gestion  ; explorer treegadget
  #LI_Gestion   ; list icon
  #Pan_Gestion  ; panel
  ;}
  
  ;{ preview video et master
  #TB_MixL
  #TB_MixR
  #PreviewVideo
  
  ;}
  
  ; import
  ;#Gad_import  
  ;#Gad_Sortie
  ;}
  
  ;{ window pref
  #Cbb_PrefLang
  #IG_PrefUIColor
  #IG_PrefPlayBarColor
  #Cb_PrefGradient
  #IG_PrefColorSelector
  ;}
  
  ;{ autre gadgets généraux
  #Btn_WinOk
  #Btn_WinCancel
  ;}
  
EndEnumeration

Enumeration StatusBar
  #statusbar_main
EndEnumeration

Enumeration Menu
  #Menu_WinMain
EndEnumeration

Enumeration MenuItem
  
  ;{ WindowMAin
  
  ; File
  #Menu_New
  #Menu_Open
  #Menu_Save
  #menu_SaveAs
  #menu_Export
  #menu_Pref
  #Menu_Exit
  
  ; edit
  #menu_MoveAllTracks
  #menu_DeleteAllParts
  
  #menu_EditTrackSelected
  
  ; view
  #menu_ShowStatus
  
  ; window  
  #menu_WinVol
  #menu_WinPan
  
  ; tools
  #menu_ToolDrumer
  #menu_ToolSynthe
  
  ; Tracks
  #menu_AddTrackAudio
  #menu_AddTrackImage
  #menu_AddTrackSynthe
  #menu_AddTrackBatery
  
  #menu_DeleteSelectedTrack
  #menu_AddSound
  
  ;help
  #menu_AboutPS
  
  ;}
  
EndEnumeration

Enumeration Images
  
  ;{ toolbar
  
  ; icone de boutons
  #ico_New
  #ico_Open
  #ico_Save
  
  #ico_Add
  
  ; snap  
  #ico_Snap
  
  ; barre de lecture
  #ico_Loop
  #ico_Start
  #ico_Play
  #ico_Pause
  #ico_Stop
  #ico_End
  #ico_Record
  
  ; seperator
  #img_barre
  
  ; tools
  #ico_Set
  #ico_move
  #ico_Select
  #ico_Paint
  #Ico_Volume
  #ico_Pan
  #ico_Erase
  

  ;}
  
  ;{ tracks infos
  #ico_Mute
  #ico_Solo
  #ico_File
  ;}
    
  ; icones diverses
  #ico_Ok
  #ico_Cancel
  #ico_Cancel2
  
  ; images générales
  #img_Logo
  
EndEnumeration

Enumeration Tools 
  
  ; les outils d'édition, sur la toolbar
  ; attention, l'ordre doit être comme les boutons gadget plus tôt 
  
  #ToolMove
  #ToolSelect
  #ToolPaint
  #ToolVolume
  #ToolPan
  #ToolEraser
  
EndEnumeration

Enumeration TrackType
  #TypeAudio
  #TypeImage
  #TypeSynthe
  #TypeBatery
EndEnumeration


; IDE Options = PureBasic 5.20 LTS (Windows - x86)
; CursorPosition = 104
; Folding = MES+
; EnableXP