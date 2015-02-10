Floor = class("Floor")

function Floor:initialize()
end

function Floor:draw(xCamera, yCamera)
  local xStart = math.floor((xCamera - love.graphics.getWidth() / 2) / 64)
  local yStart = math.floor((yCamera - love.graphics.getHeight() / 2) / 64)
  
  local xEnd = math.ceil((xCamera + love.graphics.getWidth() / 2) / 64)
  local yEnd = math.ceil((yCamera + love.graphics.getHeight() / 2) / 64)

  for x = xStart, xEnd do
    for y = yStart, yEnd do
      if (x+y) % 2 == 0 then
        love.graphics.setColor(48, 48, 48)
      else
        love.graphics.setColor(32, 32, 32)
      end

      love.graphics.rectangle("fill", x*64, y*64, 64, 64)
    end
  end
end
