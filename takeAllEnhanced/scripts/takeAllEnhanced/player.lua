local I = require('openmw.interfaces')
local types = require('openmw.types')
local UI = require('openmw.interfaces').UI
local configPlayer = require('scripts.takeAllEnhanced.config.player')
local self = require('openmw.self')
local core = require('openmw.core')

local currentContainer = nil
local goldContainer = nil
local itemsContainer = nil
local ingredientsContainer = nil

function uiModeChanged(e)
	if e.newMode == I.UI.MODE.Container then
		currentContainer = e.arg
    containerInventory = types.Container.inventory(currentContainer)
	else
    currentContainer = nil
		goldContainer = nil
    itemsContainer = nil
    ingredientsContainer = nil
	end
end

function getAllContainerItems()
  itemsContainer = containerInventory:getAll()
end

function getAllContainerGold()
  goldContainer = containerInventory:findAll('gold_001')
end

function getAllContainerIngredients()
  ingredientsContainer = containerInventory:getAll(types.Ingredient)
end

function takeAllItemFromContainerThenCloseIt(container)
  if container ~= nil then
    for _, item in ipairs(container) do
      core.sendGlobalEvent("addItemInPlayerInventory",{item = item, player = self.object})    
    end
    self:sendEvent('SetUiMode', {})
  end
end

local function getContainersItem()
  getAllContainerGold()
  getAllContainerItems()
  getAllContainerIngredients()
end


local function checkEntryAndHandleTakeAll(code)
  if UI.getMode() ~= "Container" then
    return
  end
  getContainersItem()
  local keyForTakeAllItems = configPlayer.options.s_Key_All
  local keyForTakeAllGold = configPlayer.options.s_Key_Gold
  local keyForTakeAllIngredients = configPlayer.options.s_Key_Ingredients  
  if code == keyForTakeAllGold then
    takeAllItemFromContainerThenCloseIt(goldContainer)
  end
  
  if code == keyForTakeAllItems then
    takeAllItemFromContainerThenCloseIt(itemsContainer)
  end

  if code == keyForTakeAllIngredients then
    takeAllItemFromContainerThenCloseIt(ingredientsContainer)
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