/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    game.asm

    game screen
*/
#importonce

#import "include.asm"
#import "input.asm"
#import "vars.asm" 
#import "random.asm"
#import "lib/vic2.lib"
#import "lib/raster.lib"
#import "lib/common.lib"
#import "lib/sprites.lib"
#import "lib/random.lib"


/*
    location of the screen and
    screen buffer
*/

.label GAME_SCREEN = $9800
.label GAME_BUFFER = $9c00

GAME: {

start:

    lda #MAX_GAME_STATE
    sta gameState

    debug_address("GAME.start:")

    set_input(INPUT_KEYBOARD)

    lda #COLOR_BLACK
    sta VIC2_EXTCOL
    sta VIC2_BGCOL0

    clear_screen(32, 0)
    clear_color(1)
    print_text(TITLE, $8000+(40*22), "@")

    //  show a sprite
    lda #%11111111
    sta VIC2_SPENA
    lda #$00
    sta $d010
    .for (var i = 0; i < 4; i++) {
        
        lda #$30
        sta $d000 + (i*2)
        lda #$30 + (i*36)
        sta $d001 + (i*2)
    }
    lda #$ff
    sta $d01c
    lda #$01
    sta $d027
    lda #COLOR_PURPLE
    sta $d026
    lda #COLOR_GREEN
    sta $d025

    lda #$c3
    sta $83f8
    lda #$c4
    sta $83f9
    lda #$c5
    sta $83fa
    lda #$c6
    sta $83fb
    lda #$c7
    sta $83fc
    lda #$c2
    sta $83fd
    lda #$c2
    sta $83fe
    lda #$c2
    sta $83ff


loop:

    debug_address("GAME.loop:")

    jsr INPUT.read
 
    lda inputKey
    cmp #$20
    bne !+

    jmp exit
    
!:  cmp #$01
    bne next_state
    jsr inc_score

next_state:

    dec gameState
    bne state

    lda #MAX_GAME_STATE
    sta gameState

state:

    lda gameState

input:

    cmp #GAME_STATE_INPUT
    bne logic

logic:

    cmp #GAME_STATE_LOGIC
    bne move

move:

    cmp #GAME_STATE_MOVE
    bne chk_draw

chk_draw:

    cmp #GAME_STATE_DRAW
    beq draw
    jmp effect

draw:

  
effect:

    cmp #GAME_STATE_EFFECT
    bne next

next:

    jmp loop

exit:

    change_system_state(SYS_STATE_TITLE)
    lda #$00
    sta inputKey

    jmp MAIN.loop

inc_score:

    sed
    lda score 
    clc
    adc #$50
    sta score
    lda score + 1
    adc #$02
    sta score + 1
    lda score + 2
    adc #$00
    sta score + 2
    cld
    rts


TITLE: .text "game@"

}

