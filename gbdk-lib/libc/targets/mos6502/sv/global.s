        ;; Hardware registers
        XSIZE      = 0x2000
        YSIZE      = 0x2001
        XPOS       = 0x2002
        YPOS       = 0x2003
        JOYPAD     = 0x2020
        TIMER_ACK  = 0x2024
        SNDDMA_ACK = 0x2025
        BANK       = 0x2026

        ;; GBDK library screen modes

        .G_MODE         = 0x01  ; Graphic mode
        .T_MODE         = 0x02  ; Text mode (bit 2)
        .T_MODE_OUT     = 0x02  ; Text mode output only
        .T_MODE_INOUT   = 0x03  ; Text mode with input
        .M_NO_SCROLL    = 0x04  ; Disables scrolling of the screen in text mode
        .M_NO_INTERP    = 0x08  ; Disables special character interpretation

        ;; Table of routines for modes
        .MODE_TABLE     = 0xFFE0

        ;; Global variables
        .define .tmp "__TEMP"

        ;; Symbols defined at link time
        .globl _shadow_OAM

.macro PHP
        .db 0x08
.endm

.macro PLP
        .db 0x28
.endm

.macro PHY
        .db 0x5a
.endm

.macro PLY
        .db 0x7a
.endm

.macro STZ_B addr
        .db 0x64, addr
.endm

.macro STA_IND addr
        .db 0x92, addr
.endm

.macro LDA_IND addr
        .db 0xb2, addr
.endm

.macro PHX
        .db 0xda
.endm

.macro PLX
        .db 0xfa
.endm
