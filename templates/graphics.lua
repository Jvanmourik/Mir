-- get all possible quads
local quads = require "templates/quads"

-- makes referencing a specific quad easier
return {
  kramer = {
    walk = {
      frames = {
        quads["kramer/walk-1"],
        quads["kramer/walk-2"],
        quads["kramer/walk-3"],
        quads["kramer/walk-4"]
      }
    }
  }
}
