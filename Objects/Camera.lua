Camera = class("Camera") 

function Camera:initialize(player)
  self.player = player
end

function Camera:set()
  love.graphics.push()
  love.graphics.translate(
    -player.body:getX() + love.graphics.getWidth()/2,
    -player.body:getY() + love.graphics.getHeight()/2
  )
end

function Camera:unset()
  love.graphics.pop()
end

function Camera:getX() return self.player.body:getX() end
function Camera:getY() return self.player.body:getY() end
