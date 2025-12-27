SMODS.Voucher {
    key = 'collection',
    atlas = 'Vouchers',
    pos = { x = 0, y = 0 },
    config = { extra = { slots = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
        return { vars = { card.ability.extra.slots } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.change_booster_limit(card.ability.extra.slots)
                return true
            end
        }))
    end
}

SMODS.Voucher {
    key = 'starter_deck',
    atlas = 'Vouchers',
    pos = { x = 0, y = 1 },
    unlocked = true,
    requires = { 'v_fnaf_collection' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
    end,
}