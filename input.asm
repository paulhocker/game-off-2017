/*
    copyright 2017 SpockerDotNet LLC
    released under MIT License.

    input.asm

    a generic module for handling input
    from the keyboard or joystick

    the player can use the joystick or play
    with the keyboard.adc

    the programmer can let the input
    system know by initializing it
    with the known input system

    there are two types of input that
    this routine will return

    first, movement input, usually used
    for a player in a game or some other
    type of system. typically this will
    return

    UP
    DOWN
    LEFT
    RIGHT
    FIRE

    additionally, the input system will return 
    a key value as well. it is important to note
    here tho that if the joystick is selected
    as input for the game that pressing a movement
    key will not overwrite the joystick command

    the valid keyboard return values are

    F1
    F2
    F3
    F4
    F5
    F6
    F7
    F8
    RUN STOP
    COMMODORE KEY


*/
#importonce

//#import "keyboard.asm"
//#import "vars.asm"
#import "lib/joystick.lib"
#import "lib/keyboard.lib"

INPUT: {

    debug_address("INPUT.read:")

read:

    //  reset the input return vars
    lda #$00
    sta inputMove
    sta inputKey

    lda inputMode
    cmp #INPUT_KEYBOARD
    beq readKeyboard
    cmp #INPUT_JOYSTICK_A
    beq readJoystickA
    cmp #INPUT_JOYSTICK_B
    beq readJoystickB
    jmp readKeyboard

/*
    when joystick is selected we will try to get a
    value from the designated joystick
*/

readJoystickA:

    joystick_read(JOY_PORT_A, inputMove)
    jmp readKeyboard

readJoystickB:

    joystick_read(JOY_PORT_B, inputMove)

/*
    still read the keyboard ignoring movement
    keys if joystick was selected
*/

readKeyboard:

    keyboard_read(inputKey)

    lda inputMove
    cmp #$00
    bne functionKeys

    lda inputKey
    cmp #$20
    bne !+
    lda #GAME_MOVE_FIRE
    sta inputMove
    jmp exit

!:
    cmp #$01
    bne !+
    lda #GAME_MOVE_LEFT
    sta inputMove
    jmp exit

!:
    lda inputKey
    cmp #$04
    bne !+
    lda #GAME_MOVE_RIGHT
    sta inputMove
    jmp exit

!:
    lda inputKey
    cmp #$13
    bne !+
    lda #GAME_MOVE_DOWN
    sta inputMove
    jmp exit

!:
    lda inputKey
    cmp #$17
    bne !+
    lda #GAME_MOVE_UP
    sta inputMove
    jmp exit

!:

functionKeys:


exit:

    rts

}




