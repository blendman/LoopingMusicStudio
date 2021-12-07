; procedures

;{ Declare
Declare UpdatePostrack()
Declare OpenPropertieTrack()
;}


;{ macros ou procédure générales et utiles

Macro Snap(X,grid)
  ; pour coller à une griller, par exemple pour la time line, ou les parties d'un track
  X = (X/grid)
EndMacro

Macro PlaceFree(x1,y1,ww,hh,x2,y2)
  
  If x1 >= x2 And  x1 <= x2 + ww And y1 >= y2 And y1 <= y2 + hh
    PlaceFree = 0
  Else
    PlaceFree = 1
  EndIf
  
EndMacro

;}


;{ gadgets maison :)

Procedure InsertBar(xx)
  ; le separator de la tollbar
  ImageGadget(#PB_Any,xx+2,1,1,18,ImageID(#img_barre))
  xx+10
  ProcedureReturn xx
EndProcedure


Procedure PS_Btn(nom$="",x=2,y=0,w=20,h=15, col1=10526880,col2=0)
  ; procedure pour concevoir un certain type de bouton
  ; plus utilisé ?
  Box(x,y,w,h,RGB(200,200,200))
  Box(x+1,y+1,w-2,h-2,col1)  
  DrawText(w/2+x-Len(nom$)*3,y,nom$,col2)
EndProcedure

;}


;{ open, save, New, projects, RESET

Procedure OpenOptions()
  ; ouverture du fichier de preferences
  
  If OpenPreferences("data\pref.ini")
    With Options
      ;\Preview  = ReadPreferenceInteger("Preview",1)
      ;\Mode     = ReadPreferenceInteger("Mode",0)
      \Lang$    = ReadPreferenceString("Lang","fr")
      
      ; window UI
      \ColorWindow    = ReadPreferenceInteger("WindowColor",    RGB(230,230,230))
      \ColorTrackinfo = ReadPreferenceInteger("ColorTrackinfo", RGB(230,230,230))
      \ColorSelector = ReadPreferenceInteger("ColorSelector",   RGB(210,210,150))
      
      ; Default UI
      \ToolbarH           = ReadPreferenceInteger("ToolbarH", 28); hauteur de la toolbar
      \SA_WorkH           = ReadPreferenceInteger("SA_WorkH", 100) ; width de la zone central, pour les pistes
      \InfoW              = ReadPreferenceInteger("InfoW", 150) ; espace sur la gauche, pour les infos de tracks (mute, solo..)
      \TrackInfoH         = ReadPreferenceInteger("TrackInfoH", 100) ; espace à gauche d'info (hauteur)
      \SpaceBetweenTracks = ReadPreferenceInteger("SpaceBetweenTracks", 0) ; espace entre 2 tracks 
      
      ; la zone de gestion de fichier en bas
      \ETG_GestionH = ReadPreferenceInteger("ETG_GestionH", 200)
      \ETG_GestionW = ReadPreferenceInteger("ETG_GestionW", 200)
      \Pan_gestionW = ReadPreferenceInteger("Pan_gestionW", 200)
      
      ; Marker
      \MarkerH      = ReadPreferenceInteger("MarkerH", 40)
      \MarkerSW     = ReadPreferenceInteger("MarkerSW", 10)
      \MarkerSelH   = ReadPreferenceInteger("MarkerSelH", 10)   ; H of the selection
      
      ; other
      \zoom         = ReadPreferenceInteger("Zoom", 100) 
      \PixSec       = ReadPreferenceInteger("PixSec", 60) ; nbre de pixels pour la timeline par secondes.      ; Path, debug
      \PrecisionPt  = ReadPreferenceInteger("PrecisionPt", 10) ; précision pour la selection de points de courbes volume et pan (outil volume et pan)
      
      
      ;\SoundEditorPath$  = ReadPreferenceString("SoundEditorPath$",GetCurrentDirectory()+"data\Tools\LoopingMusicStudio.exe")
      ;\DeleteTempFile = ReadPreferenceInteger("DeleteTempFile",1)
      ;\Debuging       = ReadPreferenceInteger("Debuging",1)
      
      ;UI
      
    EndWith
    ClosePreferences()  
  EndIf
  
EndProcedure

Procedure SaveOptions()
  If OpenPreferences("data\pref.ini")
    With Options

      WritePreferenceString("Lang",\Lang$)
      ; WritePreferenceInteger("Autosave",\AutoSave)
      ; WritePreferenceInteger("BackUp", \BackUp)
      
      ; Color
      WritePreferenceInteger("WindowColor",     \ColorWindow)
      WritePreferenceInteger("ColorTrackinfo",  \ColorTrackinfo)
      WritePreferenceInteger("ColorSelector",   \ColorSelector)
      
    EndWith
    ClosePreferences()
  EndIf
EndProcedure

Procedure OpenProject()
  
EndProcedure

Procedure SaveProject()
  
EndProcedure

Procedure ResetParameters()
  ; reset All
  
  ; on redéfinit les paramètres par défaut
  
  Shared w1
  
  Define Version.d, Version${7},date$
  
  Version     = (#PB_Editor_compileCount+102)/10000 
  Version${7} = StrD(Version)
  Licence$    = "Free"
  
  With Settings
    \Checktime  = 10
    \Delay      = 1
    \FPSLimit   = 30
  EndWith 
  
  With options
    
    \Date$    = FormatDate("%dd/%mm/%yyyy", #PB_Compiler_Date)
    \Version$ = Version$
    
    ; default tempo    
    \BPM = 80 
    \MesureTime1 = 4
    \MesureTime2 = 4
    
    ; Default UI
    \ToolbarH           = 28; hauteur de la toolbar
    \SA_WorkH           = 100 ; width de la zone central, pour les pistes
    \InfoW              = 150 ; espace sur la gauche, pour les infos de tracks (mute, solo..)
    \TrackInfoH         = 100 ; espace à gauche d'info (hauteur)
    \SpaceBetweenTracks = 0 ; espace entre 2 tracks 
    
    ; la zone de gestion de fichier en bas
    \ETG_GestionH = 200
    \ETG_GestionW = 200
    \Pan_gestionW = 200
    
    ; Marker
    \MarkerH    = 40 
    \MarkerSW   = 10
    \MarkerSelH = 10   ; H of the selection
    
    ; other
    \zoom         = 100 
    \PixSec       = 60 ; nbre de pixels pour la timeline par secondes.
    \PrecisionPt  = 10
    
  EndWith
  
  With Project
    
    \Name$    = "New Project"
    \IdTrack  = 0
    \SelectX1 = 0 
    \SelectX2 = 12
    \NbSound  = 0
    
  EndWith
  
  ; on efface les gadgets
  ForEach track()
    If IsGadget(track()\GadgetId)
      FreeGadget(track()\GadgetId)      
    EndIf
    If IsGadget(track()\GadInfo)
      FreeGadget(track()\GadInfo)
    EndIf    
  Next
  
  ; on efface la map des track()
  ClearMap(track())
  
EndProcedure
;}

;{ Timeline (create, update, drawing)

Procedure UpdateTimeline(modif=1,Cursor=0)
  Shared WindowWidth,WindowHeight
  
  ; width for the X of the markers
  w   = WindowWidth + 100 + options\InfoW 
  w1  = options\InfoW
  
  ; mesure = bpm/60(sec)
  pix   = Options\PixSec ; le nbre de pixel pour afficher une seconde sur la timeline
  ; il y a un soucis avec la lecture, c'est donc à revoir
  
  g.d   = pix * options\BPM/60 ; 60 pixel = 1 secondes
  
  ; the zoom
  z .d  = options\zoom/100 
  If z <= 0
    z = 0.1
  EndIf
  
  
  Sh  = Options\MarkerSelH  ; Height of the marker selection
  Mw  = Options\MarkerSW    ; Width of the marker selection
  Mh  = Options\MarkerH      ; height of the marker
  
  ; position (marker, mesure, secondes) et width
  X   = (Project\SelectX1 * g) * z
  X2  = ((Project\SelectX2 - Project\SelectX1) * g - Mw ) * z
  w2  = (Project\SelectX2 - Project\SelectX1) * g * z
  
  
  ; on vérifie le snapp des éléments (surtout la selection pour le moment)  
  If options\SnapType = 1
    Xsel  = X
    Xsel2 = X2
    Wsel  = W2
  Else
    Xsel = Project\SelectX1 * z * Pix 
    Xsel2  = ((Project\SelectX2 - Project\SelectX1) * Pix  - Mw ) * z 
    Wsel  = (Project\SelectX2 - Project\SelectX1) * Pix  * z
  EndIf
  
  
  ; le drawing 
  
  If StartDrawing(CanvasOutput(#Timeline))
    
    ; backgrounds, no zoom
     Box(0,0,    w,Mh,RGB(240,240,240)) ; le fond
    ;Box(0,2,    w,Mh-2,RGB(140,140,140))
    ;Box(0,2,    w,Mh-5,RGB(210,210,210))
    ;Box(0,Mh-3, w,1   ,RGB(50,50,50))
    ;{ the selector for the mesure
    ; la selection (en jaune sur la timeline)
    Box(Xsel,             Sh+5,       Wsel,     Sh,   RGB(250,250,220))
    Box(Xsel + 1,         Sh+5+1,     Wsel -2,  Sh-2, Options\ColorSelector)
    Box(Xsel + 1,         Sh+5+1,     Mw *z,    Sh-2, Options\ColorSelector - RGB(20,20,20))
    Box(Xsel + 1 + Xsel2, Sh+5+1,     Mw*z,     Sh-2, Options\ColorSelector - RGB(20,20,20))
    
    ;}
    
    ;{ the mesure / timer
    DrawingMode(#PB_2DDrawing_Transparent)
    DrawingFont(FontID(#FontTrackName))
    
    ; time (second)
    For i = 0 To (w/(G * z)) 
      x = i * g  * z
      Line(x,        mh-4,1,5,RGB(100,100,100))
      Line(x + 1,    mh-4,1,5,RGB(255,255,255))
      min = i/60
      sec = i%60
      If min>0
        DrawText(x + 3, mh - 12, Str(min) + ":" + Str(sec), 0)
      Else
        DrawText(x + 3, mh - 12, Str(sec),0)
      EndIf      
    Next i
    
    ; mesure
    For i = 0 To (w/(pix * z)) 
      x = i * pix * z
      Line(x, 0, 1, 15, RGB(200,200,200))
      ; si on est en début de mesure, on fait un double trait
      If x % (options\MesureTime2 * options\MesureTime1) =0
        Line(x + 1, 0, 1, 15, RGB(140,140,140))
      EndIf
    Next i
    
    ;}
    
    ; la barre de lecture , position actuelle de lecture
    Line(cursor * z -1, 0, 1, 35, RGB(10,50,50))
    Line(cursor * z ,   0, 1, 35, #Red)
  
    StopDrawing()
  EndIf   
EndProcedure

Procedure CreateTimeline()
  Shared WindowWidth 
  ; pour créer la timeline
  
  w = WindowWidth + 100 + options\InfoW
  
  If CanvasGadget(#Timeline,options\InfoW,options\ToolbarH -1,w, options\MarkerH)
    UpdateTimeline()
  EndIf
  
EndProcedure
;}

;{ Tracks (Add, init, update..)

Procedure UpdateDrawingTrack(load = 0, type = 0)
  Shared WindowWidth, WindowHeight, xx
  
  ; position et taille 
  w = WindowWidth+100
  w1 = options\InfoW
  w2 = w1 -5
  h = options\TrackInfoH
  
  pix = Options\PixSec
  
  ; le zoom
  z.d = options\Zoom/100
  
  If z<0
    z=0.1
  EndIf
  
  If MapKey(Track()) = ""
    ResetMap(Track())
  EndIf
  
  
  
  ; on update le track
  With track()
    sel = \Selected * RGB(0, 20, 20)
    
    ;{ si on importe un son sur le track
    If load 
      
      wfs = \WidthForImageSound
      
      ; on crée l'image pour l'afficher sur chaque part ensuite
      \imgSound = CreateImage(#PB_Any, wfs, h - 4, 32)
      
      ; on dessine d'abord sur l'image lié à la piste et au son
      If \imgsound 
        
        If StartDrawing(ImageOutput(\imgsound))
          
          Select \Type
              
              
            Case 0 
              
              ;{ c'est un son, on dessine la waveform
              
              ;The multi tracks          
              Box(0, 0, wfs - 2, h, \Color);RGB(140,140,140))
              
              ; fake sound wave  
              ; à utiliser le code de GallyHC :)          
              For i = 0 To wfs - 2  ;\Part()\Width-2
                h2 = Random (h)
                y = (h - h2)/2
                Line(1 + i, y + 2, 1, h2-4, \color - RGB(60,60,60))
              Next i 
              
              ;}
              
            Case 1 
              
              ;{ c'est une image, on dessine l'image
              
              temp = CopyImage(\file, #PB_Any)
              ResizeImage(temp, \WidthForImageSound, \Height)
              DrawImage(ImageID(temp), 1, 1)
              FreeImage(temp)
              ;}
              
              
          EndSelect
          
          ; le cadre du bord pour faire joli. Pas obligatoire si c'est trop long ^^
          ;DrawingMode(#PB_2DDrawing_Outlined)
          ;Box(0,0,wfs,h-4,RGB(230,230,230))

          
          StopDrawing()
          
        EndIf
        
      EndIf
      
    EndIf
    ;}
    
    ; puis on dessine sur le track en lui-même (le canvas du track)
    
    If StartDrawing(CanvasOutput(\GadgetId))
      Box(0, 0, w, h, RGB(250, 250, 250))
      
      Box(0,1,w,h-2,RGB(150,150,150) - sel) ; le fond
      
      ;{ for the track (audio)
      
      yy =2
      xx =2
      Box(xx,yy,w-xx,h-4,RGB(190,190,190) -Sel) ; Background Track   
      
      ; pour le moment, on a qu'une seule part par track, mais on pourra ensuite dupliquer le son, n'utiliser qu'une partie, etc.. comme dans acid
      ForEach \Part()  
        ; Debug "on affiche l'image"
        DrawImage(ImageID(track()\ImgSound),\Part()\X * z, 2,\Part()\Width * z,\part()\Height)
        
        If \part()\Selected ; pour voir la partie sélectionnée
          DrawingMode(#PB_2DDrawing_AlphaBlend)
          Box(\Part()\X * z, 2,\Part()\Width * z,\part()\Height,RGBA(0,255,255,50))
        EndIf
        
      Next
      
      ;}
      
      ;{ On dessine les mesures
      DrawingMode(#PB_2DDrawing_Transparent)

      For i = 0 To (w/(pix * z)) 
        x = i * pix * z
        Line(x, 0, 1, h, RGB(50,50,50))
        ; si on est en début de mesure, on fait un double trait
        If x % (options\MesureTime2 * options\MesureTime1) =0
          Line(x + 1, 0, 1, h, RGB(90,90,90))
        EndIf
      Next i
      
      ;}
      
      ;{ les courbes volume et pan
      If \ShowVolCurv
        a = ArraySize(\VolCurv())
        For i = 0 To a -1
          Circle(\VolCurv(i)\X , \VolCurv(i)\Y , 4, RGB(120 + 135 * \VolCurv(i)\id, 90, 90))
          LineXY(\VolCurv(i)\X , \VolCurv(i)\Y, \VolCurv(i+1)\X , \VolCurv(i+1)\Y, RGB(255,90,90))
        Next        
        Circle(\VolCurv(a)\X, \VolCurv(a)\Y , 4, RGB(255, 90, 90))
      EndIf
      
      If \ShowPanCurv
        a = ArraySize(\PanCurv())
        For i = 0 To a - 1
          Circle(\PanCurv(i)\X , \PanCurv(i)\Y , 4, RGB(90, 90, 120 + 135 * \PanCurv(i)\id))
          LineXY(\PanCurv(i)\X , \PanCurv(i)\Y, \PanCurv(i+1)\X , \PanCurv(i+1)\Y, RGB(90,90,255))
        Next
        Circle(\PanCurv(a)\X, \PanCurv(a)\Y, 4, RGB(90, 90, 255))
      EndIf
      
      
      ;}
      
      ;{ la barre de lecture
      
      ;}
      
      
      StopDrawing()
      
    EndIf
    
  EndWith
  
EndProcedure

Procedure InitTrack(key$) 
  Shared WindowWidth,WindowHeight
  
  w = WindowWidth +100
  
  ResizeGadget(Track(key$)\GadgetId, #PB_Ignore, #PB_Ignore, W, #PB_Ignore)
  
  UpdateDrawingTrack()
  
EndProcedure

Procedure AddTrack(type=0)  
  Shared WindowWidth, MarkerH, WindowHeight, key$
    
  ; dimension

  h     = options\TrackInfoH
  gh    = options\SpaceBetweenTracks
  Winfo = options\InfoW +10
  
  ; position de la scrollbar en Y (pour bouger les pistes en les "snappant à une grille, car les infos ne sont pas lié à l'areagadget
  ; je pourrais lier chaque panneau d'info à son track en Y ce serait pitet plus simple ^^
  options\ScrollBarY = GetGadgetAttribute(#SA_Work,#PB_ScrollArea_Y) 
  
  
  Select type ; le type de piste qu'on ajoute : audio, image, synthe (plugin), batery (plugin)..
      
    Case 0
      
      ;{ on ajoute une piste son audio
  
  ; pour connaitre le track sélectionné
  key$ = "Track" + Project\IdTrack
  AddMapElement(track(), key$)
  
  ;{ On ajoute les paramètre de la nouvelle piste audio
  
  With Track(key$)
    
    ; on définit les paramètres par défaut
    \Id     = Project\IdTrack
    \Name$  = "New Audio" + Project\IdTrack
    \Type   = type

    \VolumeMax      = 100
    \VolumeCurrent  = 100
    \Pan            = 0
    
    \SoundId = -1 ; on n'a pas encore de importer de son dessus ^^
    ; la couleur de chaque part
    \Color = RGB(155+Random(100)-Random(100), 155+Random(100)-Random(100), 155+Random(100)-Random(100))
    
    i = MapSize(track())-1 
    
    ; on crée le canvas pour ce nouveau track, 
    ; on va y afficher l'image du wave qu'on ouvrira 
    ; et les parties du son qu'on y créera ensuite avec les outils d'édition
    If OpenGadgetList(#SA_Work)
      \GadgetId = CanvasGadget(#PB_Any,0,( h + gh ) * i, WindowWidth, h)
      CloseGadgetList()
    EndIf
    
    ; on crée les gadget pour les infos de la piste (pour changer le volume, le pan, muter, etc...)
    If OpenGadgetList(#C_trackInfo)
      
      ; tout est mis sur un container, plus facile à déplacer.
      
      \GadInfo = ContainerGadget(#PB_Any, 0, ( h + gh ) * i, Winfo, h, #PB_Container_Single)
      
      SetGadgetColor(\GadInfo, #PB_Gadget_BackColor, Options\ColorTrackInfo)
      
      ;{ The gadget for Parameters tracks
      If \GadInfo 
        ; position x et y et width et height des gadget 
        yy = 2
        xx = 2
        es = 0
        w2 = Winfo - 8
        dx = 50 ; taille pour les checkbox
        
        s = 22 ; taille des boutons, pour tous les changerd 'un coup si c'est trop petit ^^
        
        ; Croix, nom et importer un son
        \BI_Cross = ImageGadget(#PB_Any, xx, yy, s, s, ImageID(#ico_Cancel2)) ; croix rouge
        
        \ST_Name  = StringGadget(#PB_Any, xx + s - 3, yy, 80, s, Track()\Name$) ; pour changer le nom
        
        \B_File   = ButtonImageGadget(#PB_Any, xx+s+80,yy,s,s,ImageID(#ico_Open)) ; pour importer un son sur la piste
        GadgetToolTip(\B_File,Lang("Import a sample"))
        xx + s * 2 + 80 + es
        
        ; bouton mute, solo et propriétés
        \B_Mute   = ButtonImageGadget(#PB_Any, xx, yy, s, s, ImageID(#ico_mute),#PB_Button_Toggle)
        GadgetToolTip(\B_Mute,Lang("Mute"))
        
        \B_Solo   = ButtonImageGadget(#PB_Any, xx + (s + es), yy, s, s, ImageID(#ico_solo),#PB_Button_Toggle)
        GadgetToolTip(\B_Solo,Lang("Solo"))
        
        \B_Propertie   = ButtonImageGadget(#PB_Any,xx +(s + es) *2, yy, s, s, ImageID(#ico_File)) ; propriété de la piste (couleur...)
         GadgetToolTip(\B_Propertie,Lang("TrackProperties"))
         
         
         yy  + s + 4
        xx = 2
        
        ; trackbar volume et pan
        TextGadget(#PB_Any, xx, yy + 2, Len("Vol") * 6 + 2, 14, "Vol")
        w =  w2 -( Len("Vol") * 6 + 2 ) - dx
        \TB_Vol   = TrackBarGadget(#PB_Any, xx + Len("Vol") * 6 + 2, yy, w, 18, 0, 100)
        SetGadgetState(\TB_Vol,\VolumeMax) 
        
        xx + Len("Vol") * 6 + GadgetWidth(\TB_Vol) + 20      
        \CB_VolCurv = CheckBoxGadget(#PB_Any, xx, yy-2, 20, 20, "")
        GadgetToolTip(\CB_VolCurv, Lang("Show Volume Curve"))
        
        yy + 20 
        xx = 2
        TextGadget(#PB_Any, xx, yy + 2, Len("Pan") * 6 + 2, 14, "Pan")
        w =  w2 - (Len("Pan") * 6 + 2) - dx
        \TB_Pan   = TrackBarGadget(#PB_Any, xx + Len("Pan") * 6 + 2, yy, w, 18, 0, 200)
        SetGadgetState(\TB_Pan,\Pan +100) 
        
        xx + Len("Pan") * 6 + GadgetWidth(\TB_Pan) + 20   
        \CB_PanCurv = CheckBoxGadget(#PB_Any, xx, yy-2, 20, 20, "")
        GadgetToolTip(\CB_PanCurv, Lang("Show Pan Curve"))
        
        
        CloseGadgetList()
        
      EndIf
      ;}
      
      CloseGadgetList()
      
    EndIf
    
        ; les courbes volumes et pan
    \PanCurv(0)\X = 0
    \PanCurv(0)\Y = h * 50/100    
    \PanCurv(1)\X = WindowWidth
    \PanCurv(1)\Y = h * 50/100

    \VolCurv(0)\X = 0
    \VolCurv(0)\Y = h * 50/100
    \VolCurv(1)\X = WindowWidth
    \VolCurv(1)\Y = h * 50/100

    
    
  EndWith
  ;}
  
  ;}
  
    Case 1 
  
      ;{ on ajoute une piste image
      
      ; pour connaitre le track sélectionné
      key$ = "Track" + Project\IdTrack
      AddMapElement(track(),key$)
      ;{ On ajoute les paramètre de la nouvelle piste
      
      With Track(key$)
        ; on définit les paramètres par défaut
        \Id     = Project\IdTrack
        \Type   = type
        \Name$  = "New Image" + Project\IdTrack
        \Color = RGB(155+Random(100)-Random(100), 155+Random(100)-Random(100), 155+Random(100)-Random(100))
        \SoundId = -1 ; on n'a pas encore de importer de son dessus ^^

        i = MapSize(track())-1 
        
        ; on crée le canvas pour ce nouveau track, 
        ; on va y afficher l'image du wave qu'on ouvrira 
        ; et les parties du son qu'on y créera ensuite avec les outils d'édition
        If OpenGadgetList(#SA_Work)
          \GadgetId = CanvasGadget(#PB_Any,0,( h + gh ) * i,WindowWidth, h)
          CloseGadgetList()
        EndIf
        ; on crée les gadget pour les infos de la piste (pour changer le volume, le pan, muter, etc...)
        If OpenGadgetList(#C_trackInfo)
          
          ; tout est mis sur un container, plus facile à déplacer.
          
          \GadInfo = ContainerGadget(#PB_Any,0,( h + gh ) * i,options\InfoW - 4, h, #PB_Container_Single)
          
          SetGadgetColor(\GadInfo,#PB_Gadget_BackColor, Options\ColorTrackInfo)
          
          ;{ The gadget for Parameters tracks
          If \GadInfo 
            ; position x et y et width et height des gadget 
            yy = 2
            xx = 2
            es = 0
            w2 = options\InfoW - 8
            
            s = 22 ; taille des boutons, pour tous les changerd 'un coup si c'est trop petit ^^
            
            ; Croix, nom et importer un son
            \BI_Cross = ImageGadget(#PB_Any,xx,yy,s,s,ImageID(#ico_Cancel2)) ; croix rouge
            
            \ST_Name  = StringGadget(#PB_Any,xx+s-3,yy,80,s,Track()\Name$) ; pour changer le nom
            
            \B_File   = ButtonImageGadget(#PB_Any,xx+s+80,yy,s,s,ImageID(#ico_Open)) ; pour importer un son sur la piste
            GadgetToolTip(\B_File,Lang("Import an image/video"))
            xx + s * 2 + 80 + es
            CloseGadgetList()
          EndIf
          ;}
          
          CloseGadgetList()
        EndIf
        
      EndWith
      ;}

      ;}
      
    Case 2 
      
      ;{ on ajoute une piste synthe (futur plugin
      
      ;}
      
      
    Case 3 
      
      ;{ on ajoute une piste batery (futur plugin)
      
      ;}
      
      
  EndSelect

  
  ; on initialise le track
  InitTrack(key$)
  Project\IdTrack + 1
  
  ; On update si besoin
  If options\ScrollBarY  >0
    UpdatePosTrack()
  EndIf  
  
  ; Si on doit augmenter la taille du scrollbar, on l'augmente
  TrackH = ( h + gh ) * MapSize(track())
  If TrackH >= GadgetHeight(#SA_Work)
    SetGadgetAttribute(#SA_Work,#PB_ScrollArea_InnerHeight,TrackH + 80)
  EndIf

  ; pour la selection, on remet la couleur sur tous les autres gadgets (container d'info)
  ForEach track()
    If MapKey(track()) <> key$
      SetGadgetColor(track()\GadInfo, #PB_Gadget_BackColor,-1)
    EndIf
  Next
  
  ; on resélectionne le track qui était sélectionné au début ^^
  FindMapElement(track(),key$)
 
EndProcedure

;}

;{ Event Track

; Editions
Procedure MoveAllTracks()
  Shared key$
  
  input =Val(InputRequester(lang("Info"),Lang("Enter the value") + " : ","0"))
  
  If input <> 0
    
    If Options\Snap
      snap(input, (options\PixSec))
    EndIf
    
    ForEach track()
      
      With Track()
        
        ForEach \Part()
          \part()\X + Input * options\PixSec
        Next 
        
      EndWith
      UpdateDrawingTrack()
    Next
    
    If FindMapElement(track(), key$) : EndIf
    
  EndIf
EndProcedure

Procedure AddSoundToTrack()
  Shared keyPart$, key$
  
  ;Debug key$
  If MapKey(track()) = ""
    ResetMap(track()) 
    NextMapElement(track()) 
  EndIf
  
  Select track()\Type
      
    Case #TypeAudio
      ;{ audio
      ;Debug "on ouvre le fichier"
      Track()\FileName$ = OpenFileRequester(Lang("Choose a file"), "", "Wave, OGG files|*.wav;*.ogg",0)
      
      ;Debug "fichier ouvert"
      
      If Track()\FileName$
        
        Newname$ = GetFilePart(Track()\FileName$)
        Newname$ = RemoveString(Newname$,"."+GetExtensionPart(Track()\FileName$))
        
        ;Debug Newname$
        ; on définit les paramètres par defaut
        With Track()
          
          \Name$          = Newname$
          \SoundId        = LoadSound(#PB_Any, Track()\FileName$)      
          \SoundLength    = SoundLength(\SoundId,#PB_Sound_Frame)
          \SoundLengthMs  = SoundLength(\SoundId,#PB_Sound_Millisecond)
          
          ; Debug "MilliSecondes : " +  \SoundLengthMs
          \SoundFrq   = GetSoundFrequency(\SoundId)
          \SoundPos   = GetSoundPosition(\SoundId)
          \VolumeMax  = 100
          \Pan        = 100 ; ?? au centre ?
          
          If \SoundFrq <> 44100
            MessageRequester(Lang("Info"), lang("SoundNotIn44100") + #ProgramName)
          EndIf
          
          \WidthForImageSound = (Options\BPM * \SoundLengthMs)/1000   
          \Height = options\TrackInfoH -4
          
          ; on ajoute une part par defaut. 
          ; Avec l'outil paint, on pourra en ajouter ensuite à la volée
          keyPart$ = Str(\NbPart)
          AddMapElement(\Part(), keyPart$)
          \part()\Width   = (Options\BPM * \SoundLengthMs)/1000 
          \part()\Height  = options\TrackInfoH -4
          \part()\ID      = \NbPart ; je ne sais pas si c'est utile, je le garde au besoin
          \NbPart + 1
          
        EndWith
        
        Project\NbSound +1
        
        ; on update l'image et le tracj (canvas)
        UpdateDrawingTrack(1)
        
      EndIf
      ;}
      
    Case #TypeImage
      ;{ type image
      
      Track()\FileName$ = OpenFileRequester(Lang("Choose a file"), "", "Images files (jpg,bmp,png,tga,tiff)|*.jpg;*.png;*.bmp;*.tga;*.tiff",0)
      
      If Track()\FileName$ <> ""
        
        Newname$ = GetFilePart(Track()\FileName$)
        Newname$ = RemoveString(Newname$,"."+GetExtensionPart(Track()\FileName$))
                
        ; on définit les paramètres par defaut
        With Track()
          
          \Name$    = Newname$
          \File     = LoadImage(#PB_Any, \FileName$)
          If \file
            
            \Height = options\TrackInfoH -4
            \WidthForImageSound = (ImageWidth(\file) * \Height)/ImageHeight(\file) 
            
            ; on ajoute une part par defaut. 
            ; Avec l'outil paint, on pourra en ajouter ensuite à la volée
            keyPart$ = Str(\NbPart)
            AddMapElement(\Part(), keyPart$)
            \part()\Width   = 200
            \part()\Height  = options\TrackInfoH -4
            \part()\ID      = \NbPart ; je ne sais pas si c'est utile, je le garde au besoin
            \NbPart + 1
          EndIf
          
        EndWith
        
        Project\NbSound +1
        
        ; on update l'image et le tracj (canvas)
        UpdateDrawingTrack(1,1)

      EndIf
      
      ;}
    
  EndSelect
  
EndProcedure

Macro SelectPart(part_)
  ForEach part_
    part_\Selected = 0
  Next 
  
  ForEach part_
    
    If X > part_\X * Z   And X < (part_\X  + part_\Width) * Z 
      keyPart$ = MapKey(part_)                   
      track()\part(keyPart$)\Selected = 1                 
      UpdateDrawingTrack()
      Break
    EndIf
    
  Next                 
EndMacro

Procedure EventTrack(EventGadget,EventType)
  Shared key$, xx, Move, keyPart$, Trouve, Pt, WindowWidth
  
  DeleteTrack = 0
  
  
  Select EventGadget
      
    Case Track()\B_Propertie
      OpenPropertieTrack()
      
    Case track()\GadgetId
      
      ;{ The Track Sound
      
      X = GetGadgetAttribute(track()\GadgetId, #PB_Canvas_MouseX)
      Y = GetGadgetAttribute(track()\GadgetId, #PB_Canvas_MouseY)
      w1 = options\InfoW
      
      Z.d = Options\Zoom/100
      If Z =0
        Z = 0.1
      EndIf
      
      Precision = Options\PrecisionPt
      
      With track()
        
        Select Options\Tool
            
          Case #ToolPaint
            
            ;{ temporaire ?
            Select EventType 
                
              Case #PB_EventType_LeftButtonUp
                move = 0
                
              Case #PB_EventType_LeftButtonDown    
                If \SoundId <> -1
                  
                  snap(X, (options\PixSec * Z))
                  
                  X * options\PixSec                 
                  
                  If X >= 0 
                    
                    trouve = 0
                    
                    ForEach \part()                    
                      If (X >= \part()\X * Z And X <= (\part()\X  + \part()\Width)) * Z
                        ; rien car on est sur la partie                     
                        trouve = 1
                        Break
                      EndIf                   
                    Next
                    
                    If trouve = 0
                      
                      keyPart$ = Str(\NbPart)
                      AddMapElement(\Part(), keyPart$)
                      \part(keyPart$)\Width   = (Options\BPM * \SoundLengthMs)/1000 
                      \part(keyPart$)\Height  = Options\TrackInfoH - 4
                      \part(keyPart$)\ID      = \NbPart
                      \NbPart + 1                      
                      \part(keyPart$)\X = X 
                      
                      ForEach \part()
                        \part()\Selected = 0
                        ; Debug "X : "    + \part()\X
                        ;Debug "Widht "  + \part()\Width
                      Next
                      ; on resélectionne la part active, celle qu'on vient de créer
                      \part(keyPart$)\Selected = 1
                      move = 1
                      UpdateDrawingTrack()
                      StatusBarText(#statusbar_main,2,"Nombre de part : " + Str(MapSize(\Part())))
                    EndIf
                    
                  EndIf
                EndIf
                
              Case #PB_EventType_MouseMove    
                
                If move = 1 
                  
                  If \part(keyPart$)\Selected 
                    
                    snap(X, (options\PixSec * Z))
                    
                    \part(keyPart$)\X = X * options\PixSec  
                    
                    UpdateDrawingTrack()
                    
                  EndIf
                  
                EndIf  
                
            EndSelect
            ;}
            
          Case #ToolMove 
            
            ;{ move the part
            If EventType = #PB_EventType_LeftButtonDown                 
              
              move = 1 
              
              SelectPart(\part())                  
              
              If \part(keyPart$)\Selected                  
                
                snap(X, (options\PixSec * Z))
                
                \part(keyPart$)\X = X * options\PixSec 
                
                UpdateDrawingTrack()
                
              EndIf
              
              
            ElseIf EventType = #PB_EventType_MouseMove    
              
              If move = 1 
                
                If \part(keyPart$)\Selected 
                  
                  snap(X, (options\PixSec * Z))
                  
                  \part(keyPart$)\X = X * options\PixSec  
                  
                  UpdateDrawingTrack()
                  
                EndIf
                
              EndIf  
              
            ElseIf EventType = #PB_EventType_LeftButtonUp
              
              move =0
              
            EndIf
            ;}
            
          Case #ToolSelect 
            
            ;{ select parts
            If EventType = #PB_EventType_LeftButtonDown 
              
              SelectPart(\part())                 
              
            EndIf
            ;}
            
          Case #ToolPan
            
            ;{ courbe du pan
            ;}
            
          Case #ToolVolume
                      
            ;{ courbe du volume
            For i = 0 To  ArraySize(\VolCurv())
              \VolCurv(i)\id = 0
            Next  i
            
            For i = 0 To  ArraySize(\VolCurv())
              
              PlaceFree(X, Y, Precision, Precision, \VolCurv(i)\X, \VolCurv(i)\Y)
              
              If placeFree = 0                
                \VolCurv(i)\id = 1
                UpdateDrawingTrack()
                Break
              Else
                
              EndIf
              
            Next i
            
            
            If EventType = #PB_EventType_LeftButtonDown                 
              
              move = 1 
              Trouve = 0
              
              For i = 0 To  ArraySize(\VolCurv())
                
                PlaceFree(X,Y,Precision,Precision,\VolCurv(i)\X,\VolCurv(i)\Y) ; macro qui donne PlaceFree= 1 (place libre) ou 0 (déjà existant)
                
                If PlaceFree = 0
                  Trouve = 1
                  Pt = i
                  Break
                EndIf 
                
              Next i
              
              If Trouve = 0
                
                ; on n'a trouvé e noeud à l'emplacement, on ajoute un nouveua noeud
                
                nb = ArraySize(\VolCurv()) ; pour redim le tableau
                
                ReDim \VolCurv(nb + 1)
                \VolCurv(nb+1)\X = X
                \VolCurv(nb+1)\Y = Y
                
                SortStructuredArray(\VolCurv(), #PB_Sort_Ascending, OffsetOf(LMS_Curve\X), TypeOf(LMS_Curve\X))
                
                UpdateDrawingTrack()
              EndIf
              
            ElseIf  EventType = #PB_EventType_MouseMove
              
              If move = 1 And Trouve = 1 ; on a trouvé un point, on peut le bouger
                
                If X >= 0 And X <= WindowWidth And Pt >0 And Pt < ArraySize(\VolCurv())
                  \VolCurv(Pt)\X = X
                EndIf
                
                If Y >= 0 And Y <= Options\TrackInfoH * z
                  \VolCurv(Pt)\Y = Y
                EndIf
              
                SortStructuredArray(\VolCurv(), #PB_Sort_Ascending, OffsetOf(LMS_Curve\X),TypeOf(LMS_Curve\X))
                
                UpdateDrawingTrack()
                
              EndIf
              
            ElseIf EventType = #PB_EventType_LeftButtonUp
              
              move =0
               SortStructuredArray(\VolCurv(), #PB_Sort_Ascending, OffsetOf(LMS_Curve\X),TypeOf(LMS_Curve\X))
                
               UpdateDrawingTrack()
               
            ElseIf EventType = #PB_EventType_RightButtonDown
              
              Trouve = 0
              tot = ArraySize(\VolCurv())
              
              For i = 0 To  tot 
                
                PlaceFree(X,Y,Precision,Precision,\VolCurv(i)\X,\VolCurv(i)\Y) ; macro qui donne PlaceFree= 1 (place libre) ou 0 (déjà existant)
                
                If PlaceFree = 0 And  i <> 0 And i <> tot ;on ne supprime ni le dernier ni le premier ^^
                  Trouve = 1
                  n = i                  
                  Break
                EndIf 
                
              Next i
              
              If trouve = 1; on a trouvé un element dans le tableau (on vient de cliquer sur un élément à supprimer)
                
                ; on enlève l'élement du tableau
                If n > 0
                  
                  begin = n - 1 ; on s'arrête avant l'éement à supprimer
                  Dim BeginArray.LMS_Curve(begin) ; on copié le début du tableau -1 (les élements avant l'élement à supprimer
                  
                  fin = ArraySize(\VolCurv()) - n -1; le nombre d'element après l'élement à supprimer
                  Dim EndArray.LMS_Curve(fin); pour copier les éléments après l'élement à supprimer                
                
                  Debug n
                  Debug fin
                  
                  
                  For i = 0 To begin
                    BeginArray(i)\X = \VolCurv(i)\X
                    BeginArray(i)\Y = \VolCurv(i)\Y
                  Next i
                  
                  For i = 0 To fin
                    EndArray(i)\X = \VolCurv(i + n + 1)\X
                    EndArray(i)\Y = \VolCurv(i + n + 1)\Y
                  Next i
                  
                  
                  newsize = ArraySize(\VolCurv()) - 1 ; on enlève un élement
                  FreeArray(\VolCurv())
                  Dim \VolCurv(newsize)
                  
                  For i = 0 To begin
                    \VolCurv(i)\X = BeginArray(i)\X 
                    \VolCurv(i)\Y = BeginArray(i)\Y 
                  Next i
                  
                  For i = 0 To fin
                    \VolCurv(i + begin + 1)\X = EndArray(i)\X 
                    \VolCurv(i + begin + 1)\Y = EndArray(i)\Y 
                  Next i
                  
                  SortStructuredArray(\VolCurv(), #PB_Sort_Ascending, OffsetOf(LMS_Curve\X),TypeOf(LMS_Curve\X))
                  
                  UpdateDrawingTrack()
                  
                EndIf
              EndIf
              
            EndIf
            
            ;}
            
          Case #ToolEraser
            
            If EventType = #PB_EventType_LeftButtonDown 
              
              SelectPart(\part())
              
              DeleteMapElement(\part(),keyPart$)
              
              UpdateDrawingTrack()
              
            EndIf
            
        EndSelect                
        
      EndWith
      
      ;         Select EventType() 
      ;             
      ;           Case #PB_EventType_LeftButtonDown
      ;             
      ;             ForEach Track()
      ;               Track()\Selected = 0  
      ;             Next
      ;             
      ;             If FindMapElement(track(), key$)
      ;             EndIf
      ;             
      ;             Track(key$)\Selected = 1  
      ;             
      ;             UpdateDrawingTrack()
      ;             
      ;           Case #PB_EventType_RightButtonDown
      ;             ;AddSoundToTrack()  
      ;             ; on pourrait ouvrir un menu avec divers trucs à faire ^^
      
      ;         EndSelect
      
      
      
      
      ;}
      
    Case Track()\CB_PanCurv
      Track()\ShowPanCurv = GetGadgetState(track()\CB_PanCurv)
      UpdateDrawingTrack()
      
    Case Track()\CB_VolCurv
      Track()\ShowVolCurv = GetGadgetState(track()\CB_VolCurv)
      UpdateDrawingTrack()
      
    Case Track()\B_Propertie
      
    Case Track()\TB_Pan
      Track()\Pan = GetGadgetState(Track()\TB_Pan) -100
      
    Case Track()\TB_Vol
      Track()\VolumeMax     = GetGadgetState(Track()\TB_Vol)
      Track()\VolumeCurrent = GetGadgetState(Track()\TB_Vol)
      
    Case Track()\B_Mute
      Track()\Mute = GetGadgetState(Track()\B_Mute)
      
    Case Track()\B_Solo
      Track()\Solo = GetGadgetState(Track()\B_Solo)
      
    Case Track()\ST_Name
      Track()\Name$ = GetGadgetText(Track()\ST_Name)
      
    Case Track()\BI_Cross
      Y = GadgetY(Track()\GadgetId)        
      FreeGadget(Track()\GadgetId)
      FreeGadget(Track()\GadInfo)
      DeleteMapElement(track(),key$)
      DeleteTrack = 1
      
    Case Track()\B_File
      AddSoundToTrack() 
        
    EndSelect
    
    
   ; on replace les Tracks de haut en bas; si on a supprimer un track
   If DeleteTrack
     
     ForEach track()
       
       With track()
         
        If GadgetY(\GadgetId) >= Y +  GadgetHeight(\GadgetId)
          NewY = GadgetY(\GadgetId) - GadgetHeight(\GadgetId) - 1 
          ResizeGadget(\GadgetId,#PB_Ignore,NewY,#PB_Ignore,#PB_Ignore)
          ResizeGadget(\GadInfo,#PB_Ignore,NewY,#PB_Ignore,#PB_Ignore)
        EndIf
        
      EndWith 
      
    Next 
    
  EndIf  
  
EndProcedure

Procedure SelectTrack(EventGadget,EventType)
  Shared key$
  
  trouve = 0
  
  ForEach Track()
    
    With Track()
      
      Select  EventGadget 
          
        Case \GadInfo,\B_File,\B_Mute,\B_Solo,\BI_Cross,\TB_Pan,\TB_Vol,\GadgetId,\B_Propertie,\CB_VolCurv,\CB_PanCurv
                     ;             
            key$ = MapKey(Track())
            If FindMapElement(track(), key$)
            EndIf
            
            trouve = 1
            
            Break          
         
      EndSelect
      
    EndWith
    
  Next
  
  If trouve = 1
    
    If EventType = #PB_EventType_LeftButtonDown
      
      ForEach Track()
        Track()\Selected = 0  
        UpdateDrawingTrack()
      Next
      
      If FindMapElement(track(), key$)
      EndIf
      
      Track(key$)\Selected = 1  
      
      UpdateDrawingTrack()
      
    EndIf
    
    ProcedureReturn 1 
          
  EndIf
  
  
ProcedureReturn  0
EndProcedure

Procedure UpdatePostrack()
  
  h   = options\TrackInfoH
  gh  = options\SpaceBetweenTracks

  i.w = 0
  ResetMap(track())
  
  For j = 0 To MapSize(track())
    If FindMapElement(track(), "Track"+Str(j))
      With track() 
        ResizeGadget(\GadInfo,#PB_Ignore,i * ( h + gh ) - Options\ScrollBarY,#PB_Ignore,#PB_Ignore)
        i + 1
      EndWith
    EndIf
  Next  j  
  
 
EndProcedure

Procedure ScrollHandler()
  Shared OldPosY, key$
  
  h   = options\TrackInfoH
  gh  = options\SpaceBetweenTracks
  
  options\ScrollBarY = GetGadgetAttribute(#SA_Work,#PB_ScrollArea_Y)
  options\ScrollBarX = GetGadgetAttribute(#SA_Work,#PB_ScrollArea_X)

  snap(options\ScrollBarY,( h + gh )) 
  
  
  options\ScrollBarY  = options\ScrollBarY * ( h + gh )
  PosY                = options\ScrollBarY
  
  SetGadgetAttribute(#SA_Work,#PB_ScrollArea_Y, options\ScrollBarY) 
  
  i.w = 0
  
  ResetMap(track())
  
  For j = 0 To MapSize(track())
    If FindMapElement(track(), "Track"+Str(j))
      With track() 
        ResizeGadget(\GadInfo,#PB_Ignore,i * ( h + gh ) - Options\ScrollBarY,#PB_Ignore,#PB_Ignore)
        i + 1
      EndWith
    EndIf
  Next  j  
  
  FindMapElement(track(),key$)
  
EndProcedure

;}

;{ UI, Window...

Procedure ResetButton(btn)
  
  For i = 0 To 5
    SetGadgetState(#Btn_Move+i,0)
  Next i
  SetGadgetState(btn,1)

EndProcedure

Procedure ResizeGadgetswin_main()
  Shared WindowWidth, WindowHeight
  
  WindowWidth = WindowWidth(#win_main)
  WindowHeight = WindowHeight(#win_main)
  h = WindowHeight - options\ToolbarH - options\MarkerH - StatusBarHeight(#statusbar_main) - MenuHeight() 
  h  - options\ETG_GestionH -10;   - (options\SA_WorkH * options\ShowGestionArea)

  ; the toolbar Width
  ResizeGadget(#ToolBar, #PB_Ignore, #PB_Ignore, WindowWidth +10, #PB_Ignore)
  
  ;{ Area Work (audio Tracke), marker region, Infotracks
  
  ResizeGadget(#SA_Work,#PB_Ignore,#PB_Ignore,WindowWidth - options\InfoW,h+2)
  SetGadgetAttribute(#SA_Work,#PB_ScrollArea_InnerWidth,WindowWidth +100)
  SetGadgetAttribute(#SA_Work,#PB_ScrollArea_InnerHeight,WindowHeight + 100)
  
  ; Marker
  ResizeGadget(#Timeline,#PB_Ignore,#PB_Ignore,WindowWidth+options\InfoW,#PB_Ignore)
  UpdateTimeline()
  
  ;Tracks info
  ResizeGadget(#C_trackInfo,#PB_Ignore,#PB_Ignore,#PB_Ignore,h)
  ;}
  
  ;{ Area gestion : volume general, sample wave list or explorer...
  yy  = GadgetHeight(#SA_Work) + GadgetY(#SA_Work) +5 ; 
  ;h   = WindowHeight - StatusBarHeight(#statusbar_main) - options\SA_WorkH  - MenuHeight() 
  ;ResizeGadget(#SA_Gestion,#PB_Ignore,yy,WindowWidth,options\SA_WorkH)
  
  ResizeGadget(#ETG_gestion,#PB_Ignore, yy, #PB_Ignore, #PB_Ignore)
  
  width = options\ETG_GestionW + Options\Pan_gestionW
  
  ResizeGadget(#LI_Gestion,#PB_Ignore, yy, WindowWidth - width  -15, #PB_Ignore)
  
  ResizeGadget(#Pan_Gestion,GadgetX(#LI_Gestion) + WindowWidth - width -5, yy, Options\Pan_gestionW -5, #PB_Ignore)

  ;}
  
EndProcedure

Procedure OpenWin_main(x = 0, y = 0, width = 800, height = 600)
  
  ResetParameters()
  OpenOptions()
  
  If OpenWindow(#win_main, x, y, width, height, #ProgramName + " " + options\Version$, 
                #PB_Window_SystemMenu | #PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget | 
                #PB_Window_SizeGadget | #PB_Window_ScreenCentered | #PB_Window_Maximize) = 0
    End
  EndIf
  HideWindow(#win_main,1)
  
  LoadFont(#FontTrackName,"Arial",7)
  SetWindowColor(#win_main, Options\ColorWindow)

  ;{ Menu
  If CreateImageMenu(#Menu_WinMain, WindowID(#win_main))
    MenuTitle(Lang("Files")) 
    MenuItem(#menu_New,    "&"+Lang("New")   + Chr(9) + "Ctrl+N")
    MenuItem(#menu_Open,    Lang("Open")    + Chr(9) + "Ctrl+O")
    MenuBar()
    MenuItem(#menu_Save,    Lang("Save")    + Chr(9) + "Ctrl+S")
    MenuItem(#menu_SaveAs,  Lang("SaveAs"))
    MenuBar()
    MenuItem(#menu_Export,  Lang("Export")  + Chr(9) + "Ctrl+E")
    MenuBar()
    MenuItem(#menu_Pref,    Lang("Preferences") + Chr(9) + "Ctrl+P")
    MenuBar()
    MenuItem(#menu_Exit,    Lang("Exit")    + Chr(9) + "Escape")

    MenuTitle(Lang("Edition"))
    ;MenuItem(#menu_CutTrack, "Cut the Selection")
    ;MenuItem(#menu_CopyTrack, "Copy the Selection")
    ;MenuItem(#menu_PasteTrack, "Paste the Selection")
    
    ;MenuBar()
    MenuItem(#menu_MoveAllTracks,   Lang("Move all the tracks"))
    MenuItem(#menu_DeleteAllParts,  Lang("Delete all parts"))
    MenuBar()
    MenuItem(#menu_EditTrackSelected,   Lang("Edit the track"))
    ;MenuItem(#menu_DuplicateSelTrack, "Duplicate the Selected track")
    
    MenuTitle(Lang("View"))
    MenuItem(#menu_ShowStatus,   Lang("Show the statusbar"))
;     MenuBar()
;     MenuItem(#menu_CurveToolVol,   Lang("CurveToolVol"))
;     MenuItem(#menu_CurveToolVol,   Lang("CurveToolPan"))
    
    MenuTitle(Lang("Tracks"))
    MenuItem(#menu_AddTrackAudio,  Lang("Add new Audio track"))
    MenuItem(#menu_AddTrackImage,  Lang("Add new Image track"))
    MenuBar()
    MenuItem(#menu_AddSound,  Lang("Import a sound"))
    ;MenuItem(#menu_DeleteSelectedTrack,"Delete Selected Track")
    
    MenuTitle(Lang("Tools"))
    MenuItem(#menu_ToolDrumer,   Lang("Drumers"))
    DisableMenuItem(#Menu_WinMain, #menu_ToolDrumer, 1)
    ;MenuItem(#menu_Synthe,   Lang("Synthe"))
    
    MenuTitle(Lang("Help"))
    MenuItem(#menu_AboutPS,Lang("About"))
    
  EndIf
  ;}
  
  ;{ keyboardshortcut
  AddKeyboardShortcut(#win_main, #PB_Shortcut_N|#PB_Shortcut_Control, #menu_New)
  AddKeyboardShortcut(#win_main, #PB_Shortcut_O|#PB_Shortcut_Control, #menu_Open)
  AddKeyboardShortcut(#win_main, #PB_Shortcut_S|#PB_Shortcut_Control,#menu_Save)
  AddKeyboardShortcut(#win_main, #PB_Shortcut_P|#PB_Shortcut_Alt, #menu_Pref)
  AddKeyboardShortcut(#win_main, #PB_Shortcut_Escape, #menu_Exit)
  ;}  
  
  ;{ Toolbar
 If ContainerGadget(#ToolBar, -5, -2, 1200, options\ToolbarH, #PB_Container_Double)
   
   x1 = 26
   yy = 0
   xx = 5
    
    ;{ Project : New, open, save
    ButtonImageGadget(#Btn_NewProject,    xx,      yy,24,24,ImageID(#ico_New))
    ButtonImageGadget(#Btn_OpenProject,   xx+x1,   yy,24,24,ImageID(#ico_Open))
    ButtonImageGadget(#Btn_Saveproject,   xx+x1 *2, yy,24,24,ImageID(#ico_save))
    xx + x1*3 
    ;}
    ;{ Tracks : New, import a sound
    xx = InsertBar(xx)
    ButtonImageGadget(#Btn_NewTracke,     xx, yy,24,24,ImageID(#ico_Add))
    ButtonImageGadget(#Btn_ImportSample,  xx+x1, yy,24,24,ImageID(#ico_Open))
    xx + x1*2 
    ;}
    ;{ Mesure time
    xx = InsertBar(xx)     
    StringGadget(#SP_MesureTime1,xx,yy+2,20,20,Str(Options\MesureTime1), #PB_String_Numeric)
    TextGadget(#PB_Any,xx+25,yy+5,5,20,"/")
    StringGadget(#SP_MesureTime2,xx+35,yy+2,20,20,Str( Options\MesureTime1), #PB_String_Numeric)
    xx + 60
    ;}
    ;{ BPM
    xx = InsertBar(xx)    
    SpinGadget(#SP_BPM,xx,yy+2,40,20,5,500,#PB_Spin_Numeric)
    SetGadgetState(#SP_BPM,Options\BPM)
    xx + 45
    ;}
    ;{ Zoom
    xx = InsertBar(xx)    
    ; Zoom 
    SpinGadget(#SP_Zoom,xx,yy+2,40,20,1,200,#PB_Spin_Numeric)
    SetGadgetState(#SP_Zoom,Options\zoom)
    xx +50
    TrackBarGadget(#TB_Zoom,xx,yy+2,100,20,1,200)
    SetGadgetState(#TB_Zoom,options\Zoom)
    xx + 110
    ;}
    ;{ Snap
    xx = InsertBar(xx)
    ButtonImageGadget(#B_Snap,xx, yy,24,24,ImageID(#ico_Snap),#PB_Button_Toggle)
    xx+x1
    ComboBoxGadget(#Cb_snap,xx,yy+2,110,20)
    AddGadgetItem(#Cb_snap,0,"Snap To Mesure")
    AddGadgetItem(#Cb_snap,1,"Snap To Second")
    SetGadgetState(#CB_snap,0)
    xx+ 115
    ;}    
    ;{ Playing buttons
    xx = InsertBar(xx)
    ButtonImageGadget(#Btn_Stop,  xx,   yy,24,24,ImageID(#ico_Stop))
    ButtonImageGadget(#Btn_Pause, xx+x1, yy,24,24,ImageID(#ico_Pause))    
    ButtonImageGadget(#Btn_Play,  xx+x1*2, yy,24,24,ImageID(#ico_Play),#PB_Button_Toggle)
    ButtonImageGadget(#Btn_Loop,  xx+x1*3, yy,24,24,ImageID(#ico_Loop),#PB_Button_Toggle)
    xx + x1*4
    ;}
    ;{ Tools buttons
    xx = InsertBar(xx)
    ButtonImageGadget(#Btn_Move,     xx,yy,24,24,ImageID(#ico_move),#PB_Button_Toggle) : xx + x1
    ButtonImageGadget(#Btn_Select,  xx,yy,24,24,ImageID(#ico_Select),#PB_Button_Toggle) : xx + x1
    ButtonImageGadget(#Btn_Paint,   xx,yy,24,24,ImageID(#ico_Paint),#PB_Button_Toggle)  : xx + x1
    ButtonImageGadget(#Btn_Volume,  xx,yy,24,24,ImageID(#Ico_Volume),#PB_Button_Toggle) : xx + x1
    ButtonImageGadget(#Btn_Pan,     xx,yy,24,24,ImageID(#ico_Pan),#PB_Button_Toggle)    : xx + x1  
    ButtonImageGadget(#Btn_Eraser,  xx,yy,24,24,ImageID(#ico_Erase),#PB_Button_Toggle)  : xx + x1
    ;}
    
    ;{ GadgetTooltip
    
    ; project
    GadgetToolTip(#Btn_NewProject,  Lang("Create a new Project"))
    GadgetToolTip(#Btn_OpenProject, Lang("Open a Project"))
    GadgetToolTip(#Btn_Saveproject, Lang("Save the Project"))
    
    ; tracks
    GadgetToolTip(#Btn_NewTracke,   Lang("Add a new Track"))
    GadgetToolTip(#Btn_ImportSample,Lang("Import a sample"))
    
    ; mesure time
    GadgetToolTip(#SP_MesureTime1,  Lang("Mesure Time number"))
    GadgetToolTip(#SP_MesureTime2,  Lang("Mesure Time value"))
    
    ; bpm
    GadgetToolTip(#SP_BPM,          Lang("Change the BPM"))
    
    ; snapping
    GadgetToolTip(#CB_snap,         Lang("Define Snapping"))
    GadgetToolTip(#B_Snap,          Lang("Active Snapping"))
    
    ; playing
    GadgetToolTip(#Btn_Play,        Lang("Play the sound"))
    GadgetToolTip(#Btn_Pause,       Lang("Pause the sound"))
    GadgetToolTip(#Btn_Stop,        Lang("Stop the sound"))
    GadgetToolTip(#Btn_Loop,        Lang("Loop the sound"))

    ; zoom   
    GadgetToolTip(#SP_Zoom,         Lang("Set the Zoom"))
    GadgetToolTip(#TB_Zoom,         Lang("Set the Zoom"))
    
    ; tools
    GadgetToolTip(#Btn_Move,        Lang("Move the part"))
    GadgetToolTip(#Btn_Select,      Lang("Select the part"))
    GadgetToolTip(#Btn_paint,       Lang("Add part"))
    GadgetToolTip(#Btn_Volume,      Lang("Set the volume curve"))
    GadgetToolTip(#Btn_Pan,         Lang("Set the pan curve"))
    GadgetToolTip(#Btn_Eraser,      Lang("Eraser tool"))
    

    ;}
    
    CloseGadgetList()
  EndIf
  ;}
  
  ;{ StatusBar
  If CreateStatusBar(#statusbar_main,WindowID(#win_main))
    AddStatusBarField(200)
    AddStatusBarField(250)
    AddStatusBarField(200)
    AddStatusBarField(200)
  EndIf
  ;}
  
  ;{ Scrollarea
  h = height - options\SA_WorkH -options\ToolbarH - options\MarkerH - StatusBarHeight(#statusbar_main) - MenuHeight() - options\ETG_GestionH
  yy = options\ToolbarH + options\MarkerH +1
  
    If ContainerGadget(#C_trackInfo,2,yy+2,options\InfoW-5,h-yy-2, #PB_Container_Single)
      CloseGadgetList()
    EndIf    
  
  CreateTimeline()
  
  xx= options\InfoW
  If ScrollAreaGadget(#SA_Work, xx, yy, Width, h ,Width +100,height-100,options\TrackInfoH,#PB_ScrollArea_Raised)
    SetGadgetColor(#SA_Work,#PB_Gadget_BackColor, RGB(220,220,220))    
    CloseGadgetList()    
  EndIf
  
  ;}
  
  ;{ Gestion Area
  ; des explorer pour gérer les samples
  yy + h
  W1  = Options\ETG_GestionW  
  H   = Options\ETG_GestionH
  W2  = Options\Pan_gestionW
  W3  = Windowwidth - w1 - w2 -10

  If ExplorerTreeGadget(#ETG_gestion, 2, yy, W1, h, GetCurrentDirectory() +"samples",#PB_Explorer_NoDriveRequester|#PB_Explorer_NoFiles) ; + "*.wav;*.ogg"
  EndIf
  
  If ListIconGadget(#LI_Gestion, W1 + 5, yy, w, h, "", W1)
    SetGadgetAttribute(#LI_Gestion, #PB_ListIcon_DisplayMode , #PB_ListIcon_List)
  EndIf
  

  
  
  If PanelGadget(#Pan_Gestion, WindowWidth - w1 - 5, yy, w2, h)
    AddGadgetItem(#Pan_Gestion, 0, "Mixer")
    
    TrackBarGadget(#TB_MixL, 20, 10, 40, h-50,  0, 100, #PB_TrackBar_Vertical)
    TrackBarGadget(#TB_MixR, 60, 10, 40, h-50,  0, 100, #PB_TrackBar_Vertical)
    
   
    
    AddGadgetItem(#Pan_Gestion, 1, "Vidéo")
    
    If ContainerGadget(#PreviewVideo, 5, 10, W2 - 15, h - 50, #PB_Container_Double)
      SetGadgetColor(#PreviewVideo, #PB_Gadget_BackColor, 0)      
      CloseGadgetList()
    EndIf
    
    CloseGadgetList()
  EndIf
  
  
  ;}
  
  ResizeGadgetswin_main()
  BindGadgetEvent(#SA_Work,@ScrollHandler())
  
  ; Add a new empty Tracke
  AddTrack()
  
  HideWindow(#win_main,0)
  

EndProcedure


; autres window

;{ Macro et procédure pour facilité de création de fenêtres

Macro Win(window,nom,w=450,h=350,flag=-1)
  If flag = -1
    flag1 = #PB_Window_SystemMenu|#PB_Window_TitleBar|#PB_Window_ScreenCentered
  Else
    flag1 = flag
  EndIf
  If OpenWindow(window,0,0,w,h,nom,flag1,WindowID(#win_main))
  EndIf
EndMacro

Macro panel(window,n,w=10,h=30)
  ; macro qui permet de créer un panel gadget automatique
  ; ensuite, on ajoute des gadgetitem grace au tableau item(), qu'on redim au besoin
  panel = PanelGadget(#PB_Any,5,5,WindowWidth(window)-w,WindowHeight(window)-h-10)
  If panel
    For i = 0 To n
      If item(i)<> ""
        AddGadgetItem(panel,i,item(i))
      EndIf      
    Next i      
    CloseGadgetList()
  EndIf
  ButtonGadget(#Btn_WinOk,WindowWidth(window)/2-90,WindowHeight(window)-h,80,25,"Ok")
  ButtonGadget(#Btn_WinCancel,WindowWidth(window)/2,WindowHeight(window)-h,80,25,"Cancel")
EndMacro

Procedure WindowLoop(win)
  
  Repeat
    ev = WaitWindowEvent()
    
    Select ev
        
      Case #PB_Event_CloseWindow
        exit = 1
        
    EndSelect
    
  Until exit = 1
  CloseWindow(win)
  
EndProcedure

;}

Procedure OpenWindowAbout()
  
  Win(#Win_About,Lang("About"))
  
  w = WindowWidth(#Win_About)-20
  h = WindowHeight(#Win_About)-20
  
  temp = CanvasGadget(#PB_Any,10,10,w,ImageHeight(#img_Logo) +40)
  editor =EditorGadget(#PB_Any, 10,ImageHeight(#img_Logo) +60 ,w,h-ImageHeight(#img_Logo) -60,#PB_Editor_ReadOnly|#PB_Editor_WordWrap)
  
  SetGadgetColor(editor,#PB_Gadget_BackColor,   RGB(120, 120, 120))
  
  
  Info$ = #ProgramName + lang("AboutLMS0") + #Author + " " + lang("AboutLMS1") + Chr(13) +
          Chr(13) + lang("AboutLMS2")  +
          Chr(13) + lang("AboutLMS3")  +
          Chr(13) + lang("AboutLMS4")  +  Chr(13) +
          Chr(13) + Chr(13) + "Date : "+ options\Date$ +
          Chr(13) + Chr(13) + "Version : " +Options\Version$ +
          Chr(13) + Chr(13) + Lang("Icon") + " : David Vignoni, Everaldo Coelho, Vlademareous" + 
          Chr(13) + Chr(13) + Lang("Thanks")+ " : Fred, GallyHC, Dobro, Flype"
  
  
  If StartDrawing(CanvasOutput(temp))
    Box(0,  0,  w,  h,  RGB(120, 120, 120))
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    DrawAlphaImage(ImageID(#img_Logo),  20, 20)
    DrawingMode(#PB_2DDrawing_Transparent)
    DrawText(30 +  ImageWidth(#img_Logo),  40, #ProgramName)
    StopDrawing()
  EndIf
  
  SetGadgetText(editor,info$)
  
  ;WindowLoop(#Win_About)
  
EndProcedure

Procedure OpenWindowpref()
  
  Define panel
  
  Win(#Win_Pref,Lang("Preferences"))
  
  Dim item.s(2)
  item(0) = "General"
  item(1) = "Interface"
  item(2) = "Debugging"
  panel(#Win_Pref,2)
  
  If OpenGadgetList(panel, 0)
    yy = 10
    ComboBoxGadget(#Cbb_PrefLang, 10, 10, 100, 20)
    
    ;{ langage
    st = TextGadget(#PB_Any,10,11,Len(lang("Langage")+" : ")*7+5,22,lang("Langage")+" : ")
    x = GadgetWidth(st)
    ComboBoxGadget(#Cbb_PrefLang,10+x,10,50,22)
    If ExamineDirectory(0,"data\Text\Lang","*.ini")
      While NextDirectoryEntry(0)
        nom$ = RemoveString(DirectoryEntryName(0), ".ini")
        AddGadgetItem(#Cbb_PrefLang,-1,nom$)
        If nom$= options\Lang$
          SetGadgetText(#Cbb_PrefLang,nom$)
        EndIf          
      Wend 
    EndIf    
      ;}
      
    ;{ others gadgets
    yy + 40
    temp = CreateImage(#PB_Any, 32, 32)
    
    If temp
      If StartDrawing(ImageOutput(temp))
        Box(0, 0, 32, 32, Options\ColorWindow)
        StopDrawing()
      EndIf
    EndIf
    ImageGadget(#IG_PrefUIColor,10, yy, 32, 32, ImageID(temp))
    GadgetToolTip(#IG_PrefUIColor,Lang("ColorWindow"))

    ;ImageGadget(#IG_PrefPlayBarColor,10, yy, 32, 32, ImageID(temp))
    
    temp2 = CreateImage(#PB_Any, 32, 32)

    If temp2
      If StartDrawing(ImageOutput(temp2))
        Box(0, 0, 32, 32, Options\ColorSelector)
        StopDrawing()
      EndIf
    EndIf
    ImageGadget(#IG_PrefColorSelector,70, yy, 32, 32, ImageID(temp2))
    
    GadgetToolTip(#IG_PrefColorSelector,Lang("ColorSelector"))
    
    
    yy + 40   
    CheckBoxGadget(#Cb_PrefGradient, 10, yy, 100, 20, Lang("GradientOntrack"))
    ;}
        
    CloseGadgetList()
  EndIf
    
  If OpenGadgetList(panel, 2)
    CloseGadgetList()
  EndIf
  
EndProcedure

Procedure OpenPropertieTrack()
  
  Win(#Win_TrackProperties,Lang("Propertie"))
  
  Dim item.s(2)
  item(0) = "General"
  item(1) = "Note"
  item(2) = "Info"
  panel(#Win_TrackProperties,2)
  
  
EndProcedure
;}


; IDE Options = PureBasic 5.20 LTS (Windows - x86)
; CursorPosition = 542
; FirstLine = 57
; Folding = gIMdkPAgLKABAAC+
; EnableXP