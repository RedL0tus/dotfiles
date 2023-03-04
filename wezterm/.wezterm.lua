local wezterm = require 'wezterm'

local plex_mono = wezterm.font_with_fallback({
  {
    family="IBM Plex Mono Medium",
    weight="Regular",
    harfbuzz_features={"calt=0", "clig=0", "liga=0"}
  },
  { family="JetBrains Mono", weight="Bold" },
  "Noto Color Emoji"
})

return {
  window_frame = {
    font = plex_mono,

    font_size = 11.0,
  },

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom ,
  },

  dpi = 144.0,

  font = plex_mono,
  freetype_load_target = "Normal",
  font_size = 11.0,

  enable_tab_bar = true,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,

  check_for_updates = false,

  color_scheme = "Afterglow",

  ssh_domains = {
    {
      name = "zinfandel",
      remote_address = "10.0.200.11",
      username = "root",
    }
  },

  audible_bell = "Disabled",
  visual_bell = {
    fade_in_duration_ms = 75,
    fade_out_duration_ms = 75,
    target = "CursorColor"
  }
}
