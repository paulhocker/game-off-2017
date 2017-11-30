
#import "../lib/vic2.lib"

BasicUpstart2(BS) 

* = $0810   "BOOTSTRAP"

BS:{
    lda #%11111111
    sta VIC2_SPENA
    lda #$00
    sta $d010
    .for (var i = 0; i < 8; i++) {
        
        lda #$30
        sta $d000 + (i*2)
        lda #$30 + (i*24)
        sta $d001 + (i*2)
        lda #$c0 + i
        sta $0400 + $03f8
    }

move:

    //jmp draw

!wait:
  
    .var line_number = 0
    lda #line_number
    cmp $d012
    bne !wait-
    bit $d011
    
    .if (line_number <= 255) {
        bmi !wait-
    } else {
        bpl !wait-
    }

draw:

    .for(var i = 0; i < 8; i++) {
        .for (var j = 0; j < i + 1; j++) {
            inc $d000 + (i*2)
        }
    }
  
  jmp move

}

* = $3000
.import binary "../sprites/sprites.bin"
    