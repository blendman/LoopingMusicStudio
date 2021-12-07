;{ Infos
; Looping (Music Studio) : an audio virtual samplers and mixer

; This file is OpenSource. You can use it, modify it, but not sale it. 
; If you use it, you have To give the rouces please. 
;  And don't forget the name of the author  ;)

; Made by Blendman for PGC
; Version Windows, tested under  windows8 x86
; Date : 09/09/2013
; Modification : 12/09/2013
; PB 5.20 LTS
;}


;{ Explication technique (FR)

; Pour le moment, peu de choses sont disponibles.
; si je trouve le temps, j'essaierai de les ajouter par la suite.

; cependant, étant donné que je suis hyperacousique et accouphénique, 
; je ne peux pas tester cette application comme je le voudrais. 
; Donc, les changements seront surtout d'ordre graphique et utiles, et non sonore.


; généralité sur les tracks (pistes audio) : 
; - on peut ajouter des pistes (tracks)
; - sur cette piste, on peut ajouter un seul son (wave, ogg).
; - On pourra ensuite reproduire ce son sur le tracks : chaque partie reproduite s'appelle une "part" (part en anglais).
; - on pourra ensuite utiliser des outils pour modifer ces parts : les bouger de place, les couper, etc...


; Fonctions diverses :
; - Snap
; - Mesure : temps1/temps2 (3/4,4/4,6/8,5/4, etc..)
; - BPM (beat per seconds)
; - si possible gérer la tonalité ?


; OUTILS d'édition de tracks
; Comme une sorte de sampler virtuel, on pourra par la suite : 
; - peindre des "parts", soit des morceaux du son de la piste, c'est à dire répéter le son là où on veut, en entier ou par partie.
; - Supprimer des "parts", des morceaux de "parts", les couper
; - déplacer des parts, collées à une grille (lié à la mesure et au temps), grace au snap.
; - gestion générale du volume par courbe, sur le tracks
; - gestion générale du pan par courbe sur le tracks.



; FONCTION des tracks (prévue plus tard) :
; - Gestion générale du volume, du pan, mute et solo
; - choix du son, avec possiblité de changer le son et garder le tracks avec les parts
; - destruction du tracks


; AUTRES OUTILS :
; - Looping Battery : utilitaire pour concevoir un loop de batterie
; - Looping Sampler : utilitaire pour concevoir un loop avec des samples pour jouter des mélodies (pouvoir donc changer la tonalité d'un sample wave (ou ogg).


; SORTIE :
; - volume générale
; - export de la music

;}

; IDE Options = PureBasic 5.20 beta 17 LTS (Windows - x86)
; CursorPosition = 10
; FirstLine = 1
; Folding = -
; EnableXP