function CreateMainMenu()
  MainMenu = {};

  function MainMenu.load()
    local yOffset = 0;
    local yHeight = 15;
    local function GetYOffset(offset)
      yOffset = yOffset + offset;
      return yOffset;
    end

    MainMenu.Buttons =
    {
      Start =             {x = love.graphics.getWidth()/2, y = GetYOffset(100), width = 0, height = yHeight, OnPressed = function() Utils.SwitchState(GameState.SprintGame);       end, Name = "Start"},
      -- SprintGame =        {x = love.graphics.getWidth()/2, y = GetYOffset(50),  width = 0, height = yHeight, OnPressed = function() Utils.SwitchState(GameState.SprintGame);       end, Name = "Sprint Game"},
      -- SharpShooterGame =  {x = love.graphics.getWidth()/2, y = GetYOffset(50),  width = 0, height = yHeight, OnPressed = function() Utils.SwitchState(GameState.SharpShooterGame); end, Name = "Sharp Shooter Game"},
      Quit =              {x = love.graphics.getWidth()/2, y = GetYOffset(50),  width = 0, height = yHeight, OnPressed = function() love.event.quit()                              end, Name = "Quit"}
    };

    for key, value in pairs(MainMenu.Buttons) do
      value.width = love.graphics.getFont():getWidth(value.Name);
      value.x = value.x - value.width/2;
    end
  end

  function MainMenu.update(dt)
    if (love.mouse.isDown(1)) then
      for key, button in pairs(MainMenu.Buttons) do
        if (Utils.MouseCollisionCheck(button)) then
          button.OnPressed();
        end
      end
    end
  end

  function MainMenu.draw()
    for key, value in pairs(MainMenu.Buttons) do
      love.graphics.print(value.Name, value.x, value.y)
    end
  end
  return MainMenu;
end
