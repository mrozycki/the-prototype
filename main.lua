class = require 'lib.middleclass'

require 'Objects.Floor'
require 'Objects.Camera'
require 'Objects.Bullet'
require 'Objects.Player'

function love.load()
  world = love.physics.newWorld(0, 0, true)

  objects = {}
  objects.floor = Floor()
  objects.player = Player(world, 0, 0)
  objects.camera = Camera(world, objects.player, 0, 0, 
    love.graphics.getWidth(), love.graphics.getHeight()
  )
end

function love.update(dt)
  objects.camera:update(dt)
  objects.player:update(dt)
  world:update(dt)

  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
end

function love.draw()
  objects.floor:draw(objects.camera)
  objects.player:draw(objects.camera)
end
