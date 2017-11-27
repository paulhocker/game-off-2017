#importonce

#import "game.lib"
#import "../vars.asm"

GAME_MOVE: {

    debug_address("GAME_MOVE.start:")

start:

    jsr movePlayer
    jsr moveEnemy


exit:

    rts
}

movePlayer: {

    lda moveDirection

    cmp #GAME_MOVE_LEFT
    bne !+
    dec playerX
    jmp check_pos
!:
    cmp #GAME_MOVE_RIGHT
    bne !+
    inc playerX
    jmp check_pos
!:
    cmp #GAME_MOVE_UP
    bne !+
    dec playerY
    jmp check_pos
!:
    cmp #GAME_MOVE_DOWN
    bne check_pos
    inc playerY

/*
    check the position to see if x/y has
    been reached

    playerMoving    will be set to #$00 when x/y is reached

*/
check_pos: 

chk_x:

    lda playerX
    cmp nextX
    bne exit

chk_y:

    lda playerY
    cmp nextY
    bne exit

    lda #$00
    sta playerMoving

    lda #GAME_MOVE_STOP
    sta moveDirection


exit:

    rts


}

moveEnemy: {

    inc enemy1X

    inc enemy2X

    inc enemy3X

    inc enemy4X

    rts


}