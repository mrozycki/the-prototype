Bullet = class("Bullet")

function Bullet:initialize(world, player, x, y, vx, vy, lifetime)
  self.body = love.physics.newBody(world, x, y, "kinematic")
  self.body:setLinearVelocity(vx, vy)
  self.body:setBullet(true)
  self.shape = love.physics.newRectangleShape(4, 4)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.fixture:setUserData(self)

  self.speed = math.sqrt(vx*vx, vy*vy)
  self.lifetime = lifetime
  self.stopped = false
  self.destroyed = false
end

function Bullet:update(dt)
  self.lifetime = self.lifetime - dt
  if not self.stopped and self.lifetime < 0 then
    self.stopped = true
    self.lifetime = 5
    self.body:setLinearVelocity(0, 0)
  elseif self.stopped and self.lifetime < 0 then
    self:destroy()
  end
end

function Bullet:draw()
  love.graphics.setColor(0, 255, 0)
  love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

function Bullet:destroy()
  self.fixture:destroy()
  self.destroyed = true
end

function Bullet:collideWith(object, collision)
  self:destroy()
end
