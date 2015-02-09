class = require 'lib.middleclass'
-- state = require 'lib.gamestate'

require 'Objects.Floor'
require 'Objects.Camera'
require 'Objects.Player'

function love.load()
  -- math.randomseed(os.time())
  -- state.registerEvents()

  love.graphics.setBackgroundColor(0, 0, 0)
  love.graphics.setColor(255, 255, 255)

  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 0, true)

  objects = {}
  objects.floor = Floor(world, 10000, 10000)

  objects.camera = Camera(world, objects.floor, 
    -love.graphics.getWidth()/2, -love.graphics.getHeight()/2
  )
  objects.player = Player(world, objects.floor, 0, 0)
end

function love.update(dt)
  objects.camera:update(dt)
  world:update(dt)

  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
end

function love.draw()
  objects.floor:draw(objects.camera.body)
  objects.player:draw(objects.camera)
end
