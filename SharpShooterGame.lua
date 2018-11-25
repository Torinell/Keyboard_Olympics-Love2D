
function CreateNewSharpShooterGame()
  SharpShooterGame = {};

  function SharpShooterGame.load()
    -- Variables
    SharpShooterGame.backgroundGFX = love.graphics.newImage("GFX/Backgrounds/SharpShooterGame_main.png");
    SharpShooterGame.bulletGFX = love.graphics.newImage("GFX/Sprites/SharpShooterGame_bullethole.png");
    SharpShooterGame.ScreenMidPoint = {};
    SharpShooterGame.ScreenMidPoint.offset = 50;
    SharpShooterGame.ScreenMidPoint.x = (love.graphics.getWidth() / 2);
    SharpShooterGame.ScreenMidPoint.y = (love.graphics.getHeight() / 2);
    SharpShooterGame.bulletHoles = {};
    SharpShooterGame.Score = {};
    SharpShooterGame.Score.currentScore = 0;
    SharpShooterGame.Score.topScore = 500;
    SharpShooterGame.Score.x = 10;
    SharpShooterGame.Score.y = 20;
    SharpShooterGame.Score.message = "Score: ";
    SharpShooterGame.Score.drawScale = 1;
    SharpShooterGame.bulletMessage = "Bullets: ";
    SharpShooterGame.buttonPressed = false;
    SharpShooterGame.bulletCount = 5;
    SharpShooterGame.gameover = false;
    SharpShooterGame.endMessage = "";

    Target = {};
      -- Variables
      Target.GFX = love.graphics.newImage("GFX/Sprites/SharpShooterGame_target.png");
      Target.x = SharpShooterGame.ScreenMidPoint.x;
      Target.y = SharpShooterGame.ScreenMidPoint.y;
      Target.OriginOffset = {};
      Target.OriginOffset.x = Target.GFX:getWidth() / 2;
      Target.OriginOffset.y = Target.GFX:getHeight() / 2;
      -- Functions
      Target.draw = function()
        love.graphics.draw(Target.GFX, Target.x, Target.y, 0, 1, 1, Target.OriginOffset.x, Target.OriginOffset.y)
      end

    Crosshair = {};
      -- Variables
      Crosshair.GFX = love.graphics.newImage("GFX/Sprites/SharpShooterGame_crosshair.png");
      Crosshair.x = love.graphics.getWidth() / 2;
      Crosshair.y = 10;
      Crosshair.centerY = Crosshair.y;
      Crosshair.speed = 0;
      Crosshair.topSpeed = 600;
      Crosshair.rotation = 0;
      Crosshair.rotationConstant = 0.1;
      Crosshair.OriginOffset = {};
      Crosshair.OriginOffset.x = Crosshair.GFX:getWidth() / 2;
      Crosshair.OriginOffset.y = Crosshair.GFX:getHeight() / 2;
      -- Functions
      Crosshair.update = function(dt)
        Crosshair.speed = Crosshair.GetNewYSpeed(dt);
        Crosshair.y = Crosshair.y + Crosshair.speed;
        Crosshair.centerY = Crosshair.y + Crosshair.OriginOffset.y;
        Crosshair.rotation = Crosshair.rotation + Crosshair.rotationConstant;

        if (Crosshair.GetYDifferenceMultiplier() < 0.1) then
          Crosshair.y = Crosshair.OriginOffset.y / 2;
          Crosshair.rotation = 0;
        end
      end

      Crosshair.draw = function()
        love.graphics.draw(Crosshair.GFX, Crosshair.x, Crosshair.y, Crosshair.rotation, 1, 1, Crosshair.OriginOffset.x, Crosshair.OriginOffset.y);
      end

      Crosshair.GetNewYSpeed = function(aDeltaTime)
        if enabledDebug == true then Debug.ValidateXYPresence(Target, "GetNewYSpeed"); end
        return ((Crosshair.GetYDifferenceMultiplier()) * Crosshair.topSpeed) * aDeltaTime;
      end

      Crosshair.GetYDifferenceMultiplier = function()
        return Utils.RoundNumber(1 - (math.abs(Crosshair.centerY - SharpShooterGame.ScreenMidPoint.y) / (SharpShooterGame.ScreenMidPoint.y + SharpShooterGame.ScreenMidPoint.offset)), 2);
      end
  end

  function SharpShooterGame.update(dt)
    if (love.keyboard.isDown("escape")) then
      Utils.SwitchState(GameState.MainMenu);
    end

    if (SharpShooterGame.gameover == false) then
      if (love.keyboard.isDown("space") and SharpShooterGame.buttonPressed ~= true) then
        table.insert(SharpShooterGame.bulletHoles, SharpShooterGame.ShootBullet());
        SharpShooterGame.buttonPressed = true;
      elseif (true ~= love.keyboard.isDown("space")) then
        SharpShooterGame.buttonPressed = false;
      end

      if(SharpShooterGame.bulletCount == 0) then
        SharpShooterGame.endMessage = "PRESS ENTER TO PROCEED!";
        SharpShooterGame.Score.drawScale = 2;
        Target.x = -Target.GFX:getWidth();
        for key, value in pairs(SharpShooterGame.bulletHoles) do
          value.x = -SharpShooterGame.bulletGFX:getWidth();
        end
        Crosshair.x = -Crosshair.GFX:getWidth();
        SharpShooterGame.Score.x = SharpShooterGame.ScreenMidPoint.x - love.graphics.getFont():getWidth("Score: " .. SharpShooterGame.Score.currentScore);
        SharpShooterGame.Score.y = SharpShooterGame.ScreenMidPoint.y / 2;
        SharpShooterGame.bulletMessage = "";
        SharpShooterGame.bulletCount = "";
        GlobalScoreTable.SharpShooterGame.score = SharpShooterGame.Score.currentScore;
        SharpShooterGame.gameover = true;
      end

      Crosshair.update(dt);
    else

      if (love.keyboard.isDown("return")) then
        Utils.SwitchState(GameState.EndScreen);
      end
    end
  end

  function SharpShooterGame.draw()
    love.graphics.draw(SharpShooterGame.backgroundGFX, 0, 0);
    Target.draw();
    for key, value in pairs(SharpShooterGame.bulletHoles) do
      love.graphics.draw(SharpShooterGame.bulletGFX, value.x, value.y, 0, 1, 1, SharpShooterGame.bulletGFX:getWidth() / 2, SharpShooterGame.bulletGFX:getHeight() / 2);
    end
    Crosshair.draw();
    love.graphics.print("Score: " .. SharpShooterGame.Score.currentScore, SharpShooterGame.Score.x, SharpShooterGame.Score.y, 0, SharpShooterGame.Score.drawScale, SharpShooterGame.Score.drawScale);
    love.graphics.print(SharpShooterGame.bulletMessage .. SharpShooterGame.bulletCount, 10, 40);
    love.graphics.print(SharpShooterGame.endMessage, SharpShooterGame.ScreenMidPoint.x - love.graphics.getFont():getWidth(SharpShooterGame.endMessage), SharpShooterGame.ScreenMidPoint.y, 0, SharpShooterGame.Score.drawScale, SharpShooterGame.Score.drawScale);
  end

  function SharpShooterGame.ShootBullet()
    newBullet = {};
    newBullet.x = Crosshair.x;
    newBullet.y = Crosshair.y;

    SharpShooterGame.bulletCount = SharpShooterGame.bulletCount - 1;
    Crosshair.topSpeed = Crosshair.topSpeed + 100;

    local difference = math.abs(newBullet.y - SharpShooterGame.ScreenMidPoint.y);
    SharpShooterGame.Score.currentScore = SharpShooterGame.Score.currentScore + Utils.RoundNumber(Crosshair.GetYDifferenceMultiplier() * SharpShooterGame.Score.topScore, -2);
    return newBullet;
  end

  return SharpShooterGame;
end
