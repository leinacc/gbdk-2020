/** @file nes/hardware.h
    Defines that let the NES hardware registers be accessed
    from C.
*/
#ifndef _HARDWARE_H
#define _HARDWARE_H

#include <types.h>

#define __SHADOW_REG extern volatile uint8_t
#define __REG(addr) volatile __at (addr) uint8_t

__REG(0x2020) JOYPAD;
__SHADOW_REG shadow_JOYPAD;

__REG(0x2026) BANK;
#define BANK_SHOW_BG     0b00001000
__SHADOW_REG shadow_BANK;

#endif
