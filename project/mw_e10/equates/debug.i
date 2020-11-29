; Debug functions
; Toggle with comment

.IFDEF DEBUG

; Select cut-scene.
; Usage: Press L+R/L+R+Up during a cut-scene.
.DEFINE dbg_SelectCinema

; Advance game frame-by-frame.
; Usage: Pause then on controller 2 press Y to advance one frame, or hold B to keep advancing.
.DEFINE dbg_AdvanceFrame

; End any level.
; Usage: Pause then press Select for regular exit or Select+A/B for secret exit.
.DEFINE dbg_EndLevel

; Select any power-up.
; Usage: Press Up+Select to cycle through power-ups.
.DEFINE dbg_SelectPowerUp

; [CUSTOM] Select any item in the item box.
; Usage: Press Down+Select to cycle through items.
; .DEFINE dbg_SelectItemBox

; Free movement through anything.
; Usage: Press L+A to toggle free movement, d-pad to control, X/Y to speed up.
.DEFINE dbg_FreeMovement

; Select any Yoshi.
; Usage: Press Select on the overworld to cycle through Yoshi colors.
.DEFINE dbg_SelectYoshi

; Warp to Star Road.
; Usage: Press Select while on "YOSHI'S HOUSE" to warp to Star Road.
.DEFINE dbg_StarRoadWarp

; Walk freely on the overworld.
; Usage: Use the d-pad to move freely on the overworld.
.DEFINE dbg_FreeOverworld

.ENDIF
