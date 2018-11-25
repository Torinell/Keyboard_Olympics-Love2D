Debug = {};

function Debug.ValidateXYPresence(anObject, anErrorPrefix)
  anErrorPrefix = '(' .. anErrorPrefix .. ") "
  assert(anObject.x ~= nil,       anErrorPrefix .. "Object is missing X value!")
  assert(anObject.y ~= nil,       anErrorPrefix .. "Object is missing Y value!")
end

function Debug.ValidateCollidable(anObject, anErrorPrefix)
  anErrorPrefix = '(' .. anErrorPrefix .. ") "
  assert(anObject.x ~= nil,       anErrorPrefix .. "Object is missing X value!")
  assert(anObject.y ~= nil,       anErrorPrefix .. "Object is missing Y value!")
  assert(anObject.width ~= nil,   anErrorPrefix .. "Object is missing width value!")
  assert(anObject.height ~= nil,  anErrorPrefix .. "Object is missing height value!")
end

function Debug.ValidateDrawable(anObject, anErrorPrefix)
  anErrorPrefix = '(' .. anErrorPrefix .. ')'
  assert(anObject.x ~= nil,                               anErrorPrefix .. "Object is missing X value!")
  assert(anObject.y ~= nil,                               anErrorPrefix .. "Object is missing Y value!")
  assert(anObject.GFX or anObject.Text or anObject.Name,  anErrorPrefix .. "Object is missing Drawable type!")
end

function Debug.ConditionalBreakpoint(aTriggerButton)
  aTriggerButton = aTriggerButton or 'd';

  if(love.keyboard.isDown(aTriggerButton)) then
    debug.debug();
  end
end

function Debug.KeysExist(aTable, searchKeys)
  local foundKey = {};
  for key,value in pairs(searchKey) do
    if aTable[searchKey] ~= nil then table.insert(true); end
  end
  return false;
end
