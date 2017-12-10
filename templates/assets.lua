-- declare shorthand newQuad
local quad = love.graphics.newQuad

-- makes referencing specific frames easier
return {
  character = {
    unarmed = {
      idle = {
        frame = quad(218, 389, 252, 180, 538, 744),
        anchorX = 0.7,
        anchorY = 0.47
      }
    },
    sword_shield = {
      idle = {
        frame = quad(218, 0, 320, 389, 538, 744),
        anchorX = 0.7,
        anchorY = 0.47
      },
      stab = {
        frame = quad(0, 0, 218, 744, 538, 744),
        anchorX = 0.35,
        anchorY = 0.36
      }
    }
  }
}
