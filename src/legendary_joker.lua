---@diagnostic disable: undefined-global


local data = {}
    for line in NFS.lines(SMODS.current_mod.path.."/imported/game_data.txt") do
        local key, value = string.match(line, "(.*)=(.*)")
        if key and value then
            data[key] = value
        end
    end
    

SMODS.Joker {
    key = "bonnie",
    atlas = 'Joker',
    pos = { x = 4, y = 8 },
    soul_pos = { x = 4, y = 9 },

    blueprint_compat = false,
    rarity = 4,
    cost = 20,
    config = { extra = { odds = 10 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
        return { vars = { card.ability.extra.odds } }
    end,
    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v * card.ability.extra.odds
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v / card.ability.extra.odds
        end
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_custom'
    end
}

SMODS.Joker {
    key = "chica",
    atlas = 'Joker',
    pos = { x = 5, y = 8 },
    soul_pos = { x = 5, y = 9 },

    blueprint_compat = false,
    rarity = 4,
    cost = 20,
    config = { extra = { hands_left = 10 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_WIP", set = "Other" }
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
        return { vars = { card.ability.extra.hands_left } }
    end,    
}

SMODS.Joker {
    key = "golden",
    atlas = 'Joker',
    pos = { x = 7, y = 8 },
    soul_pos = { x = 7, y = 9 },

    blueprint_compat = false,
    rarity = 4,
    cost = 20,
    config = { extra = { mult = data.hs or 1 }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_WIP", set = "Other" }
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
        return { vars = { card.ability.extra.mult or 1 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local score = card.ability.extra.mult

            if score > 10600 then
                score = 10600
            end

            return {
                mult = score
            }
        end
    end

}

--function SMODS.current_mod.reset_game_globals(run_start)
--reset_fnaf_helpy()    -- See Mail-In Rebate
--end
