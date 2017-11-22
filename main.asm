/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    main.asm

    controls the state of the game


*/
#importonce

#import "include.asm"
#import "vars.asm"
#import "lib/vic2.lib"
#import "lib/raster.lib"
#import "lib/common.lib"
#import "lib/keyboard.lib"
#import "lib/sprites.lib"

MAIN: {

start:

    jsr clear
    change_game_state(STATE_INTRO)

loop:

    debug_address("MAIN.loop:")

    wait_raster()
    jsr clear
    
    lda gameState

!:  cmp #STATE_INTRO
    bne !+
    jmp INTRO.start

!:  cmp #STATE_TITLE
    bne !+
    jmp TITLE.start

!:  cmp #STATE_HELP
    bne !+
    jmp HELP.start

!:  cmp #STATE_HISCORE
    bne !+
    jmp HISCORE.start

!:  cmp #STATE_GAME
    bne !+
    jmp GAME.start

!:  cmp #STATE_QUIT
    bne !+
    jmp exit

!:  jmp MAIN.loop

exit:

    rts

    clear: {

        lda #COLOR_BLACK
        sta VIC2_EXTCOL
        sta VIC2_BGCOL0

        clear_screen(32, 0)
        clear_color(0)

        reset_sprites()
        
        rts
    }

}
