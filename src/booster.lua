SMODS.Booster {
    key = "item_normal_1",
    weight = 1,
    kind = 'fnaf_item', 
    cost = 4,    
    atlas = "BoosterFnaf",
    pos = { x = 0, y = 0 },
    config = { extra = 3, choose = 1 },
    group_key = "k_item_pack",
    select_card = 'consumeables',
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.WHITE, 0.4), lighten(G.C.BLACK, 0.2), lighten(G.C.RED, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_fnaf_starter_deck and pseudorandom('starter_deck') > 0.8 then
            _card = {
                set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "fnaf_booster_1"
            }
        else
            _card = {
                set = "fnaf_item",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "fnaf_booster_1"
            }
        end
        return _card
    end,
}

SMODS.Booster {
    key = "item_jumbo_1",
    weight = 1,
    kind = 'fnaf_item', 
    cost = 6,
    atlas = "BoosterFnaf",
    pos = { x = 1, y = 0 },
    config = { extra = 5, choose = 1 },
    group_key = "k_item_pack",
    select_card = 'consumeables',
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.WHITE, 0.4), lighten(G.C.BLACK, 0.2), lighten(G.C.RED, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_fnaf_starter_deck and pseudorandom('starter_deck') > 0.8 then
            _card = {
                set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "fnaf_booster_1"
            }
        else
            _card = {
                set = "fnaf_item",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "fnaf_booster_1"
            }
        end
        return _card
    end,
}

SMODS.Booster {
    key = "item_mega_1",
    weight = 0.25,
    kind = 'fnaf_item', 
    cost = 8,
    atlas = "BoosterFnaf",
    pos = { x = 2, y = 0 },
    config = { extra = 5, choose = 2 },
    group_key = "k_item_pack",
    select_card = 'consumeables',
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
        return {
            vars = { cfg.choose, cfg.extra },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.WHITE, 0.4), lighten(G.C.BLACK, 0.2), lighten(G.C.RED, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_fnaf_starter_deck and pseudorandom('starter_deck') > 0.8 then
            _card = {
                set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "fnaf_booster_1"
            }
        else
            _card = {
                set = "fnaf_item",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "fnaf_booster_1"
            }
        end
        return _card
    end,
}

