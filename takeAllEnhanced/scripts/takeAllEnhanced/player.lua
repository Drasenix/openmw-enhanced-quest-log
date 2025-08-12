local I = require('openmw.interfaces')
local types = require('openmw.types')
local UI = require('openmw.interfaces').UI
local configPlayer = require('scripts.takeAllEnhanced.config.player')
local self = require('openmw.self')
local core = require('openmw.core')

local currentContainer = nil
local goldContainer = nil
local itemsContainer = nil

function uiModeChanged(e)
	if e.newMode == I.UI.MODE.Container then
		currentContainer = e.arg
    containerInventory = types.Container.inventory(currentContainer)
    getAllContainerGold()
    getAllContainerItems()
	else
    currentContainer = nil
		goldContainer = nil
    itemsContainer = nil
	end
end

function getAllContainerItems()
  itemsContainer = containerInventory:getAll()
end

function getAllContainerGold()
  goldContainer = containerInventory:findAll('gold_001')
end

function takeAllItemFromContainerThenCloseIt(container)
  if container ~= nil then
    for _, item in ipairs(container) do
      core.sendGlobalEvent("addItemInPlayerInventory",{item = item, player = self.object})    
    end
    self:sendEvent('SetUiMode', {})
  end
end

local function checkEntryAndHandleTakeAll(code)
  local keyForTakeAllItems = configPlayer.options.s_Key_All
  local keyForTakeAllGold = configPlayer.options.s_Key_Gold
  if UI.getMode() ~= "Container" then
    return
  end
  if code == keyForTakeAllGold then
    takeAllItemFromContainerThenCloseIt(goldContainer)
    return
  end
  
  if code == keyForTakeAllItems then
    takeAllItemFromContainerThenCloseIt(itemsContainer)
    return
  end

end

local function onKeyRelease(key)
  checkEntryAndHandleTakeAll(key.code)  
end

local function onMouseButtonPress(button)
  checkEntryAndHandleTakeAll(button)
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