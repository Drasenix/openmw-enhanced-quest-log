local types = require("openmw.types")
local core = require('openmw.core')

return {
    eventHandlers = {
        addItemInPlayerInventory = function(data)
            data.item:moveInto(types.Actor.inventory(data.player))
        end,
        playSound = function(data)
            core.sound.playSound3d("chest close", data.player)       
        end       
    },
}