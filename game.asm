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
    lda #$00
    sta $d010
    lda #$01
    sta $d015
    lda #$80
    sta $d000
    sta $d001
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

loop:

    debug_address("GAME.loop:")

    jsr RANDOM.getRandomNumber

    jsr INPUT.read

    lda inputKey
    cmp #$20
    beq exit
    
    cmp #$01
    beq inc_score
    
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
    bne draw

draw:

    cmp #GAME_STATE_DRAW
    bne effect

effect:

    cmp #GAME_STATE_EFFECT
    bne loop


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

    jmp loop


TITLE: .text "game@"

}
