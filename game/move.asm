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

    movePlayer: {

        //  if we are still moving, continue

        lda v_actors.isMoving + ACTOR_PLAYER
        cmp #$00
        bne continueMoving

        //  if next move is nothing, then exit

        lda nextMove
        cmp #$00
        bne !+ 

        jmp exit

    !:  
        lda nextMove
        sta parm1
        lda v_actors.tile + ACTOR_PLAYER
        sta parm2
        jsr checkDirection
        bne !+
        jmp exit

    !:

        lda nextMove
        sta parm1
        jsr setNextTile
        lda #$00
        sta nextMove

    continueMoving:

        lda v_actors.dir + ACTOR_PLAYER

        cmp #GAME_MOVE_LEFT
        bne !+
        move_sprite_left(v_actors.x + ACTOR_PLAYER, v_actors.speed + ACTOR_PLAYER)
        jmp checkPosition

    !:
        cmp #GAME_MOVE_RIGHT
        bne !+
        move_sprite_right(v_actors.x + ACTOR_PLAYER, v_actors.speed + ACTOR_PLAYER)
        jmp checkPosition

    !:
        cmp #GAME_MOVE_UP
        bne !+
        move_sprite_up(v_actors.y + ACTOR_PLAYER, v_actors.speed + ACTOR_PLAYER)
        jmp checkPosition

    !:
        cmp #GAME_MOVE_DOWN
        bne exit
        move_sprite_down(v_actors.y + ACTOR_PLAYER, v_actors.speed + ACTOR_PLAYER)

    /*
        check the position to see if x/y has
        been reached

        playerMoving    will be set to #$00 when x/y is reached

    */
    debug_address("GAME_MOVE.checkPosition:")

    checkPosition: 

    checkPositionX:

        lda v_actors.x + ACTOR_PLAYER
        cmp v_actors.nextX + ACTOR_PLAYER
        bne exit

    checkPositionY:

        lda v_actors.y + ACTOR_PLAYER
        cmp v_actors.nextY + ACTOR_PLAYER
        bne exit

        lda v_actors.tile + ACTOR_PLAYER
        sta v_actors.lastTile + ACTOR_PLAYER
        lda v_actors.nextTile + ACTOR_PLAYER
        sta v_actors.tile + ACTOR_PLAYER
        lda #$00
        sta v_actors.nextTile + ACTOR_PLAYER

        //  if we have a next move use it

        lda nextMove
        beq !+
        sta parm1
        lda v_actors.tile + ACTOR_PLAYER
        sta parm2
        jsr checkDirection
        beq !+
        jsr stopMoving
        jmp exit

    !:

        lda v_actors.dir
        sta parm1
        lda v_actors.tile + ACTOR_PLAYER
        sta parm2
        jsr checkDirection
        bne !+
        jsr stopMoving
        jmp exit

    !:

        lda v_actors.dir
        sta parm1
        jsr setNextTile
        lda #$00

    exit:

        rts
    }

    stopMoving: {

        lda #GAME_MOVE_STOP
        sta v_actors.dir + ACTOR_PLAYER
        lda #$00
        sta v_actors.isMoving + ACTOR_PLAYER
        rts
    }


    /*
        set the next tile to move to for an actor

        parm1   dir of move
        parm2   actor
    */
    setNextTile: { 
        
        debug_address("GAME_MOVE.setNextTile:")

        //  store last tile

        lda v_actors.tile + ACTOR_PLAYER
        sta v_actors.lastTile + ACTOR_PLAYER

        //  clear out current tile
        lda #$00
        sta v_actors.tile + ACTOR_PLAYER

        //  store the new direction for the player

        lda parm1  
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

    exit:

        rts 
    }

    /*
        check if the direction requested is open

        parm1   direction
        parm2   tile

        rtrn1   1 if open 0 otherwise

    */
    checkDirection: {

        lda parm1
        beq closed
        and parm2
        beq open

    closed:

        lda #$00
        sta rtrn1
        jmp exit

    open:

        lda #$01
        sta rtrn1

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

}