#import "./64spec.asm"
#import "../lib/bits.lib"

sfspec: 

  init_spec()
  
    lda #$42
    assert_a_equal #$42

    lda get_low($d021)
    assert_a_equal #$21

    lda get_high($d021)
    assert_a_equal #$d0

  finish_spec()