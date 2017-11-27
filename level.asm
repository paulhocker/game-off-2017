
#importonce 

#import "lib/common.lib"

LEVEL: {

load:

    debug_address("LEVEL.load:")

    //  map memory location
    lda parm1
    sta temp1
    lda parm1 + 1
    sta temp1 + 1

    //  screen memory
    lda parm2
    sta temp2
    lda parm2 + 1
    sta temp2 + 1

    //  screen memory 2
    lda temp2
    sta temp3
    lda temp2 + 1
    sta temp3 + 1
    clc 
    lda #$28
    adc temp3
    sta temp3

    //  color memory
    lda #<$d800
    sta temp4
    lda #>$d800
    sta temp4 + 1

    lda temp4
    sta temp5
    lda temp4 + 1
    sta temp5 + 1
    clc
    lda #$28
    adc temp5
    sta temp5

draw:

    lda #$00
    sta currX
    sta currY
    sta currTile
    sta offset

loop:

    ldy currTile

    //  grab tile number
    lda (temp1), y

    //  multiply by 4 (tile offset)
    sta parm1
    lda #$04
    sta parm2 
    jsr multiply

    //  grab tile location start, set screen mem offset
    ldx rtrn1
    ldy offset

    lda MEM_MAP_CHARSET_TILE, x
    sta (temp2), y
    lda MEM_MAP_CHARSET_TILE + 2, x
    sta (temp3), y
    lda #$04
    sta (temp4), y
    sta (temp5), y
    iny 
    lda MEM_MAP_CHARSET_TILE + 1, x
    sta (temp2), y
    lda MEM_MAP_CHARSET_TILE + 3, x
    sta (temp3), y
    lda #$04
    sta (temp4), y
    sta (temp5), y

    inc currX
    inc offset
    inc offset

    //  are we at the end of the row?
    lda currX
    cmp width
    bne next_tile

    //  yes, we are
    lda #$00
    sta currX
    sta offset

    //  drop down two rows
    clc
    lda temp2
    adc #$50
    sta temp2
    lda temp2 + 1
    adc #$00
    sta temp2 + 1

    clc
    lda temp3
    adc #$50
    sta temp3
    lda temp3 + 1
    adc #$00
    sta temp3 + 1
    
    clc
    lda temp4
    adc #$50
    sta temp4
    lda temp4 + 1
    adc #$00
    sta temp4 + 1
    
    clc
    lda temp5
    adc #$50
    sta temp5
    lda temp5 + 1
    adc #$00
    sta temp5 + 1
    

next_tile:

    inc currTile
    lda currTile
    cmp tiles
    beq exit

    jmp loop

exit:

    rts

width:      .byte 20    
height:     .byte 11
tileSize:   .byte 4
tiles:      .byte 220
currX:      .byte 0
currY:      .byte 0
currTile:   .byte 0
offset:     .byte 0

}

multiply: {

    lda #$00
    beq enterLoop

    doAdd:

    clc
    adc parm1

    loop:

    asl parm1

    enterLoop:

    lsr parm2
    bcs doAdd
    bne loop

    sta rtrn1

    rts
}