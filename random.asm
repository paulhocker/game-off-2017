/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    include.asm

    include file for all screens

*/
#importonce

#import "lib/random.lib"

RANDOM: {

getRandomNumber:

    generate_random_number(randseed)
    sta bRandom
    rts

randseed:   .byte $73

}