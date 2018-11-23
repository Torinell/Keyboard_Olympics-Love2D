SharpShooterGame = {};

function SharpShooterGame.load()
  -- Variables
  SharpShooterGame.crosshair = love.graphics.newImage("GFX/Sprites/SharpShooterGame_crosshair.png");
  SharpShooterGame.crosshairSpeed = 0;
  SharpShooterGame.backgroundGFX = love.graphics.newImage("GFX/Backgrounds/SharpShooterGame_main.png");
  -- Functions
  SharpShooterGame.GetNewYSpeed = function()

  end

function SharpShooterGame.CreateTarget()
Target = {}
  -- Variables
  Target.GFX = love.graphics.newImage("GFX/Sprites/SharpShooterGame_target.png");
  Target.x = love.graphics.getWidth() / 2 - Target.GFX:getWidth() / 2;
  Target.y = love.graphics.getHeight() / 2 - Target.GFX:getHeight() / 2;
  Target.midX = love.graphics.getWidth() / 2;
  Target.midY = love.graphics.getHeight() / 2;
end
  -- Unload state
  Utils.UnloadCurrentState = function()
    SharpShooterGame = nil;
  end
end

function SharpShooterGame.update(dt)

end

function SharpShooterGame.draw()

end
