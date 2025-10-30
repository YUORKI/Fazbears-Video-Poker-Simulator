local config = SMODS.current_mod.config
SMODS.current_mod.config_tab = function()

    local voice_toggle = create_toggle({
        label = localize('fnaf_va'),
        ref_table = config.voice
        ref_value = 'voices' -- what var does this button match
    })

    return {
        n = G.UIT.ROOT, 
        config = {
            r = 0.15 , 
            minw = 8 , 
            minh = 6 , 
            align = "tm", 
            padding = 0.1 , 
            colour = G.C.BLACK  -- this will define the background of the menu
        }, 
        nodes = {
            {
                n = G.UIT.C, 
                config = { 
                    r = 0.1 , 
                    minw = 7.5 , 
                    padding = 0.1 , 
                    align = "tl", 
                    colour = G.C.BLACK -- 
                }, 
                nodes = {
                    {
                        n = G.UIT.R, 
                        config = {
                            align = "tl", 
                            no_fill = true, 
                            padding = 0.1
                        }, 
                        nodes = {
                            voice_toggle, -- the option itself
                        }
                    },
                }
            },
        }
    }

end

