---@diagnostic disable: undefined-global

SMODS.Enhancement {
    key = 'pizza',
    atlas = 'Enhancers',
    pos = { x = 0, y = 0 },
    config = { bonus = 200, extra = {hands_left = 5}},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    shatters = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.bonus, card.ability.extra.hands_left} }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if card.ability.extra.hands_left > 0 then
                card.ability.extra.hands_left = card.ability.extra.hands_left - 1
            elseif card.ability.extra.hands_left <= 0 then
                SMODS.debuff_card(card, true, 'source')
                return { message = 'Expired' }
            end
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        if next(SMODS.find_card('j_fnaf_rock_chica')) then
            card.ability.extra.hands_left = 15
        end
    end
}


SMODS.Enhancement {
    key = 'glitch',
    atlas = 'Enhancers',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 1, y = 0 },
    config = { extra = { max = 15, min = 0 } },
    loc_vars = function(self, info_queue, card)
        local r_mults = {}
        for i = card.ability.extra.min, card.ability.extra.max do
            r_mults[#r_mults + 1] = tostring(i)
        end
        local loc_mult = ' ' .. (localize('k_mult')) .. ' '
        main_start = {
            { n = G.UIT.T, config = { text = '  +', colour = G.C.MULT, scale = 0.32 } },
            { n = G.UIT.O, config = { object = DynaText({ string = r_mults, colours = { G.C.RED }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {
                            { string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11) .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1) or 'D'), colour = G.C.RED },
                            loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
                            loc_mult, loc_mult, loc_mult, loc_mult },
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.2011,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                }
            },
        }
        return { main_start = main_start }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                mult = pseudorandom('fnaf_glitch', card.ability.extra.min, card.ability.extra.max)
            }
        end
    end

}

SMODS.Enhancement {
    key = 'kid',
    pos = { x = 1, y = 0 },
    display_size = { w = 71 * 0.7, h = 95 * 0.7 },
    config = { x_chips = 1.2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.x_chips } }
    end,

}
