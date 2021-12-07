
OpenWin_main()

Define cadence.d
Define Quit.a = 0


Repeat
  
  ;{ when playing the sound
  
  If ElapsedMilliseconds() > Settings\CheckTime + 1000/Options\BPM
    Settings\CheckTime = ElapsedMilliseconds() 
    
    If Playing = 1 
      
      z .d  = options\zoom/100
      
      If z <= 0
        z = 0.1
      EndIf 
      
      If play > Project\SelectX2 * options\BPM * z
        play = Project\SelectX1 * options\BPM * z
        
        ;{ A revoir !!  
        
        If options\ProjectIsPlayed
          
          
          ForEach Track()
            With track()
              If IsSound(\SoundId)
                If SoundStatus(\SoundId,\Chanel) = #PB_Sound_Playing           
                  ;mark.d = ((GetSoundPosition(\SoundId,#PB_Sound_Frame,\Chanel) * \SoundLengthMs)/\SoundLength) * options\bpm /1000
                  fin = GetSoundPosition(\SoundId,#PB_Sound_Frame,\Chanel)
                  ;mark.d = GetSoundPosition(\SoundId,#PB_Sound_Millisecond,\Chanel) * options\bpm /1000
                  If \Mute = 0 
                    ;ForEach part()
                      StopSound(\SoundId,#PB_Sound_MultiChannel) 
                      ;If fin >= \Part()\EndW ;\SoundLength                         
                        \Chanel = PlaySound(\SoundId,#PB_Sound_MultiChannel,\VolumeCurrent) 
                      ;EndIf 
                    ;Next
                  EndIf
                EndIf
              EndIf      
            EndWith
          Next
          
          
          
        EndIf
        ;}
        
        
      Else       
        play  + 1
      EndIf
           
      ;mark = play * options\bpm /1000
      
      UpdateTimeline(0,play/2)      
      
    EndIf
    
;     affichage
;     evenement d'affichage (update UI)
;     FPS()

  Else   
    Delay(Settings\Delay)        
  EndIf 
   
  ;}
  
  Event = WaitWindowEvent(1)
  EventMenu = EventMenu()
  EventGadget = EventGadget()
  EventType = EventType()
  EventWindow = EventWindow()
  
  Select event
      
    Case #PB_Event_SizeWindow
      
      Select EventWindow
          
        Case #Win_Main 
          ResizeGadgetswin_main()
       EndSelect   
       
       
    Case #PB_Event_CloseWindow
      
      Select EventWindow
          
        Case #Win_Main         
          Quit = 1
          
        Default
          CloseWindow(EventWindow)
          
      EndSelect
      

    Case #PB_Event_Menu
      
      Select EventMenu
          
          ;{ File
        Case #Menu_New
          ResetParameters()
          
        Case #menu_Pref
          OpenWindowpref()
          
        Case #Menu_Exit          
          Quit = 1
          Break
          
          ;}
          
          ;{ Editions
        Case #menu_MoveAllTracks
          MoveAllTracks()
         
          ;}
          
          ;{ View
          ;}
          
          ;{ Tracks
        Case #menu_AddTrackAudio To #menu_AddTrackBatery
          type = EventMenu - #menu_AddTrackAudio
          AddTrack(type)
          
        Case #menu_AddSound          
          AddSoundToTrack()
          ;}
          
          ;{ Tools
          ;}
          
          ;{ Help          
        Case #menu_AboutPS
          OpenWindowAbout()
          ;}
          
        Default 
          MessageRequester(Lang("Info"),lang("Unavailable"))
          
      EndSelect

    Case #PB_Event_Gadget
      
      Select EventWindow
          
        Case #Win_Main
          
          If selectTrack(EventGadget,EventType)
            
            EventTrack(EventGadget,EventType)
            
          Else 
            
            Select EventGadget
                
              Case #Timeline
                X = GetGadgetAttribute(#Timeline, #PB_Canvas_MouseX)
                Y = GetGadgetAttribute(#Timeline, #PB_Canvas_MouseY)
                MarkerSW = options\MarkerSW
                z.d = options\Zoom/100 
                x =  x /  z 
                
                If options\SnapType = 1
                  snap(X,(options\PixSec * options\BPM/60))              
                Else             
                  snap(X,(options\PixSec))
                EndIf
                
                
                Select EventType() 
                    
                  Case #PB_EventType_LeftButtonDown  
                    MarkerX1 = 1
                    Project\SelectX1 = X  
                    UpdateTimeline()
                    
                  Case #PB_EventType_RightButtonDown
                    MarkerX2 = 1
                    Project\SelectX2 = X
                    ;                 If Project\SelectX2 < Project\SelectX1 + 2* MarkerSW +4
                    ;                   Project\SelectX2 = Project\SelectX1 + 2* MarkerSW +4
                    ;                 EndIf
                    UpdateTimeline()  
                    
                  Case #PB_EventType_MouseMove  
                    If MarkerX1                   
                      Project\SelectX1 = X
                      UpdateTimeline()    
                    EndIf  
                    
                    If markerx2 = 1                  
                      Project\SelectX2 = X                                   
                      ;                   If Project\SelectX2 < Project\SelectX1 + 2* MarkerSW +4
                      ;                     Project\SelectX2 = Project\SelectX1 + 2* MarkerSW +4
                      ;                   EndIf  
                      
                      UpdateTimeline()        
                    EndIf
                    
                    ;ElseIf X >= w1 +Project\SelectX2 And X >= w1 +Project\SelectX2+MarkerSW
                    
                  Case #PB_EventType_LeftButtonUp      
                    MarkerX1 = 0
                    
                  Case #PB_EventType_RightButtonUp
                    MarkerX2 = 0      
                    
                    
                EndSelect 
                
                ;{ new, open, save, add track, import wave on track
              Case #Btn_NewProject
                ResetParameters()
                
              Case #Btn_NewTracke            
                AddTrack()
                
              Case #Btn_ImportSample
                AddSoundToTrack()
                ;}
                
                ;{ playing            
                
              Case #Btn_Play 
                If Project\NbSound > 0              
                  options\ProjectIsPlayed = 1
                EndIf
                Playing = 1
                
                ForEach track()
                  With track() 
                    If IsSound(\SoundId)                  
                      If \Mute = 0                     
                        \Chanel = PlaySound(\SoundId,#PB_Sound_MultiChannel,\VolumeCurrent) 
                      EndIf                  
                    EndIf
                  EndWith              
                Next
                
                
              Case #Btn_Stop            
                options\ProjectIsPlayed = 0
                Playing = 0
                SetGadgetState(#Btn_Play,0)
                SetGadgetState(#Btn_Pause,0)
                
                pix   = Options\PixSec
                g.d   = pix * options\BPM/60
                z .d  = options\zoom/100 
                
                If z <= 0
                  z = 0.1
                EndIf
                
                If options\SnapType = 1
                  XX   = (Project\SelectX1 * g) * z
                Else
                  XX   = (Project\SelectX1 * 2 * Pix) * z
                EndIf
                
                UpdateTimeline(0,XX)
                
                ForEach track()
                  With track()  
                    If IsSound(\SoundId)
                      StopSound(\SoundId,\Chanel) 
                    EndIf                  
                  EndWith              
                Next
                ;}
                
                ;{ tools
              Case #Btn_Move To #Btn_Eraser
                ResetButton(EventGadget)            
                Options\Tool = EventGadget- #Btn_Move
                ;}
                
                ;{ bpm
                
              Case #SP_BPM
                options\BPM = GetGadgetState(#SP_BPM)
                UpdateTimeline()
                ;}
                
                ;{ snap
              Case #CB_snap            
                Options\SnapType = GetGadgetState(#CB_snap)
                Debug "Snap : " +  Options\SnapType
                
              Case #B_Snap
                Options\Snap = GetGadgetState(#B_Snap)
                ;}
                
                ;{ zoom
              Case #SP_Zoom
                options\zoom = GetGadgetState(#SP_Zoom)
                SetGadgetState(#TB_Zoom,options\zoom)
                UpdateTimeline()
                key$ = MapKey(track())
                ForEach track()
                  UpdateDrawingTrack()
                Next
                If key$ <>""
                  If FindMapElement(Track(),key$) : EndIf
                EndIf
                
              Case #TB_Zoom
                options\zoom = GetGadgetState(#TB_Zoom)
                SetGadgetState(#SP_Zoom,options\zoom)
                UpdateTimeline()
                key$ = MapKey(track())
                ForEach track()
                  UpdateDrawingTrack()
                Next
                If key$ <>""
                  If FindMapElement(Track(),key$) : EndIf
                EndIf
                ;}
                
            EndSelect
            
          EndIf
        Case #Win_TrackProperties
          
          Select EventGadget
              
            Case #Btn_WinOk              
              CloseWindow(EventWindow)
              
            Case #Btn_WinCancel
              CloseWindow(EventWindow)
              
          EndSelect
          
        Case #Win_Pref
          
          Select EventGadget
              
            Case #IG_PrefUIColor  
              options\ColorWindow = ColorRequester(options\ColorWindow)
              SetWindowColor(#Win_Main,options\ColorWindow)
              
            Case #IG_PrefColorSelector
              options\ColorSelector = ColorRequester(options\ColorSelector)
              UpdateDrawingTrack()
              
            Case #Cb_PrefGradient
              Options\ColorGradientPart = GetGadgetState(#Cb_PrefGradient)
              
            Case #Btn_WinOk
              CloseWindow(EventWindow)
              
            Case #Btn_WinCancel
              CloseWindow(EventWindow)
              
          EndSelect
          
          
        Case #Win_TrackProperties
          
          
          
          
      EndSelect
    
  EndSelect
  
Until Quit = 1

ForEach Track()
  If IsSound(track()\SoundId)
    FreeSound(track()\SoundId)
  EndIf
Next

; IDE Options = PureBasic 5.20 LTS (Windows - x86)
; CursorPosition = 339
; FirstLine = 29
; Folding = GAB5
; EnableXP