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
local booksContainer = nil
local scrollsContainer = nil
local weaponsContainer = nil
local miscellaneousContainer = nil
local lockpickContainer = nil
local probeContainer = nil
local potionContainer = nil
local repairContainer = nil
local clothingContainer = nil
local armorContainer = nil
local apparatusContainer = nil
local lightContainer = nil

function uiModeChanged(e)
	if e.newMode == I.UI.MODE.Container then
		currentContainer = e.arg
    containerInventory = types.Container.inventory(currentContainer)
	else
    currentContainer = nil
		goldContainer = nil
    itemsContainer = nil
    ingredientsContainer = nil
    booksContainer = nil
    scrollsContainer = nil
    weaponsContainer = nil
    miscellaneousContainer = nil
    lockpickContainer = nil
    probeContainer = nil
    potionContainer = nil
    repairContainer = nil
    clothingContainer = nil
    armorContainer = nil
    apparatusContainer = nil
    lightContainer = nil
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

function getAllContainerBooks()
  booksContainer = containerInventory:getAll(types.Books)
end

function getAllContainerScrolls()
  scrollsContainer = containerInventory:getAll(types.Scrolls)
end

function getAllContainerWeapons()
  weaponsContainer = containerInventory:getAll(types.Weapons)
end

function getAllContainerMiscellaneous()
  miscellaneousContainer = containerInventory:getAll(types.Miscellaneous)
end

function getAllContainerLockpick()
  lockpickContainer = containerInventory:getAll(types.Lockpick)
end

function getAllContainerProbe()
  probeContainer = containerInventory:getAll(types.Probe)
end

function getAllContainerPotion()
  potionContainer = containerInventory:getAll(types.Potion)
end

function getAllContainerRepair()
  repairContainer = containerInventory:getAll(types.Repair)
end

function getAllContainerClothing()
  clothingContainer = containerInventory:getAll(types.Clothing)
end

function getAllContainerArmor()
  armorContainer = containerInventory:getAll(types.Armor)
end

function getAllContainerApparatus()
  apparatusContainer = containerInventory:getAll(types.Apparatus)
end

function getAllContainerLight()
  lightContainer = containerInventory:getAll(types.Light)
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
  getAllContainerBooks()
  getAllContainerScrolls()
  getAllContainerWeapons()
  getAllContainerMiscellaneous()
  getAllContainerLockpick()
  getAllContainerProbe()
  getAllContainerPotion()
  getAllContainerRepair()
  getAllContainerClothing()
  getAllContainerArmor()
  getAllContainerApparatus()
  getAllContainerLight()
end


local function checkEntryAndHandleTakeAll(code)
  if UI.getMode() ~= "Container" then
    return
  end
  getContainersItem()
  local keyForTakeAllItems = configPlayer.options.s_Key_All
  local keyForTakeAllGold = configPlayer.options.s_Key_Gold
  local keyForTakeAllIngredients = configPlayer.options.s_Key_Ingredients
  local keyForTakeAllBooks = configPlayer.options.s_Key_Books
  local keyForTakeAllScrolls = configPlayer.options.s_Key_Scrolls
  local keyForTakeAllWeapons = configPlayer.options.s_Key_Weapons
  local keyForTakeAllMiscellaneous = configPlayer.options.s_Key_Miscellaneous
  local keyForTakeAllLockpick = configPlayer.options.s_Key_Lockpick
  local keyForTakeAllProbe = configPlayer.options.s_Key_Probe
  local keyForTakeAllPotion = configPlayer.options.s_Key_Potion
  local keyForTakeAllRepair = configPlayer.options.s_Key_Repair
  local keyForTakeAllClothing = configPlayer.options.s_Key_Clothing
  local keyForTakeAllArmor = configPlayer.options.s_Key_Armor
  local keyForTakeAllApparatus = configPlayer.options.s_Key_Apparatus
  local keyForTakeAllLight = configPlayer.options.s_Key_Light
  
  if code == keyForTakeAllGold then
    takeAllItemFromContainerThenCloseIt(goldContainer)
  end
  
  if code == keyForTakeAllItems then
    takeAllItemFromContainerThenCloseIt(itemsContainer)
  end

  if code == keyForTakeAllIngredients then
    takeAllItemFromContainerThenCloseIt(ingredientsContainer)
  end

  if code == keyForTakeAllBooks then
    takeAllItemFromContainerThenCloseIt(booksContainer)
  end

  if code == keyForTakeAllScrolls then
    takeAllItemFromContainerThenCloseIt(scrollsContainer)
  end

  if code == keyForTakeAllWeapons then
    takeAllItemFromContainerThenCloseIt(weaponsContainer)
  end

  if code == keyForTakeAllMiscellaneous then
    takeAllItemFromContainerThenCloseIt(miscellaneousContainer)
  end

  if code == keyForTakeAllLockpick then
    takeAllItemFromContainerThenCloseIt(lockpickContainer)
  end

  if code == keyForTakeAllProbe then
    takeAllItemFromContainerThenCloseIt(probeContainer)
  end

  if code == keyForTakeAllPotion then
    takeAllItemFromContainerThenCloseIt(potionContainer)
  end

  if code == keyForTakeAllRepair then
    takeAllItemFromContainerThenCloseIt(repairContainer)
  end

  if code == keyForTakeAllClothing then
    takeAllItemFromContainerThenCloseIt(clothingContainer)
  end

  if code == keyForTakeAllArmor then
    takeAllItemFromContainerThenCloseIt(armorContainer)
  end

  if code == keyForTakeAllApparatus then
    takeAllItemFromContainerThenCloseIt(apparatusContainer)
  end

  if code == keyForTakeAllLight then
    takeAllItemFromContainerThenCloseIt(lightContainer)
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