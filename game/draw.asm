#importonce
#import "../vars.asm"

GAME_DRAW: {

    debug_address("GAME_DRAW.start:")

start:

    raster_wait(225)

    lda playerX
    sta $d000
    lda playerY
    sta $d001

    lda enemy1X
    sta $d002

    lda enemy2X
    sta $d004
    
    lda enemy3X
    sta $d006
    
    lda enemy4X
    sta $d008
    
exit:

    rts

}