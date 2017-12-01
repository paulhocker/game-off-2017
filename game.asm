/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    game.asm

    game screen
*/
#importonce

#import "lib/vic2.lib"
#import "lib/raster.lib"
#import "lib/common.lib"
#import "lib/sprites.lib"
#import "lib/random.lib"
#import "lib/input.lib"
#import "game/game.lib"


/*
    location of the screen and
    screen buffer
*/

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

    debug_address("GAME.start:")

    lda #$00
    sta gameState

    set_input(INPUT_JOYSTICK_A)

    lda #COLOR_BLACK
    sta VIC2_EXTCOL
    sta VIC2_BGCOL0


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

    //  turn all sprites on except last three

    lda #%00011111
    sta VIC2_SPENA

    //  reset the msb for all sprites

    lda #%00000000
    sta VIC2_MSGIX
    sta spriteMsb

    /*
    lda #$00
    sta $d010
    .for (var i = 0; i < 4; i++) {
        
        lda #$30
        sta $d000 + (i*2)
        lda #$30 + (i*36)
        sta $d001 + (i*2)
    }
    */

    //  initialize player

    lda #$00
    sta v_actors.x + ACTOR_PLAYER
    sta v_actors.x + 1 + ACTOR_PLAYER
    sta v_actors.y + ACTOR_PLAYER    
    sta v_actors.y + 1 + ACTOR_PLAYER    
    sta v_actors.speed + ACTOR_PLAYER    
    sta v_actors.speed + 1 + ACTOR_PLAYER    
    sta v_actors.tileX + ACTOR_PLAYER    
    sta v_actors.tileX + 1 + ACTOR_PLAYER    
    sta v_actors.tileY + ACTOR_PLAYER    
    sta v_actors.tileY + 1 + ACTOR_PLAYER    
    sta v_actors.dir + ACTOR_PLAYER
    sta v_actors.tile + ACTOR_PLAYER
    sta v_actors.color + ACTOR_PLAYER
    sta v_actors.sprite + ACTOR_PLAYER
    sta v_actors.isMoving + ACTOR_PLAYER
    sta v_actors.lastTile + ACTOR_PLAYER
    sta v_actors.nextTile + ACTOR_PLAYER

    //  player color and sprite

    lda #$01
    sta v_actors.color + ACTOR_PLAYER
    lda #$c3
    sta v_actors.sprite + ACTOR_PLAYER

    //  starting speed = 0.5 pixels/sec
    lda #$01
    sta v_actors.speed + ACTOR_PLAYER
    lda #$00
    sta v_actors.speed + ACTOR_PLAYER + 1

    //  get starting tile x/y pos
    //  TODO: get starting tile from map



    lda #$02
    sta parm1
    sta v_actors.tileX + ACTOR_PLAYER
    lda #$01
    sta parm2
    sta v_actors.tileY + ACTOR_PLAYER
    jsr getTile
    
    //  this is now the players current tile

    lda rtrn1
    sta v_actors.tile + ACTOR_PLAYER

    //  get the tile world pos

    jsr GAME.getTileWorldPos

    //  this is now the players starting x/y pos

    lda rtrn1
    sta v_actors.x + ACTOR_PLAYER
    lda rtrn2
    sta v_actors.y + ACTOR_PLAYER


loop:

    debug_address("GAME.loop:")

    inc gameState
    lda gameState
    cmp #MAX_GAME_STATE
    bne next_state

    lda #$00
    sta gameState

next_state: 

chk_input:

    lda gameState
    cmp #GAME_STATE_INPUT
    beq input
    jmp chk_logic

input:

    jsr GAME_INPUT.start

chk_logic:

    lda gameState
    cmp #GAME_STATE_LOGIC
    beq logic
    jmp chk_move

logic:

chk_move:

    lda gameState
    cmp #GAME_STATE_MOVE
    beq move
    jmp chk_draw

move:

    jsr GAME_MOVE.start

chk_draw:

    lda gameState
    cmp #GAME_STATE_DRAW
    beq draw
    jmp chk_effect

draw:

    jsr GAME_DRAW.start
  
chk_effect:

    lda gameState
    cmp #GAME_STATE_EFFECT
    beq effect
    jmp next

effect:

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


/*
    get the tile from an x,y position

    parm1   tile x pos
    parm2   tile y pos

    rtrn1   tile

    there is never more than 220 tiles in
    a map so we can save some cycles and 
    do some cheap multiplication here 
    to get our tile number

*/
getTile: {

    lda parm1
    sta temp1 
    lda parm2
    sta temp2

    ldx temp1
    ldy temp2 

    lda #$00

!:
    clc
    adc #$14
    dey
    bne !-

!:
    clc
    adc #$01
    dex
    bne !-

    tay

    lda MEM_MAP_01, y

    sta rtrn1

    rts
}

/*
    return world position from tile position

    parm1   tile x pos
    parm1   tile y pos

    rtrn1   sprite x pos
    rtrn2   sprite y pos

*/
getTileWorldPos: {

    lda parm1
    sta temp1 
    lda parm2 
    sta temp2

    ldx temp1
    ldy temp2 

    lda #$14

    //  x
!:
    clc
    adc #$10
    dex
    bne !-

    sta rtrn1
!:
    lda #$30
!:
    clc
    adc #$10
    dey
    bne !-

    sta rtrn2

    rts
}

}

#import "game/move.asm"
#import "game/draw.asm"
#import "game/input.asm"