#import "lib/raster.lib"
#import "lib/vic2.lib"

//  LABELS

//  VARS

.var rasterPos1 = 0
.var rasterPos2 = 220
.var rasterPos3 = 250

//  GAME INIT

InitGame: {

    initRasterInterrupt(rasterPos1, Raster1)

loop:

    rts
}

//  main game interrupt
Raster1: {

    //cld
    startInterrupt()

    setInterruptVector(rasterPos2, Raster2)

    lda #$00
    sta VIC_EXTCOL
    sta VIC_BGCOL0

    lda #$18
    sta $d016
    lda #$10
    sta VIC_BGCOL1
    lda #$11
    sta VIC_BGCOL2

    endInterrupt()
}

//  lower panel interrupt
Raster2: {

    //cld
    startInterrupt()

    setInterruptVector(rasterPos3, Raster3)

    lda #$08
    sta $d016
    inc VIC_EXTCOL
    //inc VIC_BGCOL0

    endInterrupt() 
}

//  misc interrupt
Raster3: {

    //cld
    startInterrupt()

    setInterruptVector(rasterPos1, Raster1)

    inc VIC_EXTCOL
    //inc VIC_BGCOL0

    endInterrupt()
}

//  STORAGE

