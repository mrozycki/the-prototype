Player = class("Player")

function Player:initialize(world, x, y)
  self.size = 32
  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.shape = love.physics.newRectangleShape(self.size, self.size)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.body:setLinearDamping(5)
  self.maxPushForce = 2000 * self.body:getMass()
  self.bullets = {}
  self.world = world
  self.firingRate = 5
  self.nextBullet = 0
end

function Player:update(dt)
  self:updateBullets(dt)
  self:fire(dt)
  self:move(dt)
end

function Player:draw(camera)
  love.graphics.setColor(0, 255, 0)
  love.graphics.polygon("fill", 
    camera:toLocal(self.body:getWorldPoints(self.shape:getPoints()))
  )

  for i = 1, #self.bullets do
    self.bullets[i]:draw(camera)
  end
end

function Player:move(dt)
  local dx = 0
  local dy = 0

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

function Player:updateBullets(dt)
  for i = #self.bullets, 1, -1 do
    self.bullets[i]:update(dt)
    if self.bullets[i].destroyed then
      table.remove(self.bullets, i)
    end
  end
end

function Player:fire(dt)
  self.nextBullet = math.max(0, self.nextBullet - dt)

  if self.nextBullet > 0 then
    return
  end

  local xSelfVelocity, ySelfVelocity = self.body:getLinearVelocity()
  local xVelocity, yVelocity
  local xOffset, yOffset

  if love.keyboard.isDown("left") then
    xVelocity, yVelocity = -200, 0
    xOffset, yOffset = -self.size/2-3, 0
  elseif love.keyboard.isDown("right") then
    xVelocity, yVelocity = 200, 0
    xOffset, yOffset = self.size/2+3, 0
  elseif love.keyboard.isDown("up") then
    xVelocity, yVelocity = 0, -200
    xOffset, yOffset = 0, -self.size/2-3
  elseif love.keyboard.isDown("down") then
    xVelocity, yVelocity = 0, 200
    xOffset, yOffset = 0, self.size/2+3
  end

  if xOffset then
    self.bullets[#self.bullets + 1] = Bullet(world, self,
      self.body:getX()+xOffset, self.body:getY()+yOffset,
      xVelocity+xSelfVelocity, yVelocity+ySelfVelocity,
      2.0
    )
    self.nextBullet = 1/self.firingRate
  end
end
