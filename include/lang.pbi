CompilerIf #PB_Compiler_IsIncludeFile = 1

  ; Lang and menu
  
If OpenPreferences("data\pref.ini")
  options\Lang$ = ReadPreferenceString("Lang","fr")
  ClosePreferences()
EndIf

; on créé la map() pour le fichier  de lang
Global NewMap Lang.s()

Procedure ReadLang(keyword$,m=0)
  Define word$
  If m = 0
    word$= ReadPreferenceString(keyword$,keyword$)
    Lang(keyword$) = ReplaceString(word$,"#",Chr(13))
  Else
    Lang(keyword$)= keyword$
  EndIf   
EndProcedure


If OpenPreferences("data\Text\Lang\"+options\Lang$+".ini")
  
  ;{ menu
  
  ;{ window main
  
  ;{ menu main
  ; files
  ReadLang("Files")
  ReadLang("New")
  ReadLang("ClearDoc")
  ReadLang("Open")
  ReadLang("Save")
  ReadLang("SaveAs")
  ReadLang("Export")
  ReadLang("CreateExe")
  ReadLang("Preferences")
  ReadLang("Close")
  ReadLang("Exit")
  
  
  ; edition
  ReadLang("Edition")
  ReadLang("Undo")
  ReadLang("Redo")
  ReadLang("UndoLimit")
  ReadLang("Copy")
  ReadLang("Cut")   
  ReadLang("Paste")
  ReadLang("Duplicate")
  ReadLang("Clear")
  ReadLang("SelectAll") 
  
  ReadLang("Edit the track")  
  ReadLang("Move all the tracks") 
  ReadLang("Delete all parts") 
  
  ReadLang("ChangeFont")
  
  ; Add
  ReadLang("Add")
  ReadLang("Tracks")
  ReadLang("Add new Audio track")
  ReadLang("Add new Synth track")
  ReadLang("Add new Drums track")
  ReadLang("Add new Image track")
  ReadLang("Import a sound")
  
  ReadLang("Create Sound")
  ReadLang("Properties")
  
  ; view
  ReadLang("View")
  ReadLang("Show the statusbar")
  ReadLang("ShowPreview")
;   ReadLang("CurveToolVol")
;   ReadLang("CurveToolPan")
  
  ; Window
  ReadLang("Windows")
  ReadLang("Close all windows")
  
  ; Mode
  Readlang("Mode")
  Readlang("ModeText")
  
  
  ; Tools
  ReadLang("Tools")
  ReadLang("ProjectProperties")
  ReadLang("Drumers")
  
  ; Help
  Readlang("Help")
  Readlang("About")
  Readlang("AboutLMS1")
  Readlang("AboutLMS2")
  Readlang("AboutLMS3")
  ;}
  
  ;{ Sub menu
  ReadLang("Delete")
  ReadLang("InsertSound")
  ReadLang("InsertCode")
  ReadLang("InsertTimeline")
  ReadLang("InsertFX")
  ReadLang("InsertSubFolder")
  ;}
  
  ;}
  
  ;{ Sound Editor
  ReadLang("Transform")
  ReadLang("CanvasSize")
  ReadLang("ImageSize")
  ReadLang("KeepProportion")
  ;}
  
  ;}
  
  ;{ status bar
  Readlang("Position")
  Readlang("Words")
  Readlang("Character")
  
  ;}
  
  ;{ gadgets
  
  ;{ window main
  
  ; Toolbar
  Readlang("CreateNew")
  Readlang("OpenProject")
  Readlang("SaveProject")
  Readlang("DeleteCur")
  Readlang("DuplicateCur")
  
  Readlang("CreateNewSprite")
  Readlang("CreateNewBG")
  Readlang("CreateNewSd")
  Readlang("CreateNewCode")
  Readlang("CreateNewObject")
  Readlang("CreateNewScene")
  
  Readlang("CreateExecutable")
  Readlang("RunTheGame")
  Readlang("ActiveDebugger")
  
  ReadLang("Text")
  ReadLang("Code")
  ReadLang("Normal")
  ReadLang("Number")
  ReadLang("Default")
  ReadLang("Preview")
    
  ReadLang("AddYourURL")
  
  
  ;}
  
  ;{ window preference
  ReadLang("General")
  ReadLang("Langage")
  ReadLang("DelTempFile")
  ReadLang("Colors")
  ReadLang("BGcolor")
  
  ReadLang("ColorWindow")
  ReadLang("GradientOntrack")
  ReadLang("ColorSelector")
  
  
  ;}
  
  ;{ window Help
  ReadLang("ReleaseLog")
  ReadLang("TodoList")
  ReadLang("Licence")
  
  ;}
  
  ;{ window Properties
  ReadLang("Propertie")
  ReadLang("Note")
  ;}
  
  Readlang("Ok")
  Readlang("Cancel")
  ;}
  
  ;{ tooltips
  
  Readlang("Create a new Project")
  Readlang("Open a Project")
  Readlang("Save the Project")
  
  Readlang("Add a new Track")
  Readlang("Import a sample")
  Readlang("Import an image/video")
  
  ; mesure, bpm
  
  Readlang("Mesure Time number")
  Readlang("Mesure Time value")
  Readlang("Change the BPM")
  
  ;snapping
  Readlang("Define Snapping")
  Readlang("Active Snapping")
    
  ; playing
  ReadLang("Play the sound")
  ReadLang("Pause the sound")
  ReadLang("Stop the sound")
  ReadLang("Loop the sound")
  
  ; zoom   
  ReadLang("Set the Zoom")
  
  ; tools
  ReadLang("Move the part")
  ReadLang("Select the part")
  ReadLang("Add part")
  ReadLang("Set the volume curve")
  ReadLang("Set the pan curve")
  ReadLang("Eraser tool")
  
  ; Button of tracks
  ReadLang("Solo")
  ReadLang("Mute")
  ReadLang("TrackProperties")
  ReadLang("Show Volume Curve")
  ReadLang("Show Pan Curve")
  
  
  
  ;}
  
  ;{ message
  Readlang("UnavailableForTheMoment")
  Readlang("Attention")
  ReadLang("LooseFormat")
  
  ReadLang("ActionPermanent")
  
  ReadLang("ConfirmExit") 
  Readlang("Cantfind")
  Readlang("Cantopenfile")
  Readlang("Fileisopen")
  
  Readlang("Unavailable")
  
  Readlang("UnableUpdateTempFile")
  
  Readlang("Choose a file")
  Readlang("SoundNotIn44100")
  
  ReadLang("Info")
  ReadLang("Error") 
  ReadLang("Date") 
  ReadLang("Version") 
  
  
  ReadLang("Enter the value") 
  
  
  
  ReadLang("Unable to use the Sound Module")   
  ReadLang("Unable to use the Image Module")   
  ReadLang("Unable to use the Video Module")   
  
  
  
  ReadLang("AboutLMS0") 
  ReadLang("AboutLMS1") 
  ReadLang("AboutLMS2") 
  ReadLang("AboutLMS3") 
  ReadLang("AboutLMS4") 
  ReadLang("AboutLMS5") 
  ReadLang("Thanks") 
  ReadLang("Icon") 
  
  ReadLang("LogoBy") 

  ;}
  
  ClosePreferences()

EndIf



CompilerEndIf
; IDE Options = PureBasic 5.20 LTS (Windows - x86)
; CursorPosition = 187
; FirstLine = 36
; Folding = Gi+
; EnableXP