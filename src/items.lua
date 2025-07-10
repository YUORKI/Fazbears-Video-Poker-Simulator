SMODS.ConsumableType {
    key = 'fnaf_item',

    loc_txt = {
        collection = 'Item Cards', 
        name = 'Item',
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
 		['fnaf_item'] = true,
 	},

    default = "c_fnaf_pizza_maker",

    primary_colour = G.C.GREEN,
    secondary_colour = G.C.GREEN,
    collection_rows = { 5, 6 },

    shop_rate = 2
}

SMODS.UndiscoveredSprite{
    key = 'fnaf_item',
    atlas = 'TarotFnaf',
    pos = {x = 2, y = 0}
}

SMODS.Consumable{
    key = 'pizza_maker', 
    set = 'fnaf_item', 
    atlas = 'TarotFnaf', 
    pos = {x = 4, y = 1},
    config = { max_highlighted = 2, mod_conv = 'm_fnaf_pizza' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

