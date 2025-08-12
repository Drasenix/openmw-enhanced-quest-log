local core = require('openmw.core')
local I = require('openmw.interfaces')
local input = require('openmw.input')
local ui = require('openmw.ui')
local util = require('openmw.util')
local async = require('openmw.async')
local l10n = core.l10n('TakeAllEnhanced')
local versionString = "1.0.0"

-- inputSelection inspired by Pharis
I.Settings.registerRenderer(
    "inputSelection",
	function(value, set)
        local interval = {
            type = ui.TYPE.Widget,
            template = I.MWUI.templates.interval
        }
		local name = "No Key Set"
		if value then
            if value == 1 then
                name = "Left Click"
            elseif value == 2 then
                name = "Middle Click"
            elseif value == 3 then
                name = "Right Click"
            else
                name = input.getKeyName(value)
            end
		end
		return {
            type = ui.TYPE.Flex,
            props = {
                horizontal = true
            },
			content = ui.content {
                {
                    type = ui.TYPE.Container,
                    template = I.MWUI.templates.box,
                    content = ui.content {
                        {
                            template = I.MWUI.templates.textEditLine,
                            props = {
                                text = name,
                            },
                            events = {
                                keyPress = async:callback(function(e)
                                    if e.code == input.KEY.Escape then return end
                                    set(e.code)
                                end),
                            },
                        },                                                                        
                    }
                },
                interval,
                interval,
                interval,
                {
                    type = ui.TYPE.Container,
                    template = I.MWUI.templates.box,
                    content = ui.content {
                        {
                            template = I.MWUI.templates.textNormal,
                            props = {
                                text = " Tab ",
                            },
                            events = {
                                mousePress = async:callback(function(e)
                                    set(input.KEY.Tab)
                                end),
                            },
                        }				
                    }
                },
                interval,
                interval,
                interval,
                {
                    type = ui.TYPE.Container,
                    template = I.MWUI.templates.box,
                    content = ui.content {
                        {
                            template = I.MWUI.templates.textNormal,
                            props = {
                                text = " Left Click ",
                            },
                            events = {
                                mousePress = async:callback(function(e)
                                    set(1)
                                end),
                            },
                        }				
                    }
                },
                interval,
                interval,
                interval,
                {
                    type = ui.TYPE.Container,
                    template = I.MWUI.templates.box,
                    content = ui.content {
                        {
                            template = I.MWUI.templates.textNormal,
                            props = {
                                text = " Middle Click ",
                            },
                            events = {
                                mousePress = async:callback(function(e)
                                    set(2)
                                end),
                            },
                        }				
                    }
                },
                interval,
                interval,
                interval,              
                {
                    type = ui.TYPE.Container,
                    template = I.MWUI.templates.box,
                    content = ui.content {
                        {
                            template = I.MWUI.templates.textNormal,
                            props = {
                                text = " Right Click ",
                            },
                            events = {
                                mousePress = async:callback(function(e)
                                    set(3)
                                end),
                            },
                        }				
                    }
                },
			},            
		}
	end
)

-- Settings page
I.Settings.registerPage {
    key = 'TakeAllEnhanced',
    l10n = 'TakeAllEnhanced',
    name = 'ConfigTitle',
    description = l10n('ConfigSummary'):gsub('%%{version}', versionString),
}

I.Settings.registerGroup {
    key = 'Settings/TakeAllEnhanced/KeyBindings/Config',
    page = 'TakeAllEnhanced',
    l10n = 'TakeAllEnhanced',
    name = 'ConfigKeybindings',
    description = "ConfigKeybindingsDesc",
    permanentStorage = true,
    settings = {        
        {
            key = 's_Key_All',
            renderer = 'inputSelection',            
            name = 'Key_All',
            description = 'All',
            default = 0,
        },
        {
            key = 's_Key_Gold',
            renderer = 'inputSelection',            
            name = 'Key_Gold',
            description = 'Gold',
            default = 0,
        },
    },
}