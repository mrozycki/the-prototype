Gameplay = {}

function Gameplay:enter()
  math.randomseed(os.time())
  self.world = love.physics.newWorld(0, 0, true)

  self.player = Player(self.world, 0, 0)
  self.camera = Camera(self.player)

  self.objects = {}
  self.objects.floor = Floor()
  
  self.enemies = {}
  self.deadEnemies = {}
  self.nextEnemyIn = 0

  self.world:setCallbacks(self.beginContact)
end

function Gameplay:update(dt)
  self.world:update(dt)
  self.player:update(dt)
  for i = #self.enemies, 1, -1 do
    self.enemies[i]:update(dt)
    if not self.enemies[i].alive then
      table.insert(self.deadEnemies, self.enemies[i])
      table.remove(self.enemies, i)
    end
  end

  if self.nextEnemyIn <= 0 then
    -- self.addRandomEnemy(self.enemies, self.world, self.player)
    self.nextEnemyIn = math.random(50)/10
  else
    self.nextEnemyIn = self.nextEnemyIn - dt
  end
end

function Gameplay:keypressed()
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
end

function Gameplay:draw()
  self.camera:set()
  self.objects.floor:draw(self.camera:getX(), self.camera:getY())
  for i = 1, #self.deadEnemies do
    self.deadEnemies[i]:draw()
  end

  for i = 1, #self.enemies do
    self.enemies[i]:draw()
  end

  self.player:draw(self.camera)
  self.camera:unset()

  Hud.draw(self.player)
end

function Gameplay.addRandomEnemy(enemies, world, player)
  local x = math.random(love.graphics.getWidth())
  local y = math.random(love.graphics.getHeight())
  
  local topDist = x
  local bottomDist = love.graphics.getWidth() - x
  local leftDist = y
  local rightDist = love.graphics.getHeight() - y

  if topDist == math.min(topDist, math.min(bottomDist, math.min(leftDist, rightDist))) then
    x = x - (topDist + 64)
  elseif bottomDist == math.min(bottomDist, math.min(leftDist, rightDist)) then
    x = x + (bottomDist + 64)
  elseif leftDist == math.min(leftDist, rightDist) then
    y = y - (leftDist + 64)
  else
    y = y + (rightDist + 64)
  end

  table.insert(enemies, 
    Enemy(world, 
      player.body:getX()+x - love.graphics.getWidth()/2,
      player.body:getY()+y - love.graphics.getHeight()/2, 
      player
    )
  )
end

function Gameplay.beginContact(a, b, collision)
  a:getUserData():collideWith(b:getUserData(), collision)
  b:getUserData():collideWith(a:getUserData(), collision)
end
