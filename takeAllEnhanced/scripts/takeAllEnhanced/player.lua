local I = require('openmw.interfaces')
local types = require('openmw.types')
local UI = require('openmw.interfaces').UI
local configPlayer = require('scripts.takeAllEnhanced.config.player')
local self = require('openmw.self')

local currentContainer = nil
local goldContainer = nil
function uiModeChanged(e)
	if e.newMode == I.UI.MODE.Container then
		currentContainer = e.arg
    getAllContainerGold()
	else
    currentContainer = nil
		goldContainer = nil
	end
end

function getAllContainerGold()
  containerInventory = types.Container.inventory(currentContainer)
  goldContainer = containerInventory:findAll('gold_001')
  return
end

function moveGoldFromContainerInventoryToPlayerInventory()
  for _, item in ipairs(goldContainer) do
    print(item.id)
    item:moveInto(types.Actor.inventory(self.object))
  end
  return
end

local function onKeyRelease(key)
  local keyForTakeAllGold = configPlayer.options.s_Key_Gold
  if UI.getMode() ~= "Container" then
    return
  end
  if key.code == keyForTakeAllGold then
    moveGoldFromContainerInventoryToPlayerInventory()
  end
end

local function onMouseButtonPress(button)
  local clickForTakeAllGold = configPlayer.options.s_Key_Gold
  if UI.getMode() ~= "Container" then
    return
  end
  if button == clickForTakeAllGold then
    moveGoldFromContainerInventoryToPlayerInventory()
  end
end

return {
	eventHandlers = {
		UiModeChanged = uiModeChanged
	},
  engineHandlers = {
      onKeyRelease = onKeyRelease,
      onMouseButtonPress = onMouseButtonPress,
  }
}