local mauve = "rgb(cba6f7)"
local rosewater = "rgb(f5e0dc)"

hl.config({
  general = {
    gaps_in = 6,
    gaps_out = 12,
    border_size = 2,
    ["col.active_border"] = mauve,
    ["col.inactive_border"] = rosewater,
  },
  decoration = {
    rounding = 12,
    blur = {
      enabled = true,
      size = 8,
      passes = 1,
    },
    shadow = {
      enabled = true,
      range = 20,
      render_power = 3,
      color = "rgba(000000aa)",
    },
  },
})

hl.curve("snappy", {
  type = "bezier",
  points = {
    { 0.18, 1.0 },
    { 0.28, 1.0 },
  },
})

hl.curve("smooth", {
  type = "bezier",
  points = {
    { 0.22, 1.0 },
    { 0.36, 1.0 },
  },
})

hl.curve("decel", {
  type = "bezier",
  points = {
    { 0.12, 0.95 },
    { 0.2, 1.0 },
  },
})

hl.curve("softsnap", {
  type = "bezier",
  points = {
    { 0.16, 1.0 },
    { 0.3, 1.02 },
  },
})

hl.curve("accelerate", {
  type = "bezier",
  points = {
    { 0.4, 0.0 },
    { 1.0, 1.0 },
  },
})

hl.animation({ leaf = "global", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "snappy" })
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "softsnap", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "smooth", style = "popin 94%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "accelerate", style = "popin 90%" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "decel" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2, bezier = "decel" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "accelerate" })
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "snappy" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "smooth", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "accelerate", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "decel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 3, bezier = "accelerate" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "snappy", style = "slidefade 8%" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3, bezier = "smooth", style = "slidefade 8%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1, bezier = "accelerate", style = "slidefade 8%" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 2, bezier = "snappy" })

local kitty_float = hl.window_rule({
  name = "kitty-hud",
  match = { class = "^(kitty)$", focus = true },
  float = true,
  center = true,
  size = { 1000, 650 },
  opacity = "0.95 override 0.95 override",
})

hl.window_rule({
  name = "terminal-clarity",
  match = { class = "^(kitty)$" },
  opacity = "0.97 override 0.97 override",
})

hl.window_rule({
  name = "global-opacity",
  match = { class = ".*" },
  opacity = "0.92 override 0.75 override",
})

hl.window_rule({
  name = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})
