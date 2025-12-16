FNAF = SMODS.current_mod
FNAF.save_config = function(self)
    SMODS.save_mod_config(self)
end

local config = SMODS.current_mod.config
SMODS.current_mod.config_tab = function()

    local voice_toggle = create_toggle({
        label = localize('fnaf_va'),
        ref_table = FNAF.config,
        juice = true,
        ref_value = 'voices', -- what var does this button match
        callback = function()
            FNAF:save_config()
        end
    })

    local voice_slider = create_slider({
        label = localize('fnaf_va_volumeslider'),
        min = 0,
        max = 100,
        step = 1,
        w = 5,
        ref_table = FNAF.config,
        ref_value = 'volumes', -- what var does this button match
    })

    return {
        n = G.UIT.ROOT, 
        config = {
            r = 0.15 , 
            minw = 8 , 
            minh = 6 , 
            align = "cm", 
            padding = 0.1 , 
            colour = G.C.BLACK  -- this will define the background of the menu
        }, 
        nodes = {
            voice_toggle, -- the option itself
            voice_slider,
        }
    }

end