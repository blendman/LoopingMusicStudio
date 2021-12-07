
; Structures

;{ Project 
Structure PS_Project
  
  ;{ general
  Author$
  Info$
  Date$
  Description$
  Version$
  ;}
  
  ;{ tempo  Project
  MesureTime1.w; time of the mesure  : 4/4, 3/4, 5/4 -> the first number  , for 3/4 => 3
  MesureTime2.w; time of the mesure  : 4/4, 3/4, 5/4 -> the second number , for 3/4 => 4
  BPM.w
  ;}
  
  ;{ project
  Name$
  IdTrack.w ; pour connaitre le track sélectionné
  SelectX1.w ; le selecteur 1 sur la timeline
  SelectX2.w ; le selecteur 2 pour la timeline
  NbSound.w ; le nombre de son. Attention c'est différent du listsize() des sons
  ;}
  
EndStructure

Global Project.PS_Project
;}

;{ Settings
Structure PS_settings
  
  Checktime.w ; pour que le fps soit constant
  Delay.a
  FPSLimit.a ; ? utile ?

EndStructure
Global Settings.PS_settings
  
;}

;{ options

Structure PS_Options
  
  ;{ general for the application
  Version$
  Date$  
  Lang$
  ;}
  
  ;{ UI
  ; colors
  ColorWindow.i
  ColorTrackinfo.i
  ColorSelector.i 
  ColorGradientPart.a
  
  ; autres
  UIPerso.a; pas utilisé  
  Zoom.w
  
  ; snap
  SnapType.a ; le type de snap 0 = BPM, 1 = Minutes
  Snap.a ; snap ok ou non
  PixSec.a ; nombre de pixel par seconde, pour la timeline
  
  PrecisionPt.a ; la précision de sélection des points des courbes volume et pan sur le tracks (outils volume ou pan)
  
  ; marker (barr of time) pour la timeline. 
  ; le marker  sert pour fixer la boucle entre 2 marker (X1 et X2)
  ; cela sert pour l'affichage
  MarkerH.w ; hauteur de la timeline
  MarkerSW.w ; width d'un marker pour l'affichage
  MarkerSelH.a ; hauteur d'un marker
  
  ;others UI
  ToolbarH.w ; hauteur de la toolbar
  SA_WorkH.w ; hauteur de la work area, là se trouvent les samples (les pistes/tracks)
  InfoW.w ; width de la zone d'info, où se trouvent les infos des tracks (volume, pan, nom, croix pour fermer...)
  TrackInfoH.w ; taille d'une piste (track)
  SpaceBetweenTracks.a ; espace entre 2 pistes (track)
  
  ; Gestion des fichiers (explorer treegadget et panel en bas)
  ETG_GestionH.w
  ETG_GestionW.w
  Pan_gestionW.w
  
  ; preview video
  InitVideo.a
  ;}
  
  ;{ edition of tracks
  Tool.a ; le type d'outil choisi, pour éditer une part d'un tracks
  IdPart.i
  ;}
  
  ;{ show/draw
  ShowGestionArea.a; la zone de gestion en bas
  ;}
  
  ;{ Audio
  MesureTime1.w; time of the mesure  : 4/4, 3/4, 5/4 -> the first number  , for 3/4 => 3
  MesureTime2.w; time of the mesure  : 4/4, 3/4, 5/4 -> the second number , for 3/4 => 4
  BPM.w
  ;}
  
  ;{ options on the real time of the project
  ProjectIsPlayed.a ; joue-t-on le son du projet ?
  ScrollBarY.w ; pour le défilement verticla de l'area gadget des pistes
  ScrollBarX.w ; pour le défilement de la timeline, lié à l'area gadget des pistes
  ;}
  
EndStructure
Global Options.PS_Options

;}

;{ tracks

;{ Structure pour les morceaux qu'on aura sur une piste (un seul ou plusieurs sons ?)

Structure LMS_PartTrack
  ; Array For picture in the canvas track,
  ; paramètres généraux
  ; c'est la taille du son de base, avant édition avec les tools
  X.w
  Y.w
  Width.w
  Height.w 
  
  ; le son et le preview sur le track (la piste)
  Sound.i ; l'id du son chargé. note : Utiliser une liste, map ou un tableau plutôt, si on veut avoir plsuieurs sons possible par piste plutôt qu'un seul
  Img.i ; l'image de la piste (wave du son), note : si on utilise plusieurs sons, il faudrait aussi un tableau, liste ou map d'image
  
  ; pour l'édtion, la taille de la nouvelle partie
  BeginW.w
  EndW.w
  ID.w ; id du part, pour la selection
  Selected.a ; pour savoir si on a sélectionné la part du track (un des morceaux qui se trouve sur la piste)
EndStructure

;}


;{ structure pour la courbe (volume ou pan) du track

Structure LMS_Curve 
  X.w
  Y.w
  Id.w
EndStructure


;}


Structure LMS_Track
  
  ; généralité
  Id.w
  Name$
  FileName$ ; le fichier du tracks
  Type.a ; le type de piste : audio, image/video, synthe (plugin), batery (plugin)

  ; paramètre
  Pan.b
  VolumeCurrent.a
  VolumeMax.a
  Mute.a
  Solo.a  
  
  ; others
  Selected.a ; pour savoir si la piste est sélectionnée
  Color.i ; the color of the tracks
  
  ; pour les différents type, sauf sound
  File.i
  Height.w
  
  ; sound
  SoundId.i
  SoundLength.i
  SoundLengthMs.i
  SoundFrq.i; frequence
  SoundPos.i ; la position
  SoundVolume.i
  SoundPan.i
  Chanel.i ; pour utiliser le multichanel et jouer plusieurs sons ensemble
  
  
  ; for multipart : les parts qu'on peut ajouter sur la piste
  Map Part.LMS_PartTrack() ; la map() pour chaque "morceau" de son dupliqué et transformé (comme dans acid ou sony vegas)
  NbPart.w ; le nombre de partie par track, à garder car nécessaire (différent de listsize(part()) !
  
  
  ; Les courbes Volume et Pan
  Array VolCurv.LMS_Curve(1)
  ShowVolCurv.a
  ColorCurvVol.i ; couleur de la courbe volume

  Array PanCurv.LMS_Curve(1)
  ColorCurvPan.i ; couleur de la courbe pan
  ShowPanCurv.a
  
    
  ;{ les gadgets
  ; gadget canvas to edit the audio Tracke
  CB_VolCurv.i  ; la checkbox pour voir ou non la courbe du volume
  CB_PanCurv.i  ; la checkbox pour voir ou non la courbe du pan
  B_Propertie.i ; button propertie
  
  GadgetId.i  ; the canvas for the sound
  GadInfo.i   ; container for the gadgets for the infos
  B_Mute.i    ; button mute
  B_Solo.i    ; button solo
  BI_Cross.i  ; croix rouge pour supprimer la piste
  TB_Vol.i    ; trackbar volume
  TB_Pan.i    ; trackbar pan
  ST_Name.i   ; pour changer le nom
  B_File.i    ; le bouton pour le fichier

  
  ; 
  ImgSound.i ; the image for the sound tracks
  
  ;}
  
  ; la taille de l'image de base, en fonction du temps du sample
  WidthForImageSound.w
  
EndStructure
Global NewMap Track.LMS_Track()

;}



; IDE Options = PureBasic 5.20 LTS (Windows - x86)
; CursorPosition = 60
; FirstLine = 1
; Folding = gC+
; EnableXP