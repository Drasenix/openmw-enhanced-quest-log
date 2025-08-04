local self = require("openmw.self")
local core = require("openmw.core")
local types = require("openmw.types")

local currentQuests = {}

function printQuests(quests)
  for id,quest in pairs(quests) do
      dialogueRecord = core.dialogue.journal.records[quest.id]
      print("found member " .. id .. " -- " .. tostring(quest) .. " stage = " .. quest.stage .. " finished = " .. tostring(quest.finished) .. " started = " .. tostring(quest.started) .. " quest name = " .. tostring(dialogueRecord.questName));
  end
end



local function getCurrentQuests()
  for id,quest in pairs(types.Player.quests(self)) do
    if quest.started and not quest.finished then
      table.insert(currentQuests, quest)
    end
  end
  printQuests(currentQuests)
end

getCurrentQuests()