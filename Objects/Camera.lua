Camera = class("Camera") -- creates a Camera class

function Camera:initialize(world, player, x, y, width, height)
  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.body:setMass(0.5)
  -- self.floorJoint = love.physics.newFrictionJoint(floor.body, self.body, x, y)
  -- self.floorJoint:setMaxForce(700)
  self.body:setLinearDamping(5)
  self.maxPushForce = 2000 * self.body:getMass()
  self.player = player
  self.width = width
  self.height = height
end

function Camera:update(dt)
  local dx, dy = 0, 0 --self.body:getLocalPoint(self.player.body:getX(), self.player.body:getY())

  if love.keyboard.isDown("a") then
    dx = dx - dt
  end

  if love.keyboard.isDown("d") then
    dx = dx + dt
  end

  if love.keyboard.isDown("w") then
    dy = dy - dt
  end

  if love.keyboard.isDown("s") then
    dy = dy + dt
  end

  local magnitude = math.sqrt(dx*dx + dy*dy)

  if magnitude > 0 then
    self.body:applyForce(dx*self.maxPushForce/magnitude, dy*self.maxPushForce/magnitude)
  end
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
