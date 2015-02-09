Camera = class("Camera") -- creates a Camera class

function Camera:initialize(world, floor, x, y)
  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.body:setMass(0.5)
  self.floorJoint = love.physics.newFrictionJoint(floor.body, self.body, x, y)
  self.floorJoint:setMaxForce(700)
end

function Camera:update(dt)
  local dx = 0
  local dy = 0

  if love.keyboard.isDown("left") then
    dx = dx - dt
  end

  if love.keyboard.isDown("right") then
    dx = dx + dt
  end

  if love.keyboard.isDown("up") then
    dy = dy - dt
  end

  if love.keyboard.isDown("down") then
    dy = dy + dt
  end

  local magnitude = math.sqrt(dx*dx + dy*dy)

  if magnitude > 0 then
    self.body:applyForce(dx*1000/magnitude, dy*1000/magnitude)
  end
end

function Camera:toLocal(...)
  local arg = {...}
  local result = {}
  for i = 1, #arg, 2 do
    result[i], result[i+1] = self.body:getLocalPoint(tonumber(arg[i]), tonumber(arg[i+1]))
  end

  return unpack(result)
end
