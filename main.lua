class = require 'lib.middleclass'
gamestate = require 'lib.gamestate'

require 'Objects.Floor'
require 'Objects.Camera'
require 'Objects.Bullet'
require 'Objects.Player'
require 'Objects.Enemy'

require 'States.Gameplay'
require 'States.GameOver'

require 'Hud'

function love.load()
  gamestate.registerEvents()
  gamestate.switch(Gameplay)
end

function love.update(dt)
end

function love.draw()
end

