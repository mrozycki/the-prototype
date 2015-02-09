Player = class("Player")

function Player:initialize(world, floor, x, y)
  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.shape = love.physics.newRectangleShape(32, 32)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.floorJoint = love.physics.newFrictionJoint(floor.body, self.body, x, y)
  self.floorJoint:setMaxForce(700)
end

function Player:update(dt)
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

function Player:draw(camera)
  love.graphics.setColor(0, 200, 0)
  love.graphics.polygon("fill", 
    camera:toLocal(self.body:getWorldPoints(self.shape:getPoints()))
  )
end
