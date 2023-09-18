    .module SetData
    .include "global.s"

    .area	OSEG (PAG, OVR)
    _set_sprite_data_PARM_3::   .ds 2
    src:                        .ds 2
    dest:                       .ds 2
    tilesLeft:                  .ds 1
    loBitplane:                 .ds 1
    hiBitplane:                 .ds 1
    pxRowsLeft:                 .ds 1
    tmpByte:                    .ds 1

    _display_sprite_PARM_3::    .ds 1
    _display_sprite_PARM_4::    .ds 1
    tileShift:                  .ds 1
    tileShiftTmp:               .ds 1
    tileBuf:                    .ds 1
    tileBuf2:                   .ds 1


    .area _BSS
    tile_data:                  .ds 0x100


    .area _CODE


VramDestsLo:
	.db <0x4000
	.db <0x4030
	.db <0x4060
	.db <0x4090
	.db <0x40c0
	.db <0x40f0
	.db <0x4120
	.db <0x4150
	.db <0x4180
	.db <0x41b0
	.db <0x41e0
	.db <0x4210
	.db <0x4240
	.db <0x4270
	.db <0x42a0
	.db <0x42d0
	.db <0x4300
	.db <0x4330
	.db <0x4360
	.db <0x4390
	.db <0x43c0
	.db <0x43f0
	.db <0x4420
	.db <0x4450
	.db <0x4480
	.db <0x44b0
	.db <0x44e0
	.db <0x4510
	.db <0x4540
	.db <0x4570
	.db <0x45a0
	.db <0x45d0
	.db <0x4600
	.db <0x4630
	.db <0x4660
	.db <0x4690
	.db <0x46c0
	.db <0x46f0
	.db <0x4720
	.db <0x4750
	.db <0x4780
	.db <0x47b0
	.db <0x47e0
	.db <0x4810
	.db <0x4840
	.db <0x4870
	.db <0x48a0
	.db <0x48d0
	.db <0x4900
	.db <0x4930
	.db <0x4960
	.db <0x4990
	.db <0x49c0
	.db <0x49f0
	.db <0x4a20
	.db <0x4a50
	.db <0x4a80
	.db <0x4ab0
	.db <0x4ae0
	.db <0x4b10
	.db <0x4b40
	.db <0x4b70
	.db <0x4ba0
	.db <0x4bd0
	.db <0x4c00
	.db <0x4c30
	.db <0x4c60
	.db <0x4c90
	.db <0x4cc0
	.db <0x4cf0
	.db <0x4d20
	.db <0x4d50
	.db <0x4d80
	.db <0x4db0
	.db <0x4de0
	.db <0x4e10
	.db <0x4e40
	.db <0x4e70
	.db <0x4ea0
	.db <0x4ed0
	.db <0x4f00
	.db <0x4f30
	.db <0x4f60
	.db <0x4f90
	.db <0x4fc0
	.db <0x4ff0
	.db <0x5020
	.db <0x5050
	.db <0x5080
	.db <0x50b0
	.db <0x50e0
	.db <0x5110
	.db <0x5140
	.db <0x5170
	.db <0x51a0
	.db <0x51d0
	.db <0x5200
	.db <0x5230
	.db <0x5260
	.db <0x5290
	.db <0x52c0
	.db <0x52f0
	.db <0x5320
	.db <0x5350
	.db <0x5380
	.db <0x53b0
	.db <0x53e0
	.db <0x5410
	.db <0x5440
	.db <0x5470
	.db <0x54a0
	.db <0x54d0
	.db <0x5500
	.db <0x5530
	.db <0x5560
	.db <0x5590
	.db <0x55c0
	.db <0x55f0
	.db <0x5620
	.db <0x5650
	.db <0x5680
	.db <0x56b0
	.db <0x56e0
	.db <0x5710
	.db <0x5740
	.db <0x5770
	.db <0x57a0
	.db <0x57d0
	.db <0x5800
	.db <0x5830
	.db <0x5860
	.db <0x5890
	.db <0x58c0
	.db <0x58f0
	.db <0x5920
	.db <0x5950
	.db <0x5980
	.db <0x59b0
	.db <0x59e0
	.db <0x5a10
	.db <0x5a40
	.db <0x5a70
	.db <0x5aa0
	.db <0x5ad0
	.db <0x5b00
	.db <0x5b30
	.db <0x5b60
	.db <0x5b90
	.db <0x5bc0
	.db <0x5bf0
	.db <0x5c20
	.db <0x5c50
	.db <0x5c80
	.db <0x5cb0
	.db <0x5ce0
	.db <0x5d10
	.db <0x5d40
	.db <0x5d70
	.db <0x5da0
	.db <0x5dd0
	.db <0x5e00
	.db <0x5e30
	.db <0x5e60
	.db <0x5e90
	.db <0x5ec0
	.db <0x5ef0
	.db <0x5f20
	.db <0x5f50
	.db <0x5f80
	.db <0x5fb0


VramDestsHi:
	.db >0x4000
	.db >0x4030
	.db >0x4060
	.db >0x4090
	.db >0x40c0
	.db >0x40f0
	.db >0x4120
	.db >0x4150
	.db >0x4180
	.db >0x41b0
	.db >0x41e0
	.db >0x4210
	.db >0x4240
	.db >0x4270
	.db >0x42a0
	.db >0x42d0
	.db >0x4300
	.db >0x4330
	.db >0x4360
	.db >0x4390
	.db >0x43c0
	.db >0x43f0
	.db >0x4420
	.db >0x4450
	.db >0x4480
	.db >0x44b0
	.db >0x44e0
	.db >0x4510
	.db >0x4540
	.db >0x4570
	.db >0x45a0
	.db >0x45d0
	.db >0x4600
	.db >0x4630
	.db >0x4660
	.db >0x4690
	.db >0x46c0
	.db >0x46f0
	.db >0x4720
	.db >0x4750
	.db >0x4780
	.db >0x47b0
	.db >0x47e0
	.db >0x4810
	.db >0x4840
	.db >0x4870
	.db >0x48a0
	.db >0x48d0
	.db >0x4900
	.db >0x4930
	.db >0x4960
	.db >0x4990
	.db >0x49c0
	.db >0x49f0
	.db >0x4a20
	.db >0x4a50
	.db >0x4a80
	.db >0x4ab0
	.db >0x4ae0
	.db >0x4b10
	.db >0x4b40
	.db >0x4b70
	.db >0x4ba0
	.db >0x4bd0
	.db >0x4c00
	.db >0x4c30
	.db >0x4c60
	.db >0x4c90
	.db >0x4cc0
	.db >0x4cf0
	.db >0x4d20
	.db >0x4d50
	.db >0x4d80
	.db >0x4db0
	.db >0x4de0
	.db >0x4e10
	.db >0x4e40
	.db >0x4e70
	.db >0x4ea0
	.db >0x4ed0
	.db >0x4f00
	.db >0x4f30
	.db >0x4f60
	.db >0x4f90
	.db >0x4fc0
	.db >0x4ff0
	.db >0x5020
	.db >0x5050
	.db >0x5080
	.db >0x50b0
	.db >0x50e0
	.db >0x5110
	.db >0x5140
	.db >0x5170
	.db >0x51a0
	.db >0x51d0
	.db >0x5200
	.db >0x5230
	.db >0x5260
	.db >0x5290
	.db >0x52c0
	.db >0x52f0
	.db >0x5320
	.db >0x5350
	.db >0x5380
	.db >0x53b0
	.db >0x53e0
	.db >0x5410
	.db >0x5440
	.db >0x5470
	.db >0x54a0
	.db >0x54d0
	.db >0x5500
	.db >0x5530
	.db >0x5560
	.db >0x5590
	.db >0x55c0
	.db >0x55f0
	.db >0x5620
	.db >0x5650
	.db >0x5680
	.db >0x56b0
	.db >0x56e0
	.db >0x5710
	.db >0x5740
	.db >0x5770
	.db >0x57a0
	.db >0x57d0
	.db >0x5800
	.db >0x5830
	.db >0x5860
	.db >0x5890
	.db >0x58c0
	.db >0x58f0
	.db >0x5920
	.db >0x5950
	.db >0x5980
	.db >0x59b0
	.db >0x59e0
	.db >0x5a10
	.db >0x5a40
	.db >0x5a70
	.db >0x5aa0
	.db >0x5ad0
	.db >0x5b00
	.db >0x5b30
	.db >0x5b60
	.db >0x5b90
	.db >0x5bc0
	.db >0x5bf0
	.db >0x5c20
	.db >0x5c50
	.db >0x5c80
	.db >0x5cb0
	.db >0x5ce0
	.db >0x5d10
	.db >0x5d40
	.db >0x5d70
	.db >0x5da0
	.db >0x5dd0
	.db >0x5e00
	.db >0x5e30
	.db >0x5e60
	.db >0x5e90
	.db >0x5ec0
	.db >0x5ef0
	.db >0x5f20
	.db >0x5f50
	.db >0x5f80
	.db >0x5fb0


; A - sprite tile idx
; X - sprite X
; _display_sprite_PARM_3 - sprite Y
; _display_sprite_PARM_4 - should display
_display_sprite::
; src is tile idx indexed into tile_data's set of 16 bytes
    asl
    asl
    asl
    asl
    clc
    adc #<tile_data
    sta src
    lda #0
    adc #>tile_data
    sta src+1

; tile X = pixel X / 4
    txa
    sta tileShift
    lsr
    lsr
    pha

; dest is based on pixel Y
    ldx _display_sprite_PARM_3
    lda VramDestsLo, x
    sta dest
    lda VramDestsHi, x
    sta dest+1
    PLX

; 'should display' reused as a draw mask
    lda _display_sprite_PARM_4
    beq 1$
    lda #0xff
    sta _display_sprite_PARM_4
1$:

; set loop count
    lda #8
    sta pxRowsLeft

; decide how to display based on low 2 bits of X
    lda tileShift
    and #3
    sta tileShift
    beq __display_sprite_nextPxRowNoShifts

__display_sprite_nextPxRowWithShifts:
; Y = tile X
    txa
    tay

    lda #0
    sta tileBuf
    sta tileBuf2

    lda tileShift
    sta tileShiftTmp

    LDA_IND src

__display_sprite_nextShift1:
    asl a
    rol tileBuf
    asl a
    rol tileBuf
    dec tileShiftTmp
    bne __display_sprite_nextShift1

    and _display_sprite_PARM_4
    sta [dest], y
    iny

    inc src
    bne 1$
    inc src+1
1$:

    lda tileShift
    sta tileShiftTmp

    LDA_IND src

__display_sprite_nextShift2:
    asl a
    rol tileBuf2
    asl a
    rol tileBuf2
    dec tileShiftTmp
    bne __display_sprite_nextShift2

    ora tileBuf
    and _display_sprite_PARM_4
    sta [dest], y
    iny

    lda tileBuf2
    and _display_sprite_PARM_4
    sta [dest], y

    lda dest
    clc
    adc #0x30
    sta dest
    lda dest+1
    adc #0
    sta dest+1

    inc src
    bne 1$
    inc src+1
1$:

    dec pxRowsLeft
    bne __display_sprite_nextPxRowWithShifts

    rts

__display_sprite_nextPxRowNoShifts:
; Y = tile X
    txa
    tay

    LDA_IND src
    and _display_sprite_PARM_4
    sta [dest], y
    iny

    inc src
    bne 1$
    inc src+1
1$:

    LDA_IND src
    and _display_sprite_PARM_4
    sta [dest], y

    lda dest
    clc
    adc #0x30
    sta dest
    lda dest+1
    adc #0
    sta dest+1

    inc src
    bne 2$
    inc src+1
2$:

    dec pxRowsLeft
    bne __display_sprite_nextPxRowNoShifts

    rts


; todo: only 16 tiles
; A - first tile idx
; X - num tiles (16 bytes each)
; _set_sprite_data_PARM_3 - ptr to src data
_set_sprite_data::
    stx tilesLeft

; X = tile data offset
; todo: unused
    asl
    asl
    asl
    asl
    tax

; set src
    lda _set_sprite_data_PARM_3
    sta src
    lda _set_sprite_data_PARM_3+1
    sta src+1

    lda #<tile_data
    sta dest
    lda #>tile_data
    sta dest+1

__set_sprite_data_nextTile:
    lda #8
    sta pxRowsLeft

__set_sprite_data_nextPxRow:
    LDA_IND src
    sta loBitplane
    inc src
    bne 1$
    inc src+1
1$:
    LDA_IND src
    sta hiBitplane
    inc src
    bne 2$
    inc src+1
2$:

    ldy #1
    jsr GetByteFromBitplanes

    ldy #0
    jsr GetByteFromBitplanes

    lda dest
    clc
    adc #2
    sta dest
    lda dest+1
    adc #0
    sta dest+1

    dec pxRowsLeft
    bne __set_sprite_data_nextPxRow

    dec tilesLeft
    bne __set_sprite_data_nextTile

.done:
    rts


; Y - 1 if left tile, 0 if right
GetByteFromBitplanes:
    lda #0
.rept 4
    lsr loBitplane
    php
    lsr hiBitplane
    rol a
    plp
    rol a
.endm
    sta [dest], y
    rts
