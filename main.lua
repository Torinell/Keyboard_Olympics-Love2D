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
  currentState = "";
  Utils.SwitchState(GameState.MainMenu);
end

function love.update(dt)
  if currentState == GameState.MainMenu then
    MainMenu.update(dt);
  elseif currentState == GameState.SprintGame then
    SprintGame.update(dt);
  elseif currentState == GameState.SharpShooterGame then
    SharpShooterGame.update(dt);
  elseif currentState == GameState.EndScreen then
    EndScreen.update(dt);
  end
end

function love.draw()
  if currentState == GameState.MainMenu then
    MainMenu.draw();
  elseif currentState == GameState.SprintGame then
    SprintGame.draw();
  elseif currentState == GameState.SharpShooterGame then
    SharpShooterGame.draw();
  elseif currentState == GameState.EndScreen then
    EndScreen.draw();
  end
end
