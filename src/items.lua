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
    collection_rows = { 3, 3 },

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

SMODS.Consumable{
    key = 'grabber', 
    set = 'fnaf_item', 
    atlas = 'TarotFnaf', 
    pos = {x = 6, y = 1},
    config = { extra = { cards = 3 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "fnaf_sprite_WIP", set = "Other"}
        return { vars = { card.ability.extra.cards } }
    end,
    use = function(self, card, area, copier)
        SMODS.draw_cards(card.ability.extra.cards)
    end,
    can_use = function(self, card)
        return #G.deck.cards >= 3
    end
}

SMODS.Consumable{
    key = 'boost', 
    set = 'fnaf_item', 
    atlas = 'TarotFnaf', 
    pos = {x = 7, y = 1},
    config = { extra = { cards = 3 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "fnaf_sprite_WIP", set = "Other"}
        info_queue[#info_queue + 1] = {key = "fnaf_WIP", set = "Other"}
        return { vars = { card.ability.extra.cards } }
    end,
}



