Bullet = class("Bullet")

function Bullet:initialize(world, player, x, y, vx, vy, lifetime)
  self.body = love.physics.newBody(world, x, y, "kinematic")
  self.shape = love.physics.newRectangleShape(4, 4)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.body:setLinearVelocity(vx, vy)
  self.body:setBullet(true)
  self.speed = math.sqrt(vx*vx, vy*vy)
  self.lifetime = lifetime
  self.destroyed = false
end

function Bullet:update(dt)
  self.lifetime = self.lifetime - dt
  if self.lifetime < 0 then
    self:destroy()
  end
end

function Bullet:draw(camera)
  love.graphics.setColor(0, 255, 0)
  love.graphics.polygon("fill", camera:toLocal(self.body:getWorldPoints(self.shape:getPoints())))
end

function Bullet:destroy()
  self.fixture:destroy()
  self.destroyed = true
end
