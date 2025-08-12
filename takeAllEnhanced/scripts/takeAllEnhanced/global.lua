local types = require("openmw.types")

return {
    eventHandlers = {
        addItemInPlayerInventory = function(data)
            data.item:moveInto(types.Actor.inventory(data.player))
        end        
    },
}