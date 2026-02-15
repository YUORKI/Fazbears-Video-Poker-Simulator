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

local data_FNAF2 = {}
    for line in NFS.lines(SMODS.current_mod.path.."/imported/FNAF2.txt") do
        local key, value = string.match(line, "(.*)=(.*)")
        if key and value then
            data_FNAF2[key] = tonumber(value)
        end
    end

local data_FNAF3 = {}
    for line in NFS.lines(SMODS.current_mod.path.."/imported/FNAF3.txt") do
        local key, value = string.match(line, "(.*)=(.*)")
        if key and value then
            data_FNAF3[key] = tonumber(value)
        end
    end

local data_FNAF4 = {}
    for line in NFS.lines(SMODS.current_mod.path.."/imported/FNAF4.txt") do
        local key, value = string.match(line, "(.*)=(.*)")
        if key and value then
            data_FNAF4[key] = tonumber(value)
        end
    end

local data_FNAFSL = {}
    for line in NFS.lines(SMODS.current_mod.path.."/imported/FNAFSL.txt") do
        local key, value = string.match(line, "(.*)=(.*)")
        if key and value then
            data_FNAFSL[key] = tonumber(value)
        end
    end

local data_FNAFWORLD = {}
    for line in NFS.lines(SMODS.current_mod.path.."/imported/FNAFWORLD.txt") do
        local key, value = string.match(line, "(.*)=(.*)")
        if key and value then
            data_FNAFWORLD[key] = tonumber(value)
        end
    end

local data_FNAF6 = {}
    for line in NFS.lines(SMODS.current_mod.path.."/imported/FFPS.txt") do
        local key, value = string.match(line, "(.*)=(.*)")
        if key and value then
            data_FNAF6[key] = tonumber(value)
        end
    end

SMODS.Joker {
    key = "bonnie",
    atlas = 'Joker',
    unlocked = false,
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
}

SMODS.Joker {
    key = "chica",
    atlas = 'Joker',
    unlocked = false,
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
                        local _chica_sound_ee = {"fnaf_Chica_sfx","fnaf_Chica_sfx2","fnaf_Chica_sfx3","fnaf_Chica_sfx4","fnaf_Chica_sfx5","fnaf_Chica_sfx6"}
                        Voicelines(_chica_sound_ee)
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
                Voicelines(_chica_summon)
            end
        end
    end,
}

local  Freddy_Mult = 0

for _, sum in pairs(data_FNAF1) do
    Freddy_Mult = Freddy_Mult + sum
end -- 3

for _, sum in pairs(data_FNAF2) do
    Freddy_Mult = Freddy_Mult + sum
end -- 12

for _, sum in pairs(data_FNAF3) do
    Freddy_Mult = Freddy_Mult + sum
end -- 4

for _, sum in pairs(data_FNAF4) do
    Freddy_Mult = Freddy_Mult + sum
end -- 10

for _, sum in pairs(data_FNAFSL) do
    Freddy_Mult = Freddy_Mult + sum
end -- 3

for _, sum in pairs(data_FNAFWORLD) do
    Freddy_Mult = Freddy_Mult + sum
end -- 9

for _, sum in pairs(data_FNAF6) do
    Freddy_Mult = Freddy_Mult + sum
end -- 5

for _, sum in pairs(data_UCN) do
    Freddy_Mult = Freddy_Mult + sum
end -- 17


Freddy_Mult = Freddy_Mult - data_UCN.hs

Golden_Mult = data_UCN.hs

if Freddy_Mult > 63 then
    Freddy_Mult = 63
end

if FNAF.config.freddyimport then
    Freddy_Mult = 63
end

if FNAF.config.goldenimport then
    Golden_Mult = 10600
end

SMODS.Joker {
    key = "freddy",
    atlas = 'Joker',
    pos = { x = 0, y = 3 },
    soul_pos = { x = 0, y = 4 },
    blueprint_compat = true,
    unlocked = false,
    rarity = 4,
    cost = 20,
    config = { extra = { xmult = 1 + (0.06 * Freddy_Mult), xmult_gain = 0.06 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_game_support", set = "Other" }

        if Freddy_Mult == 0 then
            info_queue[#info_queue + 1] = { key = "fnaf_save_import", set = "Other" }
        end

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
                        Voicelines(_freddy_score)
                    end
                end
            }
        end

        if context.end_of_round and G.GAME.blind.boss and context.main_eval and (pseudorandom('fnaf_endblind') < 1 / 2) then
            card:juice_up(0.1, 0.2)
            local _freddy_endblind = {"fnaf_freddy_endofblind"}
            Voicelines(_freddy_endblind)
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        local freddy_spawn = {"fnaf_Freddy_summon","fnaf_Freddy_summon2","fnaf_Freddy_summon3","fnaf_Freddy_summon4",}
        Voicelines(freddy_spawn)

    end,
}

SMODS.Joker {
    key = "foxy",
    atlas = 'Joker',
    pos = { x = 3, y = 3 },
    soul_pos = { x = 3, y = 4 },
    unlocked = false,
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
                        Voicelines(_foxy_score)
                    end
                end
            }
        end

        if context.end_of_round and G.GAME.blind.boss and context.main_eval and (pseudorandom('fnaf_endblind') < 1 / 2) then
            card:juice_up(0.1, 0.2)
            local _foxy_endblind = {"fnaf_foxy_endofblind"}
            Voicelines(_foxy_endblind)
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        local foxy_spawn = {"fnaf_foxy_summon1","fnaf_Foxy_summon2",}
        Voicelines(foxy_spawn)
    end,
}

SMODS.Joker {
    key = "golden",
    atlas = 'Joker',
    pos = { x = 4, y = 3 },
    soul_pos = { x = 4, y = 4 },
    unlocked = false,
    blueprint_compat = true,
    rarity = 4,
    cost = 20,
    config = { extra = { mult = Golden_Mult or 1 }, },
    loc_vars = function(self, info_queue, card)
        if Golden_Mult == 0 then
            info_queue[#info_queue + 1] = { key = "fnaf_save_import", set = "Other" }
        end
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
        local golden_spawn = {"fnaf_Golden_Mumble",}
        Voicelines(golden_spawn)
    end,
}

