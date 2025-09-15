---@diagnostic disable: undefined-global
SMODS.Seal {
    key = 'security',
    atlas = 'Enhancers',
    pos = { x = 5, y = 0 },
    badge_colour = G.C.GREEN,
    loc_vars = function(self, info_queue, card)
    end,
}

SMODS.Seal {
    key = 'guard',
    atlas = 'Enhancers',
    pos = { x = 3, y = 0 },
    badge_colour = G.C.GOLD,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "fnaf_sprite_WIP", set = "Other"}
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    SMODS.add_card({ set = 'fnaf_item' })
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return { message = "+1 Item", colour = HEX('bea233') }
        end
    end
}

SMODS.current_mod.set_debuff = function(card)
    if card.seal == "fnaf_security" then
        return "prevent_debuff"
    end
end
