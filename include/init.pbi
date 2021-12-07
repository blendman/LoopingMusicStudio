  If InitSound() =0 Or UseOGGSoundDecoder() = 0 
    MessageRequester(Lang("Error"), Lang("Unable to use the Sound Module"))
    End
  EndIf
  
  If UsePNGImageDecoder() = 0 Or UseJPEGImageDecoder() = 0
    MessageRequester(Lang("Error"), Lang("Unable to use the Image Module"))
    End
  EndIf
  
  If InitMovie() = 0
    MessageRequester(Lang("Error"), Lang("Unable to use the Video Module"))
    Options\InitVideo = 0
  Else
    Options\InitVideo = 1
  EndIf
  

; IDE Options = PureBasic 5.20 beta 17 LTS (Windows - x86)
; CursorPosition = 1
; EnableXP