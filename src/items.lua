---@diagnostic disable: undefined-global
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
    pos = {x = 0, y = 2}
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
    key = 'philately',
    set = 'fnaf_item',
    atlas = 'TarotFnaf',
    pos = {x = 9, y = 1},
    config = { max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(SMODS.poll_seal ({guaranteed = true, type_key = 'fnaf_item_philately'}))
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
}

SMODS.Consumable{
    key = 'grabber', 
    set = 'fnaf_item', 
    atlas = 'TarotFnaf', 
    pos = {x = 6, y = 1},
    config = { extra = { cards = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
    end,
    use = function(self, card, area, copier)
        SMODS.draw_cards(card.ability.extra.cards)
    end,
    can_use = function(self, card)
        return #G.deck.cards >= 3 and (G.GAME.blind.in_blind)
    end
}

SMODS.Consumable{
    key = 'boost',
    set = 'fnaf_item',
    atlas = 'TarotFnaf',
    pos = {x = 7, y = 1},
    config = { extra = { cards = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
    end,
    use = function(self, card, area, copier)
        local _edition = poll_edition('fnaf_item_boost_edition' .. G.GAME.round_resets.ante, 2, true)
        local _seal = SMODS.poll_seal({ mod = 10 })
        for i = 1, card.ability.extra.cards do
            SMODS.add_card{ 
                set = "Playing Card",
                edition = _edition,
                seal = _seal,
                key_append = "fnaf_item_boost",
            }
            G.deck.config.card_limit = G.deck.config.card_limit + 1
        end
    end,
    can_use = function(self, card)
        return G.GAME.blind.in_blind
    end
}

SMODS.Consumable{
    key = 'deathcoin',
    set = 'fnaf_item',
    atlas = 'TarotFnaf',
    pos = {x = 8, y = 1},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_boss', set = 'Tag' }
        return { vars = { localize { type = 'name_text', set = 'Tag', key = 'tag_boss' } } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = (function()
                add_tag(Tag('tag_boss'))
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end)
        }))
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable {
    key = 'grabbag',
    set = 'fnaf_item',
    atlas = 'TarotFnaf',
    pos = {x = 1, y = 2},
    config = { extra = { cards = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
    end,
    use = function(self, card, area, copier)
        for i = 1, math.min(card.ability.extra.cards, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ set = 'fnaf_item' })
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit
    end
}


