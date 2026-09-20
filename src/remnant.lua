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

    primary_colour = HEX('FF535353'),
    secondary_colour = HEX('FF535353'),
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
    config = { extra = { chips = 20, runtime = 3, uses = 0, } },
    activated = false,
    destroyed = false,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if card.ability.activated and context.other_joker and
        context.other_joker.config.center.fnaf_type == 'Animatronic' then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,

    can_use = function(self, card)
        if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or
        card.area == G.consumeables then
            return true
        end
    end
}