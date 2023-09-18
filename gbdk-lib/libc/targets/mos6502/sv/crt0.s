;
; crt0.s for Supervision
;
; Provides:
;  * 
.module crt0
.include    "global.s"

; OAM CPU page
_shadow_OAM             = 0x200

       ;; ****************************************

        ;; Ordering of segments for the linker
        ;; Code that really needs to be in the fixed bank
        .area _CODE
        .area _HOME
        ;; Similar to _HOME
        .area _BASE
        ;; Constant data
        .area _LIT
        ;; Constant data, used to init _DATA
        .area _INITIALIZER
        .area _XINIT
        ;; Code, used to init _DATA
        .area _GSINIT 
        .area _GSFINAL
        ;; Uninitialised ram data
        .area _DATA
        .area _BSS
        ;; Initialised in ram data
        .area _INITIALIZED
        ;; For malloc
        .area _HEAP
        .area _HEAP_END

.area	OSEG    (PAG, OVR)
.area _ZP (PAG)
_shadow_BANK::                       .ds 1
_generic_ptr::                       .ds 2
_waiting_nmi::                       .ds 1

.area _CODE

__crt0_RESET:
        ldx #0xFF
        txs
        cld
        lda #0xa0
        sta XSIZE
        sta YSIZE
        lda #0x00
        sta XPOS
        sta YPOS
        sta _waiting_nmi
        lda #0xdf
        sta BANK
        jsr ClearVram
        jsr _main
    ; main finished - loop forever
1$:
        jmp 1$


ClearVram:
        pha
        PHX
        PHY
        STZ_B _generic_ptr
        lda #0x40
        sta (_generic_ptr+1)
        ldx #0x20
        ldy #0x00
        lda #0x00
1$:
        sta [_generic_ptr], y
        iny
        bne 1$

        inc (_generic_ptr+1)
        dex
        bne 1$

        PLY
        PLX
        pla
        rts


__crt0_NMI:
        PHP
        STZ_B _waiting_nmi
        PLP
        cli
        rti


__crt0_IRQ:
        pha
        PHP
        lda TIMER_ACK
        lda SNDDMA_ACK
        PLP
        pla
        cli
        rti


_vsync::
        lda #0x01
        sta _waiting_nmi
1$:
        lda _waiting_nmi
        bne 1$
        rts


; Interrupt / RESET vector table
.area VECTORS (ABS)
.org 0xfffa
.dw	__crt0_NMI
.dw	__crt0_RESET
.dw	__crt0_IRQ
