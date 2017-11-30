#importonce

#import "game.lib"
#import "../vars.asm"

GAME_MOVE: {

    debug_address("GAME_MOVE.start:")

start:

    jsr movePlayer
    //jsr moveEnemy


exit:

    rts
}

movePlayer: {

    //  if we are still moving, continue

    lda v_actors.isMoving + ACTOR_PLAYER
    cmp #$00
    bne continueMoving

    //  if next move is nothing, then exit

    lda nextMove
    cmp #$00
    bne !+ 

    jmp stopMoving

!:  
    jsr checkDirection

continueMoving:

    lda v_actors.dir + ACTOR_PLAYER

    cmp #GAME_MOVE_LEFT
    bne !+
    //dec playerX
    move_sprite_left(v_actors.x + ACTOR_PLAYER, v_actors.speed + ACTOR_PLAYER)
    jmp check_pos
!:
    cmp #GAME_MOVE_RIGHT
    bne !+
    //inc playerX
    move_sprite_right(v_actors.x + ACTOR_PLAYER, v_actors.speed + ACTOR_PLAYER)
    jmp check_pos
!:
    cmp #GAME_MOVE_UP
    bne !+
    //dec playerY
    move_sprite_up(v_actors.y + ACTOR_PLAYER, v_actors.speed + ACTOR_PLAYER)
    jmp check_pos
!:
    cmp #GAME_MOVE_DOWN
    bne check_pos
    //inc playerY
    move_sprite_down(v_actors.y + ACTOR_PLAYER, v_actors.speed + ACTOR_PLAYER)

/*
    check the position to see if x/y has
    been reached

    playerMoving    will be set to #$00 when x/y is reached

*/
check_pos: 

chk_x:

    lda v_actors.x + ACTOR_PLAYER
    cmp v_actors.nextX + ACTOR_PLAYER
    bne exit

chk_y:

    lda v_actors.y + ACTOR_PLAYER
    cmp v_actors.nextY + ACTOR_PLAYER
    bne exit

stopMoving:

    lda #GAME_MOVE_STOP
    sta v_actors.dir + ACTOR_PLAYER

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

//  check direction of next move

checkDirection: {

    //  'and' the next movement requested
    //  with the tile index, if anything
    //  but zero returns, we can move in
    //  that direction

    lda v_actors.tile + ACTOR_PLAYER
    and nextMove
    bne exit

    //  store last tile

    lda v_actors.tile + ACTOR_PLAYER
    sta v_actors.lastTile + ACTOR_PLAYER

    //  clear out current tile
    lda #$00
    sta v_actors.tile + ACTOR_PLAYER

    //  store the new direction for the player

    lda nextMove
    sta v_actors.dir + ACTOR_PLAYER

    //  change tile based on next move

    cmp #$01
    bne !+
    dec v_actors.tileY + ACTOR_PLAYER

!:
    cmp #$02
    bne !+
    inc v_actors.tileY + ACTOR_PLAYER

!:

    cmp #$04
    bne !+
    dec v_actors.tileX + ACTOR_PLAYER

!:

    cmp #$08
    bne !+
    inc v_actors.tileX + ACTOR_PLAYER

!:

    //  get the new tile info

    lda v_actors.tileX + ACTOR_PLAYER
    sta parm1
    lda v_actors.tileY + ACTOR_PLAYER
    sta parm2
    jsr GAME.getTile
    lda rtrn1
    sta v_actors.nextTile + ACTOR_PLAYER

    //  get world pos of next tile

    jsr GAME.getTileWorldPos
    lda rtrn1
    sta v_actors.nextX + ACTOR_PLAYER
    lda rtrn2
    sta v_actors.nextY + ACTOR_PLAYER

    //  flag that player state is moving

    lda #$01
    sta v_actors.isMoving + ACTOR_PLAYER

    //  clear out the next move queue

    lda #$00
    sta nextMove

exit:

    rts 
}