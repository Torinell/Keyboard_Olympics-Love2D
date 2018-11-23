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
  Debug.Breakpoint();
  if aGameState == GameState.MainMenu then
    currentState = CreateMainMenu();
  elseif aGameState == GameState.SprintGame then
    currentState = CreateNewSprintGame();
  elseif aGameState == GameState.SharpShooterGame then
    currentState = CreateNewSharpShooterGame();
  elseif aGameState == GameState.EndScreen then
    currentState = CreateEndScreen();
  end
  currentState.load();
end

function Utils.RoundNumber(aNumber)
  return aNumber % 1 >= 0.5 and math.ceil(aNumber) or math.floor(aNumber);
end

function Utils.GetPointDistance(aPoint, aSecondPoint)
  return (((aPoint.x)*(aPoint.x)) + ((aSecondPoint.x)*(aSecondPoint.y)))
end
