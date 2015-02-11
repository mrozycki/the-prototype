GameOver = {}

function GameOver:enter()

end

function GameOver:update(dt)

end

function GameOver:keypressed()
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
end

function GameOver:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("You've lost!", 100, 100)
  love.graphics.print("Press ESC to quit.", 100, 124)
end
