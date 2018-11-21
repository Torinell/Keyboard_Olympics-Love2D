require "Utils"
require "Debug"
require "MainMenu"
require "SprintGame"
require "SharpShooterGame"
require "EndScreen"


function love.load()
  love.graphics.setNewFont("OXFORD.TTF", 20);
  enabledDebug = true;
  GameState = {MainMenu="MainMenu", SprintGame="SprintGame", SharpShooterGame="SharpShooterGame", EndScreen="EndScreen"};
  currentState = {};
  Utils.SwitchState(GameState.MainMenu);
end

function love.update(dt)
  currentState.update(dt);
end

function love.draw()
  currentState.draw();
end
