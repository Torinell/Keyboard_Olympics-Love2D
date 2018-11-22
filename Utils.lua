Utils = {};

function Utils.ValueExists(aTable, aSearchValue)
  for key, value in pairs(aTable) do
    if(value == aSearchValue) then
      return true;
    end
  end
  return false;
end


function Utils.MouseCollisionCheck(anObject, someXOffset, someYOffset)
  if enabledDebug then Debug.ValidateCollidable(anObject, "CollisionCheck"); end
  someXOffset = someXOffset or 0;
  someYOffset = someYOffset or 0;

  mouseX, mouseY = love.mouse.getPosition();
  if (--[[Check for collision in X axis]] (anObject.x + someXOffset) < mouseX and mouseX < ((anObject.x + someXOffset) + anObject.width))
  and (--[[Check for collision in Y axis]] (anObject.y + someYOffset) < mouseY and mouseY < ((anObject.y + someYOffset) + anObject.height)) then
    return true;
  end

  return false;
end

function Utils.SwitchState(aGameState)
  if enabledDebug then assert(Utils.ValueExists(GameState, aGameState), "The Gamestate \"".. aGameState .."\" doesn't exist!") end

  Utils.UnloadCurrentState();
  collectgarbage();

  if aGameState == GameState.MainMenu then
    MainMenu.load();
    currentState = MainMenu;
  elseif aGameState == GameState.SprintGame then
    SprintGame.load();
    currentState = SprintGame;
  elseif aGameState == GameState.SharpShooterGame then
    SharpShooterGame.load();
    currentState = SharpShooterGame;
  elseif aGameState == GameState.EndScreen then
    EndScreen.load();
    currentState = EndScreen;
  end
end

function Utils.RoundNumber(aNumber)
  return aNumber % 1 >= 0.5 and math.ceil(aNumber) or math.floor(aNumber);
end

function Utils.GetPointDistance(aPoint, aSecondPoint)
  return ( + math.pow(aSecondPoint.x, 2))
end

function Utils.UnloadCurrentState()
  -- This function is defined in individual states to unload state variables and functions related to that state
end
