

SMODS.Consumable {
    key = 'rabbit',
    set = "Tarot",
    atlas = 'TarotFnaf',
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 1, mod_conv = 'm_fnaf_glitch' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,

}

SMODS.Consumable {
    key = 'kid',
    set = "Tarot",
    atlas = 'TarotFnaf',
    pos = { x = 1, y = 0 },
    config = { max_highlighted = 1, mod_conv = 'm_fnaf_kid' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,

}