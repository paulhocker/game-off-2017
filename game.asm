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
    rts
}

//  main game interrupt
Raster1: {

    cld

    setInterruptVector(rasterPos2, Raster2)

    lda #$00
    sta VIC_EXTCOL
    sta VIC_BGCOL0

    jmp $ea81
}

//  lower panel interrupt
Raster2: {

    cld

    setInterruptVector(rasterPos3, Raster3)

    inc VIC_EXTCOL
    inc VIC_BGCOL0

    jmp $ea81
}

//  misc interrupt
Raster3: {

    cld

    setInterruptVector(rasterPos1, Raster1)

    inc VIC_EXTCOL
    inc VIC_BGCOL0

    jmp $ea81
}

//  STORAGE

