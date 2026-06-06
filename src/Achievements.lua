--SMODS.Achievement {
--    key = "fazlegend",
--    hidden_name = true,
--    unlock_key = 'j_fnaf_bonnie',
--    unlock_condition = function(self, args)
--    end
--}

SMODS.Achievement {
    key = 'bbrun',
    hidden_name = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == 'win' then
            return next(SMODS.find_card('j_fnaf_balloon_boy'))
        end
    end
}

SMODS.Achievement {
    key = 'itemdiscover',
    hidden_name = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if args.type == "discover_amount" then
            local ItemCard = 0
            local Discover = 0
            for _, card in pairs(G.P_CENTER_POOLS['fnaf_item']) do
                ItemCard = ItemCard + 1

                if card.discovered then
                    Discover = Discover + 1
                end
            end
            if Discover == ItemCard then
                return true
            end
        end
    end
}

SMODS.Achievement {
    key = 'montysmash',
    hidden_name = true,
    bypass_all_unlocked = true,
    reset_on_startup = true,
    unlock_condition = function(self, args)
        if args.type == "montysmash" then return true end
    end
}
