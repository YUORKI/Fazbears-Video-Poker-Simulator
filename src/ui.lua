FNAF_BALATRO.save_config = function(self)
    SMODS.save_mod_config(self)
end

G.SETTINGS.SOUND.volumes = G.SETTINGS.SOUND.volumes or 100

local config = SMODS.current_mod.config
SMODS.current_mod.config_tab = function()

    local voice_toggle = create_toggle({
        label = localize('fnaf_va'),
        ref_table = FNAF_BALATRO.config,
        juice = true,
        ref_value = 'voices', -- what var does this button match
        callback = function()
            FNAF_BALATRO:save_config()
        end
    })

    local voice_slider = create_slider({
        label = localize('fnaf_va_volumeslider'),
        min = 0,
        max = 100,
        step = 1,
        w = 5,
        h = 0.5,
        ref_table = G.SETTINGS.SOUND,
        ref_value = 'volumes' or 100,
    })

    -- Save Override

    -- Freddy Fazbear

    local freddy_toggle = create_toggle({
        label = localize('fnaf_save_freddy'),
        ref_table = FNAF_BALATRO.config,
        juice = true,
        ref_value = 'freddyimport',
        callback = function()
            FNAF_BALATRO:save_config()
        end
    })

    -- Golden Freddy

    local golden_toggle = create_toggle({
        label = localize('fnaf_save_golden'),
        ref_table = FNAF_BALATRO.config,
        juice = true,
        ref_value = 'goldenimport',
        callback = function()
            FNAF_BALATRO:save_config()
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

local ref_can_buy = G.FUNCS.can_buy_and_use
G.FUNCS.can_buy_and_use = function(e)
    local ret = ref_can_buy(e)
    if e.config.ref_table.ability.set == 'fnaf_remnant' then
        e.UIBox.states.visible = false
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
    return ret
end

-- Modified Code from Malverk
local ref_use_sell_buttons = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
    if card.ability.set == "fnaf_remnant" then
        if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then --Add a use button
            use = {n=G.UIT.R, config={align = 'cm'}, nodes={
                {n=G.UIT.C, config={align = "cm"}, nodes={
                    {n=G.UIT.C, config={align = "bm", maxw = G.CARD_W * 0.65, shadow = true, padding = 0.1, r=0.08, minw = 0.5 * G.CARD_W, minh = 0.8, hover = true, colour = G.C.GREEN, button = "use_card", func = "can_select_from_booster", ref_table = card}, nodes={
                        {n=G.UIT.T, config={text = localize('b_select'), colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true}}
                    }}
                }}
            }}
            local t = {n=G.UIT.ROOT, config = {align = 'cm', padding = 0, colour = G.C.CLEAR}, nodes={
                {n=G.UIT.C, config={align = 'cm'}, nodes={
                    use,
                }},
            }}
            return t
        end
    end
    return ref_use_sell_buttons(card)
end
