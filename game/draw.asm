#importonce

#import "../vars.asm"
#import "../lib/common.lib"
#import "../lib/vic2.lib"
#import "../lib/sprites.lib"


GAME_DRAW: {

    debug_address("GAME_DRAW.start:") 

start:

    raster_wait(225)

    .for (var i = 0; i < 5; i++) {

        lda v_actors.x + i 
        sta VIC2_SP0X + i * 2
        lda v_actors.y + i 
        sta VIC2_SP0Y + i * 2
    }

    lda spriteMsb
    sta VIC2_MSGIX

exit:

    rts

}