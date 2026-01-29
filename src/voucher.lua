SMODS.Voucher {
    key = 'collection',
    atlas = 'Vouchers',
    pos = { x = 0, y = 0 },
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

SMODS.Voucher {
    key = 'starter_deck',
    atlas = 'Vouchers',
    pos = { x = 0, y = 1 },
    unlocked = true,
    requires = { 'v_fnaf_collection' },
    loc_vars = function(self, info_queue, card)
    end,
}

SMODS.Voucher {
    key = 'voucher',
    atlas = 'Vouchers',
    pos = { x = 1, y = 0 },
    config = { extra = { slots = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.change_voucher_limit(card.ability.extra.slots)
                return true
            end
        }))
    end
}

SMODS.Voucher {
    key = 'coupon',
    atlas = 'Vouchers',
    pos = { x = 1, y = 1 },
    config = { extra = { rerolls = 2 } },
    unlocked = true,
    requires = { 'v_fnaf_voucher' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rerolls } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.change_free_rerolls(card.ability.extra.rerolls)
                return true
            end
        }))
    end
}