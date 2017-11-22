# game-off-2017
My entry for the 2017 #githubgameoff on itch.io

This Game will be a "modest" C64 recreation of the Apple 2e classic "Microwave". 

This was one of my favorite Games in the "Computer Club" when I was
in School, and I have very fond memories of it. It always bugged me
that there was never a version for the Commodore 64.

I do not want this to be a carbon copy of the game, rather I would
like it to be in the "spirit" of the game, and maybe adds some
things to it that might make it more visually pleasing, and 
perhaps add some more game elements to increase the playability
of it.

My Goals for this Game are:

    - as close as possible game play as the original
    - close representation of graphics and sprites (c64 has better graphics imho)
    - original three levels
    - some cool music (I might need to outsource this one)
    - written in Kick Assembler [http://www.theweb.dk/KickAssembler/Main.html#frontpage]
    - runs on Vice


Some Seconday Goals:

    - more levels (the original had three levels)
    - packaging of Vice and the Game for "non emulator" folks
    - distribution on ich.io

Naming Conventions:

In most cases Kick Ass Scripting follows the JavaScript naming conventions

.label      UpperCamelCase                      eg.     .label Main = $0000 or Label: {}
.var        lowerCamelCase                              .var playerScore = 0
.macro      lower_case_with_underscore                  .macro clear_screen()
.function   lowerCamelCase                              .function clearScreen()
.pseudo     UPPERCASE_WITH_UNDERSCORE                   .pseudo LDA_X
.namespace  UpperCamelCase                              .namespace ActorData {}

Variables

    Assembler

    variableName:   .byte 0
    variableName:   .text "hello world"

    Script

    .var variableName = $d000


