
; Generated by CharPad 2. Assemble with 64TASS or similar.


; General constants:-

TRUE = 1
FALSE = 0
COLRMETH_GLOBAL = 0
COLRMETH_PERTILE = 1
COLRMETH_PERCHAR = 2


; Project constants:-

COLOURING_METHOD = COLRMETH_GLOBAL
CHAR_MULTICOLOUR_MODE = FALSE
COLR_SCREEN = 0
COLR_CHAR_DEF = 4
CHAR_COUNT = 64
TILE_COUNT = 16
TILE_WID = 2
TILE_HEI = 2
MAP_WID = 20
MAP_HEI = 11
MAP_WID_CHRS = 40
MAP_HEI_CHRS = 22
MAP_WID_PXLS = 320
MAP_HEI_PXLS = 176


; Data block size constants:-

SZ_CHARSET_DATA        = 512
SZ_CHARSET_ATTRIB_DATA = 64
SZ_TILESET_DATA        = 64
SZ_MAP_DATA            = 220


; Data block address constants (dummy values):-

ADDR_CHARSET_DATA        = $1000   ; nb. label = 'charset_data'        (block size = $200).
ADDR_CHARSET_ATTRIB_DATA = $2000   ; nb. label = 'charset_attrib_data' (block size = $40).
ADDR_TILESET_DATA        = $3000   ; nb. label = 'tileset_data'        (block size = $40).
ADDR_MAP_DATA            = $5000   ; nb. label = 'map_data'            (block size = $dc).



; * INSERT EXAMPLE PROGRAM HERE! * (Or just include this file in your project).



; CHAR SET DATA : 64 (8 byte) chars : total size is 512 ($200) bytes.

* = ADDR_CHARSET_DATA
charset_data

.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $ff,$00,$00,$00,$00,$00,$00,$00,$ff,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$ff,$00,$00,$00,$00,$00,$00,$00,$ff
.byte $ff,$00,$00,$00,$00,$00,$00,$00,$ff,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$ff,$00,$00,$00,$00,$00,$00,$00,$ff
.byte $80,$80,$80,$80,$80,$80,$80,$80,$00,$00,$00,$00,$00,$00,$00,$00
.byte $80,$80,$80,$80,$80,$80,$80,$80,$00,$00,$00,$00,$00,$00,$00,$00
.byte $ff,$80,$80,$80,$80,$80,$80,$80,$ff,$00,$00,$00,$00,$00,$00,$00
.byte $80,$80,$80,$80,$80,$80,$80,$80,$00,$00,$00,$00,$00,$00,$00,$00
.byte $80,$80,$80,$80,$80,$80,$80,$80,$00,$00,$00,$00,$00,$00,$00,$00
.byte $80,$80,$80,$80,$80,$80,$80,$ff,$00,$00,$00,$00,$00,$00,$00,$ff
.byte $ff,$80,$80,$80,$80,$80,$80,$80,$ff,$00,$00,$00,$00,$00,$00,$00
.byte $80,$80,$80,$80,$80,$80,$80,$ff,$00,$00,$00,$00,$00,$00,$00,$ff
.byte $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01
.byte $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01
.byte $ff,$00,$00,$00,$00,$00,$00,$00,$ff,$01,$01,$01,$01,$01,$01,$01
.byte $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01
.byte $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01
.byte $00,$00,$00,$00,$00,$00,$00,$ff,$01,$01,$01,$01,$01,$01,$01,$ff
.byte $ff,$00,$00,$00,$00,$00,$00,$00,$ff,$01,$01,$01,$01,$01,$01,$01
.byte $00,$00,$00,$00,$00,$00,$00,$ff,$01,$01,$01,$01,$01,$01,$01,$ff
.byte $80,$80,$80,$80,$80,$80,$80,$80,$01,$01,$01,$01,$01,$01,$01,$01
.byte $80,$80,$80,$80,$80,$80,$80,$80,$01,$01,$01,$01,$01,$01,$01,$01
.byte $ff,$80,$80,$80,$80,$80,$80,$80,$ff,$01,$01,$01,$01,$01,$01,$01
.byte $80,$80,$80,$80,$80,$80,$80,$80,$01,$01,$01,$01,$01,$01,$01,$01
.byte $80,$80,$80,$80,$80,$80,$80,$80,$01,$01,$01,$01,$01,$01,$01,$01
.byte $80,$80,$80,$80,$80,$80,$80,$ff,$01,$01,$01,$01,$01,$01,$01,$ff
.byte $ff,$80,$80,$80,$80,$80,$80,$80,$ff,$01,$01,$01,$01,$01,$01,$01
.byte $80,$80,$80,$80,$80,$80,$80,$ff,$01,$01,$01,$01,$01,$01,$01,$ff



; CHAR SET ATTRIBUTE DATA : 64 attributes : total size is 64 ($40) bytes.
; nb. Upper nybbles = Material, Lower nybbles = Colour.

* = ADDR_CHARSET_ATTRIB_DATA
charset_attrib_data

.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00



; TILE SET DATA : 16 (2x2) tiles : total size is 64 ($40) bytes.

* = ADDR_TILESET_DATA
tileset_data

.byte $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f
.byte $10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1a,$1b,$1c,$1d,$1e,$1f
.byte $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2a,$2b,$2c,$2d,$2e,$2f
.byte $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3a,$3b,$3c,$3d,$3e,$3f



; MAP DATA : 1 (20x11) map : total size is 220 ($dc) bytes.

* = ADDR_MAP_DATA
map_data

.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$05,$01,$01,$01,$03,$09,$05,$09,$05,$03
.byte $09,$05,$01,$03,$09,$00,$00,$00,$00,$00,$0c,$0e,$0c,$0c,$0f,$0c
.byte $0c,$0c,$0c,$0f,$0c,$0c,$0c,$07,$08,$00,$00,$00,$00,$00,$0c,$0f
.byte $0c,$06,$03,$02,$00,$00,$02,$03,$02,$0a,$0c,$0f,$0c,$00,$00,$00
.byte $00,$00,$06,$01,$02,$03,$01,$09,$0e,$0c,$07,$01,$03,$03,$00,$01
.byte $0a,$00,$00,$00,$00,$00,$07,$08,$05,$03,$0a,$04,$03,$00,$03,$08
.byte $05,$03,$0a,$04,$0b,$00,$00,$00,$00,$00,$05,$02,$00,$03,$03,$02
.byte $0b,$0c,$0d,$06,$02,$03,$01,$02,$09,$00,$00,$00,$00,$00,$0c,$0f
.byte $0c,$05,$01,$03,$01,$00,$00,$01,$03,$09,$0c,$0f,$0c,$00,$00,$00
.byte $00,$00,$0c,$07,$08,$0c,$0c,$0f,$0c,$0c,$0c,$0c,$0f,$0c,$0c,$0d
.byte $0c,$00,$00,$00,$00,$00,$06,$03,$02,$0a,$06,$03,$0a,$06,$0a,$06
.byte $03,$02,$02,$02,$0a,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00


