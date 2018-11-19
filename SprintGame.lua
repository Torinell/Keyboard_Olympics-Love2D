SprintGame = {};

function SprintGame.load()
  -- Variables
  SprintGame.PlayerScores = {playerOne = 0, playerTwo = 0};
  SprintGame.backgroundGFX = love.graphics.newImage("GFX/Backgrounds/SprintGame_main.jpg");
  SprintGame.message = "";
  SprintGame.x = love.graphics.getWidth() / 2;
  SprintGame.y = love.graphics.getHeight() / 4;
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
        SprintGame.message = tostring(math.floor(CountDown.topTime - (CountDown.currentTime - SprintGame.startTime)));
        CountDown.currentTime = love.timer.getTime();
      else
        SprintGame.message = "GO!";
        CountDown.runningCountdown = false;
      end
    end

  -- Create local player and it's members
  Player = {};
    -- Variables
    Player.x = 50;
    Player.y = love.graphics.getHeight() - love.graphics.getHeight()/4 * 3;
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
    AIPlayer.x = 50;
    AIPlayer.y = love.graphics.getHeight() - love.graphics.getHeight()/4;
end

function SprintGame.update()
  if(not SprintGame.gameOver and not CountDown.runningCountdown) then
    -- Run players update function
     if not Player.hasFinished then Player.update(); end

    -- Run AI's update function
    AIPlayer.update();

    -- Check if there's a winner to be crowned!
    if (not Player.hasFinished and Player.x >= love.graphics.getWidth() - Player.width * 2) then
      SprintGame.PlayerScores.playerOne = SprintGame.startTime - love.timer.getTime();
      Player.hasFinished = true;
    elseif (not AIPlayer.hasFinished and AIPlayer.x >= love.graphics.getWidth() - AIPlayer.width * 2) then
      SprintGame.PlayerScores.playerTwo = SprintGame.startTime - love.timer.getTime();
      AIPlayer.hasFinished = true;
    end

    SprintGame.gameOver = (AIPlayer.hasFinished and Player.hasFinished);

    if (Player.hasFinished and not AIPlayer.hasFinished) then
      SprintGame.winnerName = "Player";
    elseif (not Player.hasFinished and AIPlayer.hasFinished) then
      SprintGame.winnerName = "AI";
    end

  elseif (CountDown.runningCountdown) then
    CountDown.update();
  else
    SprintGame.message = "Congratulations " .. SprintGame.winnerName .. " you won!\n";--.. "Player: " .. SprintGame.startTime - SprintGame.PlayerScores.playerOne - CountDown.topTime;
  end
end

function SprintGame.draw()
  love.graphics.draw(SprintGame.backgroundGFX, 0, 0);
  love.graphics.print(SprintGame.message, SprintGame.x - love.graphics.getFont():getWidth(SprintGame.message) / 2, SprintGame.y);
  Player.draw();
end

function Utils.CurrentStateUnload()
  SprintGame = nil;
  Player = nil;
  AIPlayer = nil;
end
