SharpShooterGame = {};

function SharpShooterGame.load()
  -- Variables
  SharpShooterGame.crosshair = love.graphics.newImage("GFX/Sprites/SharpShooterGame_crosshair.png");
  SharpShooterGame.crosshairSpeed = 0;
  SharpShooterGame.targetGFX = love.graphics.newImage("GFX/Sprites/SharpShooterGame_target.png");
  SharpShooterGame.targetX = love.graphics.getWidth() / 2;
  SharpShooterGame.targetY = love.graphics.getHeight() / 2;
  SharpShooterGame.backgroundGFX = love.graphics.newImage("GFX/Backgrounds/SharpShooterGame_main.png");
  -- Functions
  SharpShooterGame.GetNewYSpeed = function()

  end;

  Utils.UnloadCurrentState = function()
    SharpShooterGame = nil;
  end
end

function SharpShooterGame.update(dt)

end

function SharpShooterGame.draw()
  love.graphics.draw(SharpShooterGame.backgroundGFX, 0, 0);
  love.graphics.draw(SharpShooterGame.crosshair, S, y, r, sx, sy, ox, oy, kx, ky)
end
