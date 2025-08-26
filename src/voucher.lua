SMODS.Voucher {
    key = 'collection',
    atlas = 'Vouchers',
    pos = { x = 2, y = 0 },
    config = { extra = { slots = 1 } },
    loc_vars = function(self, info_queue, card)
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

-- Omen Globe
SMODS.Voucher {
    key = 'starter_deck',
    atlas = 'Vouchers',
    pos = { x = 2, y = 1 },
    unlocked = false,
    requires = { 'v_fnaf_collection' },
}