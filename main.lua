class = require 'lib.middleclass'

require 'Objects.Floor'
require 'Objects.Camera'
require 'Objects.Bullet'
require 'Objects.Player'

function love.load()
  world = love.physics.newWorld(0, 0, true)

  player = Player(world, 0, 0)
  camera = Camera(player)

  objects = {}
  objects.floor = Floor()
end

function love.update(dt)
  world:update(dt)
  player:update(dt)

  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
end

function love.draw()
  camera:set()
  objects.floor:draw(camera:getX(), camera:getY())
  player:draw(camera)
  camera:unset()
end
