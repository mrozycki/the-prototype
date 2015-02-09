Player = class("Player")

function Player:initialize(world, floor, x, y)
  self.body = love.physics.newBody(world, x, y, "dynamic")
  self.shape = love.physics.newRectangleShape(32, 32)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.floorJoint = love.physics.newFrictionJoint(floor.body, self.body, x, y)
  self.floorJoint:setMaxForce(700)
end

function Player:update(dt)

end

function Player:draw(camera)
  love.graphics.setColor(0, 200, 0)
  love.graphics.polygon("fill", 
    camera:toLocal(self.body:getWorldPoints(self.shape:getPoints()))
  )
end
