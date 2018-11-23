SharpShooterGame = {};

function SharpShooterGame.load()
  -- Variables
  SharpShooterGame.crosshair = love.graphics.newImage("GFX/Sprites/SharpShooterGame_crosshair.png");
  SharpShooterGame.backgroundGFX = love.graphics.newImage("GFX/Backgrounds/SharpShooterGame_main.png");

  Crosshair = {};
    -- Variables
    Crosshair.y = love.graphics.getWidth() / 2;
    Crosshair.x = 10;
    Crosshair.speed = 0;
    Crosshair.topSpeed = 180;

    -- Functions
    Crosshair.GetNewYSpeed = function(aDeltaTime)
      return
    end

  Target = {}
    -- Variables
    Target.GFX = love.graphics.newImage("GFX/Sprites/SharpShooterGame_target.png");
    Target.x = love.graphics.getWidth() / 2 - Target.GFX:getWidth() / 2;
    Target.y = love.graphics.getHeight() / 2 - Target.GFX:getHeight() / 2;
    Target.midX = love.graphics.getWidth() / 2;
    Target.midY = love.graphics.getHeight() / 2;
end

function SharpShooterGame.update(dt)
  Crosshair.GetNewYSpeed(dt);
end

function SharpShooterGame.draw()

end
