Floor = class("Floor")

function Floor:initialize(world, width, height)
  self.body = love.physics.newBody(world, 0, 0)
  self.shape = love.physics.newRectangleShape(width, height)
  self.fixture = love.physics.newFixture(self.body, self.shape)
end

function Floor:draw(camera)
  local xCamera = camera:getX()
  local yCamera = camera:getY()

  local xStart = math.floor((xCamera - love.graphics.getWidth() / 2) / 64)
  local yStart = math.floor((yCamera - love.graphics.getHeight() / 2) / 64)
  
  local xEnd = math.ceil((xCamera + love.graphics.getWidth() / 2) / 64)
  local yEnd = math.ceil((yCamera + love.graphics.getHeight() / 2) / 64)

  local xShift = love.graphics.getWidth()/2 - xCamera
  local yShift = love.graphics.getHeight()/2 - yCamera

  for x = xStart, xEnd do
    for y = yStart, yEnd do
      if (x+y) % 2 == 0 then
        love.graphics.setColor(255, 255, 255)
      else
        love.graphics.setColor(200, 200, 200)
      end

      love.graphics.rectangle("fill", x*64 + xShift, y*64 + yShift, 64, 64)
    end
  end
end
