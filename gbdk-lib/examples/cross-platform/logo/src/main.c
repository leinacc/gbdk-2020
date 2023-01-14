#include <gbdk/platform.h>

#include "GBDK_2020_logo.h"

// TODO: Figure out why SMS/GG needs attributes enabled in png2asset, without actually using them...
#define HAS_ATTRIBUTES (defined(GBDK_2020_logo_MAP_ATTRIBUTES_WIDTH) && !defined(SEGA))

void main() {
    DISPLAY_OFF;
    fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
#if defined(SYSTEM_SEGA)
    set_palette(0, GBDK_2020_logo_PALETTE_COUNT, GBDK_2020_logo_palettes);
#elif defined(SYSTEM_CGB)
    if (_cpu == CGB_TYPE) {
        set_bkg_palette(BKGF_CGB_PAL0, GBDK_2020_logo_PALETTE_COUNT, GBDK_2020_logo_palettes);
    }
#elif defined(SYSTEM_NES)
    set_bkg_palette(0, GBDK_2020_logo_PALETTE_COUNT, GBDK_2020_logo_palettes);
#endif 
    set_native_tile_data(0, GBDK_2020_logo_TILE_COUNT, GBDK_2020_logo_tiles);
#if HAS_ATTRIBUTES
    set_bkg_attributes((DEVICE_SCREEN_WIDTH - (GBDK_2020_logo_WIDTH >> 3)) >> 1, 
                       (DEVICE_SCREEN_HEIGHT - (GBDK_2020_logo_HEIGHT >> 3)) >> 1, 
                       GBDK_2020_logo_WIDTH >> 3, 
                       GBDK_2020_logo_HEIGHT >> 3, 
                       GBDK_2020_logo_map_attributes);
#endif
    set_tile_map((DEVICE_SCREEN_WIDTH - (GBDK_2020_logo_WIDTH >> 3)) >> 1, 
                 (DEVICE_SCREEN_HEIGHT - (GBDK_2020_logo_HEIGHT >> 3)) >> 1, 
                 GBDK_2020_logo_WIDTH >> 3, 
                 GBDK_2020_logo_HEIGHT >> 3, 
                 GBDK_2020_logo_map);
    SHOW_BKG;
    DISPLAY_ON;
}