if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

local utf8 = require("utf8")

local GameState = require("src/GameState")
local MenuState = require("src/states/MenuState")
local Renderer = require("src/Renderer")

-- Constants
--scale = 2 -- love.window.getDPIScale()
initial_scale = 1.5
--window_width = 640 * scale
--window_height = 480 * scale
initial_window_width = 1366
initial_window_height = 768

-- Game internals
local game_state = nil
local renderer = nil

-- Yeah whatever nerd:
math.randomseed(os.time())

function love.load(arg)
    love.mouse.setVisible(false)
    love.window.setTitle("black_cartograph.exe")
    love.window.setMode(initial_window_width, initial_window_height, {resizable=false, vsync=false})

    local initial_state = MenuState:init()
    game_state = GameState:init(initial_state)
    renderer = Renderer:init(initial_scale, initial_window_width, initial_window_height)
end

function love.keypressed(key)
    game_state:key_pressed(key)
end

function love.textinput(key)
end

function love.update(dt)
    game_state:update_current_state(dt)
end

function love.draw()
    renderer:render(game_state)
end
