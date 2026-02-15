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
        ref_value = 'volumes',
    })

    -- Save Override

    -- Freddy Fazbear

    local freddy_toggle = create_toggle({
        label = localize('fnaf_save_freddy'),
        ref_table = FNAF.config,
        juice = true,
        ref_value = 'freddyimport',
        callback = function()
            FNAF:save_config()
        end
    })

    -- Golden Freddy

    local golden_toggle = create_toggle({
        label = localize('fnaf_save_golden'),
        ref_table = FNAF.config,
        juice = true,
        ref_value = 'goldenimport',
        callback = function()
            FNAF:save_config()
        end
    })

    -- UI

    return {
        n = G.UIT.ROOT, config = { r = 0.15, minw = 15, minh = 7, align = "cm", padding = 0.01, colour = G.C.BLACK },
        nodes = {
            { n = G.UIT.R, config = { align = "tm" },
                nodes = {
                    voice_toggle, -- the option itself
                    voice_slider,
                }
            },

            { n = G.UIT.R, config = { align = "cm" }, nodes = {
                { n = G.UIT.B, config = { w = 0.5 , h = 0.5 , align = "cm", }}}
            },

            { n = G.UIT.R, config = { align = "cm", padding = 0.1 }, nodes = {
                    {n=G.UIT.T, config={text = localize('fnaf_save'), colour = G.C.UI.TEXT_LIGHT, scale = 0.5}},
                }
            },

            { n = G.UIT.R, config = { align = "cm" },nodes = {
                    { n = G.UIT.C, config = { align = "cl" },
                        nodes = {
                            freddy_toggle,
                        }
                    },
                    { n = G.UIT.C, config = { align = "cr" },
                        nodes = {
                            golden_toggle,
                        }
                    },
                }
            }
        }
    }

end