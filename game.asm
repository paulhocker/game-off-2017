/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    game.asm

    game screen
*/
#importonce

//#import "include.asm"
//#import "input.asm"
//#import "vars.asm" 
//#import "random.asm"
//#import "level.asm"
//#import "data.asm"
#import "lib/vic2.lib"
#import "lib/raster.lib"
#import "lib/common.lib"
#import "lib/sprites.lib"
#import "lib/random.lib"
#import "lib/input.lib"


/*
    location of the screen and
    screen buffer
*/

.label GAME_SCREEN = $8000
.label GAME_BUFFER = $8800

GAME: {

init:

    debug_address("GAME.init:")

    lda #<MEM_MAP_01
    sta parm1
    lda #>MEM_MAP_01
    sta parm1 + 1
    lda #<GAME_SCREEN
    sta parm2 
    lda #>GAME_SCREEN
    sta parm2 + 1
    

    debug_address("clear_color: ")
    clear_screen(32, 0)
    clear_color(12)
    print_text(TITLE, $8000+(40*22), "@")

    jsr LEVEL.load

start:

    lda #MAX_GAME_STATE
    sta gameState

    debug_address("GAME.start:")

    set_input(INPUT_KEYBOARD)

    lda #COLOR_BLACK
    sta VIC2_EXTCOL
    sta VIC2_BGCOL0


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

chk_input:

    cmp #GAME_STATE_INPUT
    beq input
    jmp chk_logic

input:

    jmp next

chk_logic:

    cmp #GAME_STATE_LOGIC
    beq logic
    jmp chk_move

logic:

    jmp next

chk_move:

    cmp #GAME_STATE_MOVE
    beq move
    jmp chk_draw

move:

    jmp next

chk_draw:

    cmp #GAME_STATE_DRAW
    beq draw
    jmp chk_effect

draw:

    jmp next
  
chk_effect:

    cmp #GAME_STATE_EFFECT
    beq effect
    jmp next

effect:

    jmp next

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

