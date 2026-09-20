---@diagnostic disable: undefined-global
SMODS.ConsumableType {
    key = 'fnaf_remnant',

    loc_txt = {
        collection = 'Remnant Cards',
        name = 'Remnant',
        undiscovered = {
            name = 'Not Discovered',
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
            },
        },
    },

    pools = {
 		['fnaf_remnant'] = true,
 	},

    default = "c_fnaf_meltedhead",

    primary_colour = G.C.REMN,
    secondary_colour = G.C.REMN,
    collection_rows = { 6, 6 },
    stack = false,
    divide = false,

    shop_rate = 2
}

SMODS.UndiscoveredSprite{
    key = 'fnaf_item',
    atlas = 'TarotFnaf',
    pos = {x = 0, y = 2}
}

SMODS.Consumable{
    key = 'meltedhead',
    set = 'fnaf_remnant',
    atlas = 'TarotFnaf',
    pos = {x = 2, y = 1},
    config = { extra = { chips = 20, usages = 3, uses = 0, } },
    activated = false,
    destroyed = false,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.usages, card.ability.extra.uses } }
    end,

    calculate = function(self, card, context)
        if card.ability.activated and context.other_joker and
        context.other_joker.config.center.fnaf_type == 'Animatronic' then
            return {
                chips = card.ability.extra.chips,
            }
        end
        local bad_context = context.repetition or context.individual or context.blueprint
        if context.after and not card.ability.destroyed and card.ability.activated and not bad_context then
            local uses = card.ability.extra.uses
            FNAF_BALATRO.fnaf_remnant.run_remn(card, uses)
        end
    end,

    can_use = function(self, card)
        if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or
        card.area == G.consumeables then
            return true
        end
    end
}