---@diagnostic disable: undefined-global

local data_UCN = {}
    for line in NFS.lines(SMODS.current_mod.path.."/imported/UCN.txt") do
        local key, value = string.match(line, "(.*)=(.*)")
        if key and value then
            data_UCN[key] = tonumber(value)
        end
    end

local data_FNAF1 = {}
    for line in NFS.lines(SMODS.current_mod.path.."/imported/FNAF1.txt") do
        local key, value = string.match(line, "(.*)=(.*)")
        if key and value then
            data_FNAF1[key] = tonumber(value)
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
    loc_vars = function(self, info_queue, card)        
        info_queue[#info_queue + 1] = { key = "fnaf_code_WIP", set = "Other" }
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_custom'
    end
}

local  Freddy_Mult = 0

for _, sum in pairs(data_FNAF1) do
    Freddy_Mult = Freddy_Mult + sum
end

for _, sum in pairs(data_UCN) do
    Freddy_Mult = Freddy_Mult + sum
end

if Freddy_Mult > 19 then
    score = 19
end

Freddy_Mult = Freddy_Mult - data_UCN.hs

SMODS.Joker {
    key = "freddy",
    atlas = 'Joker',
    pos = { x = 3, y = 8 },
    soul_pos = { x = 3, y = 9 },
    blueprint_compat = true,
    rarity = 4,
    cost = 20,
    config = { extra = { xmult = 1 + (0.25 * Freddy_Mult), xmult_gain = 0.25 } },
    loc_vars = function(self, info_queue, card)        
        info_queue[#info_queue + 1] = { key = "fnaf_code_WIP", set = "Other" }
        info_queue[#info_queue + 1] = { key = "fnaf_game_support", set = "Other" }
        return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
    end,    
    calculate = function(self, card, context)
        if context.joker_main then
            local freddy_voice = math.random(1, 3)
            return {
                xmult = card.ability.extra.xmult,
                func = function()
                    if (pseudorandom('fnaf_freddy_scored') < 1 / 2) then
                        card:juice_up(0.1, 0.2)
                        if freddy_voice == 1 then
                            play_sound('fnaf_freddy_score')
                        elseif freddy_voice == 2 then
                            play_sound('fnaf_freddy_score2')
                        elseif freddy_voice == 3 then
                            play_sound('fnaf_freddy_score3')
                        end
                    end
                end
            }
        end

        if context.end_of_round and G.GAME.blind.boss and context.main_eval and (pseudorandom('fnaf_endblind') < 1 / 2) then
            card:juice_up(0.1, 0.2)
            play_sound('fnaf_freddy_endofblind')
        end
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_custom'
    end
}

SMODS.Joker {
    key = "foxy",
    atlas = 'Joker',
    pos = { x = 6, y = 8 },
    soul_pos = { x = 6, y = 9 },

    blueprint_compat = true,
    rarity = 4,
    cost = 20,
    config = { extra = { repetitions = 1 }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_code_WIP", set = "Other" }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local foxy_voice = math.random(1, 5)
            return {
                repetitions = card.ability.extra.repetitions,
                func = function()
                    if (pseudorandom('fnaf_foxy_scored') < 1 / 2) then
                        card:juice_up(0.1, 0.2)
                        if foxy_voice == 1 then
                            play_sound('fnaf_foxy_score')
                        elseif foxy_voice == 2 then
                            play_sound('fnaf_foxy_score2')
                        elseif foxy_voice == 3 then
                            play_sound('fnaf_foxy_score3')
                        elseif foxy_voice == 4 then
                            play_sound('fnaf_foxy_score4')
                        elseif foxy_voice == 5 then
                            play_sound('fnaf_foxy_score5')
                        end
                    end
                end
            }
        end

        if context.end_of_round and G.GAME.blind.boss and context.main_eval and (pseudorandom('fnaf_endblind') < 1 / 2) then
            card:juice_up(0.1, 0.2)
            play_sound('fnaf_foxy_endofblind')
        end
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_custom'
    end
}

SMODS.Joker {
    key = "golden",
    atlas = 'Joker',
    pos = { x = 7, y = 8 },
    soul_pos = { x = 7, y = 9 },

    blueprint_compat = true,
    rarity = 4,
    cost = 20,
    config = { extra = { mult = data_UCN.hs or 1 }, },
    loc_vars = function(self, info_queue, card)
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
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_custom'
    end

}

