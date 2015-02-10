Floor = class("Floor")

function Floor:initialize()
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

  for xCurrent = xStart, xEnd do
    for yCurrent = yStart, yEnd do
      if (xCurrent+yCurrent) % 2 == 0 then
        love.graphics.setColor(48, 48, 48)
      else
        love.graphics.setColor(32, 32, 32)
      end

      local x, y = camera:toLocal(xCurrent*64, yCurrent*64)
      love.graphics.rectangle("fill", x, y, 64, 64)
    end
  end
end
