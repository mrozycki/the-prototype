Camera = class("Camera") 

function Camera:initialize(world, player, x, y, width, height)
  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.player = player
  self.width = width
  self.height = height
end

function Camera:update()
  self.body:setX(self.player.body:getX())
  self.body:setY(self.player.body:getY())
end

function Camera:toLocal(...)
  local arg = {...}
  local result = {}
  for i = 1, #arg, 2 do
    result[i], result[i+1] = self.body:getLocalPoint(tonumber(arg[i]), tonumber(arg[i+1]))
    result[i] = result[i] + self.width/2
    result[i+1] = result[i+1] + self.height/2
  end

  return unpack(result)
end

function Camera:getX() return self.body:getX() end
function Camera:getY() return self.body:getY() end
