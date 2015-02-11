Enemy = class("Enemy")

function Enemy:initialize(world, x, y, player)
  self.size = 32
  self.player = player
  self.maxPushForce = 1000
  self.hp = 3
  self.alive = true

  -- set up the physics
  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.body:setLinearDamping(5)
  self.shape = love.physics.newRectangleShape(self.size, self.size)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.fixture:setUserData(self)
end

function Enemy:update(dt)
  self.body:setAngle(0)
  if self.hp <= 0 and self.alive then
    self:destroy()
  end

  if not self.alive then
    return
  end

  -- get direction towards the player
  local dx = self.player.body:getX() - self.body:getX()
  local dy = self.player.body:getY() - self.body:getY()
  local magnitude = math.sqrt(dx*dx + dy*dy)
  dx, dy = dx/magnitude, dy/magnitude

  -- push the enemy towards the player
  self.body:applyForce(dx*self.maxPushForce, dy*self.maxPushForce)
end

function Enemy:destroy()
  self.body:setActive(false)
  self.fixture:destroy()
  self.alive = false
end

function Enemy:draw()
  if self.alive then
    love.graphics.setColor(128, 0, 0)
  else
    love.graphics.setColor(16, 16, 16)
  end
  love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

function Enemy:collideWith(object, collision)
  if object:isInstanceOf(Bullet) then
    self.hp = self.hp - 1
  end
end
