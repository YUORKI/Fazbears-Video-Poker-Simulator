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
    pos = { x = 1, y = 3 },
    soul_pos = { x = 1, y = 4 },

    blueprint_compat = false,
    rarity = 4,
    cost = 20,
    config = { extra = { odds = 10 } },
    loc_vars = function(self, info_queue, card)
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

Chica_sfx_ee = function()
    local _chica_sound_ee = {"fnaf_Chica_sfx","fnaf_Chica_sfx2","fnaf_Chica_sfx3","fnaf_Chica_sfx4","fnaf_Chica_sfx5","fnaf_Chica_sfx6"}
    play_sound(_chica_sound_ee[math.random(#_chica_sound_ee)])
end

SMODS.Joker {
    key = "chica",
    atlas = 'Joker',
    pos = { x = 2, y = 3 },
    soul_pos = { x = 2, y = 4 },
    blueprint_compat = false,
    rarity = 4,
    cost = 20,
    config = { extra = { perc = 30  } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.perc } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.GAME.blind.chips = G.GAME.blind.chips - ((card.ability.extra.perc / 100) * G.GAME.blind.chips)
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            return {
                message = '-30% score',
                colour = G.C.ORANGE,
                func = function()
                    if (pseudorandom('fnaf_Chica_scored') < 1 / 50) then
                        card:juice_up(0.1, 0.2)
                        Chica_sfx_ee()
                    end
                end
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        local chica_spawn = math.random(1, 100)
        if (pseudorandom('fnaf_chica_summon') < 1 / 2) then
            if chica_spawn > 85 then
                Chica_sfx_ee()
            else
                local _chica_summon = {"fnaf_Chica_score","fnaf_Chica_score2"}
                play_sound(_chica_summon[math.random(#_chica_summon)])
            end
        end
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

Freddy_Mult = Freddy_Mult - data_UCN.hs

if Freddy_Mult > 19 then
    Freddy_Mult = 19
end

SMODS.Joker {
    key = "freddy",
    atlas = 'Joker',
    pos = { x = 0, y = 3 },
    soul_pos = { x = 0, y = 4 },
    blueprint_compat = true,
    rarity = 4,
    cost = 20,
    config = { extra = { xmult = 1 + (0.25 * Freddy_Mult), xmult_gain = 0.25 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_game_support", set = "Other" }
        return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
    end,    
    calculate = function(self, card, context)
        if context.joker_main then
            local freddy_voice = math.random(1, 3)
            return {
                xmult = card.ability.extra.xmult,
                func = function()
                    if (pseudorandom('fnaf_freddy_scored') < 1 / 4) then
                        card:juice_up(0.1, 0.2)
                        local _freddy_score = {"fnaf_freddy_score","fnaf_freddy_score2","fnaf_freddy_score3"}
                        play_sound(_freddy_score[math.random(#_freddy_score)])
                    end
                end
            }
        end

        if context.end_of_round and G.GAME.blind.boss and context.main_eval and (pseudorandom('fnaf_endblind') < 1 / 2) then
            card:juice_up(0.1, 0.2)
            play_sound('fnaf_freddy_endofblind')
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        local freddy_spawn = math.random(1, 4)
        if freddy_spawn == 1 then
            play_sound('fnaf_Freddy_summon')
        elseif freddy_spawn == 2 then
            play_sound('fnaf_Freddy_summon2')
        elseif freddy_spawn == 3 then
            play_sound('fnaf_Freddy_summon3')
        elseif freddy_spawn == 4 then
            play_sound('fnaf_Freddy_summon4')
        end
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_custom'
    end
}

SMODS.Joker {
    key = "foxy",
    atlas = 'Joker',
    pos = { x = 3, y = 3 },
    soul_pos = { x = 3, y = 4 },

    blueprint_compat = true,
    rarity = 4,
    cost = 20,
    config = { extra = { repetitions = 1 }, },
    loc_vars = function(self, info_queue, card)
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local foxy_voice = math.random(1, 5)
            return {
                repetitions = card.ability.extra.repetitions,
                func = function()
                    if (pseudorandom('fnaf_foxy_scored') < 1 / 4) then
                        card:juice_up(0.1, 0.2)
                        local _foxy_score = {"fnaf_foxy_score","fnaf_foxy_score2","fnaf_foxy_score3","fnaf_foxy_score4","fnaf_foxy_score5"}
                        play_sound(_foxy_score[math.random(#_foxy_score)])
                    end
                end
            }
        end

        if context.end_of_round and G.GAME.blind.boss and context.main_eval and (pseudorandom('fnaf_endblind') < 1 / 2) then
            card:juice_up(0.1, 0.2)
            play_sound('fnaf_foxy_endofblind')
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        local foxy_spawn = math.random(1, 2)
        card:juice_up(0.1, 0.2)
        if foxy_spawn == 1 then
            play_sound('fnaf_foxy_summon1')
        elseif foxy_spawn == 2 then
            play_sound('fnaf_foxy_summon2')
        end
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_custom'
    end
}

SMODS.Joker {
    key = "golden",
    atlas = 'Joker',
    pos = { x = 4, y = 3 },
    soul_pos = { x = 4, y = 4 },

    blueprint_compat = true,
    rarity = 4,
    cost = 20,
    config = { extra = { mult = data_UCN.hs or 1 }, },
    loc_vars = function(self, info_queue, card)
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
    add_to_deck = function(self, card, from_debuff)
        play_sound('fnaf_Golden_Mumble')
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_custom'
    end

}

