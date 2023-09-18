/** @file nes/nes.h
    NES specific functions.
*/
#ifndef _SV_H
#define _SV_H

#include <types.h>
#include <stdint.h>
#include <stdbool.h>
#include <gbdk/version.h>
#include <sv/hardware.h>

#define WATARA_SUPERVISION

// Here NINTENDO means Game Boy & related clones
#ifdef NINTENDO
#undef NINTENDO
#endif

#ifdef SEGA
#undef SEGA
#endif

#ifdef MSX
#undef MSX
#endif

/** Joypad bits.
    A logical OR of these is used in the wait_pad and joypad
    functions.  For example, to see if the B button is pressed
    try

    uint8_t keys;
    keys = joypad();
    if (keys & J_B) {
        ...
    }

    @see joypad
 */
#define J_UP         0x08U
#define J_DOWN       0x04U
#define J_LEFT       0x02U
#define J_RIGHT      0x01U
#define J_A          0x20U
#define J_B          0x10U
#define J_SELECT     0x40U
#define J_START      0x80U

/** Turns on the background layer.
    Sets bit 0 of the LCDC register to 1.
*/
#define SHOW_BKG \
    shadow_BANK |= BANK_SHOW_BG;

/** Turns on the sprites layer.
    Sets bit 1 of the LCDC register to 1.
*/
#define SHOW_SPRITES ;

/** Reads and returns the current state of the joypad.
    Return value is an OR of J_*

    When testing for multiple different buttons, it's
    best to read the joypad state *once* into a variable
    and then test using that variable.

    @see J_START, J_SELECT, J_A, J_B, J_UP, J_DOWN, J_LEFT, J_RIGHT
*/
uint8_t joypad(void) {
    return JOYPAD^0xff;
}

/** Waits for the vertical blank interrupt.

    This is often used in main loops to idle the CPU
    until it's time to start the next frame. It's also useful for
    syncing animation with the screen re-draw.

    Warning: If the VBL interrupt is disabled, this function will
    never return.
*/
void vsync(void);

typedef struct OAM_item_t {
    uint8_t y;     //< Y coordinate of the sprite on screen - 1
    uint8_t tile;  //< Sprite tile number
    uint8_t prop;  //< OAM Property Flags
    uint8_t x;     //< X coordinate of the sprite on screen
} OAM_item_t;

/** Shadow OAM array in WRAM, that is DMA-transferred into the real OAM each VBlank
*/
extern volatile struct OAM_item_t shadow_OAM[];

/** Sets VRAM Tile Pattern data for Sprites

    Writes __nb_tiles__ tiles to VRAM starting at __first_tile__, tile data
    is sourced from __data__. Each Tile is 16 bytes in size (8x8 pixels, 2 bits-per-pixel).

    Note: Sprite Tiles 128-255 share the same memory region as Background Tiles 128-255.

    GBC only: @ref VBK_REG determines which bank of tile patterns are written to.
    \li VBK_REG=0 indicates the first bank
    \li VBK_REG=1 indicates the second
*/
void set_sprite_data(uint8_t first_tile, uint8_t nb_tiles, const uint8_t *data);

/** Sets sprite number __nb__in the OAM to display tile number __tile__.

    @param nb    Sprite number, range 0 - 63
    @param tile  Selects a tile (0 - 255) from PPU memory at 0000h - 0FFFh / 1000h - 1FFFh

    In 8x16 mode:
    \li The sprite will also display the next tile (__tile__ + 1)
        directly below (y + 8) the first tile.
    \li The lower bit of the tile number is ignored:
        the upper 8x8 tile is (__tile__ & 0xFE), and
        the lower 8x8 tile is (__tile__ | 0x01).
    \li See: @ref SPRITES_8x16
*/
inline void set_sprite_tile(uint8_t nb, uint8_t tile) {
    shadow_OAM[nb].tile=tile;
}

void display_sprite(uint8_t tile_idx, uint8_t x, uint8_t y, bool should_display);

/** Moves sprite number __nb__ to the __x__, __y__ position on the screen.

    @param nb  Sprite number, range 0 - 63
    @param x   X Position. Specifies the sprites horizontal position on the screen (minus 8).
    @param y   Y Position. Specifies the sprites vertical position on the screen (minus 16).
               \n An offscreen value (Y>=240) hides the sprite.

    Moving the sprite to 0,0 (or similar off-screen location) will hide it.
*/
void move_sprite(uint8_t nb, uint8_t x, uint8_t y) {
    OAM_item_t * itm = &shadow_OAM[nb];
    display_sprite(itm->tile, itm->x, itm->y, FALSE);
    itm->x = x;
    itm->y = y;
    display_sprite(itm->tile, itm->x, itm->y, TRUE);
}

#endif /* _SV_H */
