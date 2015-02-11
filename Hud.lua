Hud = {}

function Hud.draw(player)
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", 100, 0, 6+player.maxhp/10, 20)

  love.graphics.setColor(0, 128, 0)
  love.graphics.rectangle("fill", 103, 3, player.hp/10, 14)
  love.graphics.setColor(255, 255, 255)
  love.graphics.print(math.ceil(player.hp/player.maxhp*1000)/10 .. "%", 120, 4)

  love.graphics.setColor(0, 0, 0)
  love.graphics.circle("fill", 30, 30, 80)
end
