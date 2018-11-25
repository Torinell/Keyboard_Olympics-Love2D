function CreateEndScreen()
  EndScreen = {}

  function EndScreen.load()
    EndScreen.GFX = nil;
    EndScreen.Message = {};
    EndScreen.Message.text = "SprintGame\n\n\n\n" .. GlobalScoreTable.SprintGame.winnerName .. " was the winner, players time: " .. Utils.RoundNumber(GlobalScoreTable.SprintGame.playerTime, 2) .. "\n\n\n" ..
    "\n\n\n" .. "SharpShooterGame\n\n\n\n" .. "Players score: " .. GlobalScoreTable.SharpShooterGame.score;
    EndScreen.Message.x = love.graphics.getWidth() / 2 - 200;
    EndScreen.Message.y = love.graphics.getHeight() / 2 - 200;
    EndScreen.textScale = 1.1;
    EndScreen.ReturnButton = {};
    EndScreen.ReturnButton.text = "Go back to main main menu"
    EndScreen.ReturnButton.x = love.graphics.getWidth() / 2;
    EndScreen.ReturnButton.y = love.graphics.getHeight() / 2;
    EndScreen.ReturnButton.width = love.graphics.getFont():getWidth(EndScreen.ReturnButton.text) * EndScreen.textScale;
    EndScreen.ReturnButton.height = love.graphics.getFont():getHeight() + 50;
  end

  function EndScreen.update()
    if(love.mouse.isDown(1)) then
      if(Utils.MouseCollisionCheck(EndScreen.ReturnButton)) then
        GlobalScoreTable = nil;
        GlobalScoreTable = {};
        Utils.SwitchState(GameState.MainMenu);
      end
    end
  end

  function EndScreen.draw()
    love.graphics.printf(EndScreen.Message.text, EndScreen.Message.x, EndScreen.Message.y, 10000, "left", 0, EndScreen.textScale, EndScreen.textScale);
    love.graphics.print(EndScreen.ReturnButton.text, EndScreen.ReturnButton.x, EndScreen.ReturnButton.y, 0, EndScreen.textScale, EndScreen.textScale);
  end

  return EndScreen
end
