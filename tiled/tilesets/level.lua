return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 30,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 8,
  properties = {},
  tilesets = {
    {
      name = "grass",
      firstgid = 1,
      filename = "grass.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "grass-tiles-2-small.png",
      imagewidth = 192,
      imageheight = 64,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 12,
      tiles = {}
    },
    {
      name = "WaterAndFire",
      firstgid = 13,
      filename = "Water.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "WaterAndFire.png",
      imagewidth = 192,
      imageheight = 256,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {
        {
          name = "water",
          tile = -1,
          properties = {}
        },
        {
          name = "water",
          tile = 22,
          properties = {}
        },
        {
          name = "Nieuw Terrein",
          tile = 22,
          properties = {}
        }
      },
      tilecount = 48,
      tiles = {
        {
          id = 3,
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 2,
                name = "",
                type = "",
                shape = "rectangle",
                x = 4.875,
                y = 3.625,
                width = 27,
                height = 13.875,
                rotation = 0,
                visible = true,
                properties = {}
              },
              {
                id = 3,
                name = "",
                type = "",
                shape = "rectangle",
                x = 0.125,
                y = 17.5,
                width = 31.75,
                height = 14.25,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 4,
          terrain = { 1, 1, 1, -1 },
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = 0,
                y = -0.125,
                width = 23,
                height = 31.625,
                rotation = 0,
                visible = true,
                properties = {}
              },
              {
                id = 2,
                name = "",
                type = "",
                shape = "rectangle",
                x = 23.125,
                y = 0.125,
                width = 9,
                height = 23.375,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 5,
          terrain = { 1, 1, -1, 1 },
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = 0.125,
                y = 0,
                width = 31.875,
                height = 19.875,
                rotation = 0,
                visible = true,
                properties = {}
              },
              {
                id = 2,
                name = "",
                type = "",
                shape = "rectangle",
                x = 9.25,
                y = 20.25,
                width = 22.75,
                height = 11.875,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 9,
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = 8,
                y = 7.5,
                width = 16,
                height = 19.875,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 10,
          terrain = { 1, -1, 1, 1 },
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 4,
                name = "",
                type = "",
                shape = "rectangle",
                x = 0.25,
                y = 0,
                width = 21,
                height = 32,
                rotation = 0,
                visible = true,
                properties = {}
              },
              {
                id = 5,
                name = "",
                type = "",
                shape = "rectangle",
                x = 21.5,
                y = 10.5,
                width = 10.5,
                height = 21.25,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 11,
          terrain = { -1, 1, 1, 1 },
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = 10.125,
                y = 0.125,
                width = 21.75,
                height = 32,
                rotation = 0,
                visible = true,
                properties = {}
              },
              {
                id = 2,
                name = "",
                type = "",
                shape = "rectangle",
                x = 0,
                y = 9.25,
                width = 10.125,
                height = 22.75,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 15,
          terrain = { -1, -1, -1, 1 },
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "polygon",
                x = 31.75,
                y = 8.125,
                width = 0,
                height = 0,
                rotation = 0,
                visible = true,
                polygon = {
                  { x = -0.5, y = -0.75 },
                  { x = -0.125, y = 23.625 },
                  { x = -22.375, y = 23.625 }
                },
                properties = {}
              }
            }
          }
        },
        {
          id = 16,
          terrain = { -1, -1, 1, 1 },
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = 0.25,
                y = 9.375,
                width = 31.75,
                height = 22.625,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 17,
          terrain = { -1, -1, 1, -1 },
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "polygon",
                x = 0.125,
                y = 7.75,
                width = 0,
                height = 0,
                rotation = 0,
                visible = true,
                polygon = {
                  { x = 0, y = 0 },
                  { x = 22.25, y = 24.25 },
                  { x = -0.125, y = 24.25 }
                },
                properties = {}
              }
            }
          }
        },
        {
          id = 21,
          terrain = { -1, 1, -1, 1 },
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = 8.875,
                y = 0.125,
                width = 23.25,
                height = 31.875,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 22,
          terrain = { 1, 1, 1, 1 },
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = 0,
                y = 0,
                width = 32,
                height = 32,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 23,
          terrain = { 1, -1, 1, -1 },
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 2,
                name = "",
                type = "",
                shape = "rectangle",
                x = 0.25,
                y = 0,
                width = 22.75,
                height = 31.875,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 27,
          terrain = { -1, 1, -1, -1 },
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "polygon",
                x = 9.125,
                y = -0.125,
                width = 0,
                height = 0,
                rotation = 0,
                visible = true,
                polygon = {
                  { x = 0, y = 0 },
                  { x = 22.625, y = 0.25 },
                  { x = 22.75, y = 21 }
                },
                properties = {}
              }
            }
          }
        },
        {
          id = 28,
          terrain = { 1, 1, -1, -1 },
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 2,
                name = "",
                type = "",
                shape = "rectangle",
                x = 0.125,
                y = -0.125,
                width = 32,
                height = 20,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 29,
          terrain = { 1, -1, -1, -1 },
          objectGroup = {
            type = "objectgroup",
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "polygon",
                x = 23,
                y = -0.125,
                width = 0,
                height = 0,
                rotation = 0,
                visible = true,
                polygon = {
                  { x = 0, y = 0 },
                  { x = -23, y = 0 },
                  { x = -22.875, y = 22.75 }
                },
                properties = {}
              }
            }
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "grondlaag",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
    },
    {
      type = "tilelayer",
      name = "waterlaag",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35,
        35, 17, 41, 41, 41, 18, 17, 41, 41, 41, 41, 41, 41, 18, 17, 41, 18, 17, 41, 41, 41, 41, 18, 35, 35, 35, 17, 41, 18, 35,
        35, 36, 6, 0, 0, 40, 42, 0, 0, 0, 0, 0, 0, 34, 23, 30, 40, 42, 0, 0, 0, 0, 40, 41, 41, 41, 42, 0, 34, 35,
        35, 23, 30, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 40, 41, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35,
        35, 35, 23, 29, 29, 29, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35,
        35, 35, 35, 35, 35, 35, 23, 29, 29, 29, 30, 0, 28, 29, 29, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35,
        35, 17, 41, 41, 18, 35, 35, 35, 35, 35, 23, 29, 24, 35, 35, 23, 29, 29, 29, 30, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35,
        35, 36, 0, 0, 40, 41, 41, 41, 18, 35, 35, 35, 35, 35, 17, 41, 18, 35, 35, 23, 29, 30, 0, 0, 0, 0, 0, 0, 34, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 40, 41, 41, 41, 18, 17, 42, 0, 40, 41, 41, 41, 41, 42, 0, 0, 0, 0, 0, 0, 34, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 23, 30, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 28, 29, 24, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 18, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35, 35, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 18, 35, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 18, 35,
        35, 36, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 28, 24, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 24, 17, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 34, 35,
        35, 23, 30, 0, 0, 0, 0, 0, 0, 0, 28, 24, 17, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35,
        35, 35, 23, 30, 0, 0, 0, 0, 0, 28, 24, 17, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35,
        35, 17, 41, 42, 0, 0, 0, 0, 0, 34, 17, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 29, 30, 0, 34, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 0, 34, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35, 36, 0, 34, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 0, 40, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 18, 23, 29, 24, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 41, 41, 18, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35,
        35, 36, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 30, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 29, 30, 40, 42, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35,
        35, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35, 23, 29, 29, 29, 29, 30, 0, 0, 0, 0, 28, 24, 35,
        35, 23, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 29, 24, 35, 35, 35, 35, 35, 35, 23, 29, 29, 29, 29, 24, 35, 35,
        35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35
      }
    },
    {
      type = "objectgroup",
      name = "objectlaag",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "playerSpawn",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 254,
          width = 31,
          height = 33,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "enemySpawn",
          type = "",
          shape = "rectangle",
          x = 193,
          y = 609,
          width = 31,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "enemySpawn",
          type = "",
          shape = "rectangle",
          x = 611,
          y = 354,
          width = 28,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "enemySpawn",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 417,
          width = 31,
          height = 29,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "enemySpawn",
          type = "",
          shape = "rectangle",
          x = 193,
          y = 95,
          width = 32,
          height = 33,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      name = "boomlaag",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
