SprintGame = {};

function SprintGame.load()
  -- Variables
  SprintGame.PlayerScores = {playerOne = 0, playerTwo = 0};
  SprintGame.backgroundGFX = love.graphics.newImage("GFX/Backgrounds/SprintGame_main.png");
  SprintGame.Message = {};
  SprintGame.Message.text = "";
  SprintGame.Message.x = love.graphics.getWidth() / 2;
  SprintGame.Message.y = love.graphics.getHeight() / 5;
  SprintGame.instructions = "Press left arrow and right arrow to move!";
  SprintGame.winnerName = "";
  SprintGame.gameOver = false;
  SprintGame.startTime = love.timer.getTime();


  -- Countdown table for running the dountdown before our game begins
  CountDown = {};
    -- Variables
    CountDown.runningCountdown = true;
    CountDown.currentTime = 0;
    CountDown.topTime = 3.5;

    -- Functions
    CountDown.update = function()
      if(CountDown.currentTime - SprintGame.startTime <= CountDown.topTime - 1) then
        SprintGame.Message.text = tostring(math.floor(CountDown.topTime - (CountDown.currentTime - SprintGame.startTime)));
        CountDown.currentTime = love.timer.getTime();
      else
        SprintGame.Message.text = "GO!";
        CountDown.runningCountdown = false;
      end
    end

  -- Create local player and it's members
  Player = {};
    -- Variables
    Player.name = "player";
    Player.x = 50;
    Player.y = love.graphics.getHeight() - ((love.graphics.getHeight()/4) * 3);
    Player.GFX = love.graphics.newImage("GFX/Sprites/SprintGame_player.png");
    Player.width = Player.GFX:getWidth();
    Player.height = Player.GFX:getHeight();
    Player.switchKey = false;
    Player.buttonRight = "right";
    Player.buttonLeft = "left";
    Player.hasFinished = false;

    -- Functions
    Player.update = function()
      --[[ This veeeery big condition does two things, it makes sure that the player has to press the buttons interchangeably and it checks
      whether the previous button was released to prevent the player from simply holding down the two buttons and moving forward superfast. ]]--
      if (((Player.switchKey) and (love.keyboard.isDown(Player.buttonLeft) and not love.keyboard.isDown(Player.buttonRight))) or ((not Player.switchKey) and (love.keyboard.isDown(Player.buttonRight) and not love.keyboard.isDown(Player.buttonLeft)))) then
        Player.x = Player.x + 10;
        Player.switchKey = not Player.switchKey;
      end
    end

    Player.draw = function()
      love.graphics.draw(Player.GFX, Player.x, Player.y);
    end

  -- Create local opponent for player and it's members
  AIPlayer = {};
    -- Variables
    AIPlayer.name = "AI";
    AIPlayer.x = 50;
    AIPlayer.y = love.graphics.getHeight() - love.graphics.getHeight()/4;
    AIPlayer.GFX = love.graphics.newImage("GFX/Sprites/SprintGame_AI.png");
    AIPlayer.width = Player.GFX:getWidth();
    AIPlayer.height = Player.GFX:getHeight();
    AIPlayer.startTime = love.timer.getTime();
    AIPlayer.randomTime = love.math.random(0.1, 0.15);
    AIPlayer.hasFinished = false;

    -- Functions
    AIPlayer.update = function()
      if (love.timer.getTime() - AIPlayer.startTime >= AIPlayer.randomTime) then
        AIPlayer.x = AIPlayer.x + 10;
        AIPlayer.startTime = love.timer.getTime();
        AIPlayer.randomTime = love.math.random(0.1, 0.15);
      end
    end

    AIPlayer.draw = function()
      love.graphics.draw(AIPlayer.GFX, AIPlayer.x, AIPlayer.y)
    end
end

function SprintGame.update()
  if(love.keyboard.isDown("escape")) then
    Utils.SwitchState(GameState.MainMenu);
  end

  if(not SprintGame.gameOver and not CountDown.runningCountdown) then
    -- Run players update function
    if not Player.hasFinished then Player.update(); end

    -- Run AI's update function
    if not AIPlayer.hasFinished then AIPlayer.update(); end

    if (not Player.hasFinished and Player.x >= love.graphics.getWidth() - Player.width * 2) then
      SprintGame.PlayerScores.playerOne = love.timer.getTime() - SprintGame.startTime;
      Player.hasFinished = true;
    elseif (not AIPlayer.hasFinished and AIPlayer.x >= love.graphics.getWidth() - AIPlayer.width * 2) then
      SprintGame.PlayerScores.playerTwo = love.timer.getTime() - SprintGame.startTime;
      AIPlayer.hasFinished = true;
    end

    SprintGame.gameOver = (AIPlayer.hasFinished and Player.hasFinished);

    -- Check if there's a winner to be crowned!
    if (Player.hasFinished and not AIPlayer.hasFinished) then
      SprintGame.winnerName = Player.name;
    elseif (not Player.hasFinished and AIPlayer.hasFinished) then
      SprintGame.winnerName = AIPlayer.name;
    elseif (SprintGame.winnerName == "" and Player.hasFinished and AIPlayer.hasFinished) then
      SprintGame.winnerName = "Draw";
    end
  elseif (CountDown.runningCountdown) then
    CountDown.update();
  else
    SprintGame.Message.text = (((SprintGame.winnerName == Player.name) and "Congratulations " .. SprintGame.winnerName .. ", you won!" or "Looks like you lost... " .. SprintGame.winnerName .. " won this match.") .. "\n\n\nPlayer: " .. tostring(Utils.RoundNumber(SprintGame.PlayerScores.playerOne)) .. " seconds" .. "\n\n\nAI: " .. tostring(Utils.RoundNumber(SprintGame.PlayerScores.playerTwo)) .. " seconds");
  end
end

function SprintGame.draw()
  love.graphics.draw(SprintGame.backgroundGFX, 0, 0);
  love.graphics.print(SprintGame.instructions, 0, 0);
  love.graphics.printf(SprintGame.Message.text, SprintGame.Message.x - love.graphics.getFont():getWidth(SprintGame.Message.text) / 2, SprintGame.Message.y, 1000, "left");
  Player.draw();
  AIPlayer.draw();
end

function Utils.CurrentStateUnload()
  SprintGame = nil;
  CountDown = nil;
  Player = nil;
  AIPlayer = nil;
end
