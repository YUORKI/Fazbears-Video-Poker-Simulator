---@diagnostic disable: undefined-global

local upd = Game.update
function Game:update(dt)
    upd(self, dt)
    if G.jokers then
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.name == 'j_fnaf_balloon_boy' then
                local _bb = G.jokers.cards[i]
                local _bbc = G.P_CENTERS.j_fnaf_balloon_boy
                if _bb.ability.extra.round < _bb.ability.extra.maxround and _bb.ability.eternal ~= true then
                    _bb.ability.eternal = true
                end
            end
        end
    end
end

SMODS.Joker {
    key = 'endo_01',
    atlas = 'Joker',
    pos = { x = 7, y = 0 },
    rarity = 1,
    cost = 2,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    config = { extra = { chip_mod = 100 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chip_mod } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chip_mod
            }
        end
    end
}

SMODS.Joker {
    key = 'bb',
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_dont", set = "Other" }
    end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.add_card{ key = 'j_fnaf_balloon_boy' }
        card:start_dissolve({G.C.RED})
        card = nil
    end,
}

SMODS.Joker {
    key = 'balloon_boy',
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    no_collection = true,
    config = { extra = { x_chips = 0.5, round = 0, maxround = 3}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_chips, card.ability.extra.round, card.ability.extra.maxround }}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                x_chips = card.ability.extra.x_chips,
                func = function()
                    card:juice_up(0.1, 0.2)
                    local _bb_voices = {"fnaf_bb_voice1","fnaf_bb_voice2","fnaf_bb_voice3"}
                    play_sound(_bb_voices[math.random(#_bb_voices)])
                end
            }
        end

        if context.setting_blind and not context.blueprint then
            card.ability.extra.round = card.ability.extra.round + 1
            if card.ability.extra.round >= card.ability.extra.maxround then
                card.ability.eternal = nil
            end
        end
    end,
    in_pool = function(self, args)
        return false
    end
}


SMODS.Joker {
    key = 'pizzabot',
    atlas = 'Joker',
    pos = { x = 5, y = 0 },
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_fnaf_pizza
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local pizza_card = create_playing_card({ center = G.P_CENTERS.m_fnaf_pizza }, G.discard, true, false,
                nil, true)
            G.E_MANAGER:add_event(Event({
                func = function()
                    pizza_card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                    G.play:emplace(pizza_card)
                    return true
                end
            }))
            return {
                message = localize('k_plus_pizza'),
                colour = G.C.SECONDARY_SET.Enhanced,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            return true
                        end
                    }))
                    draw_card(G.play, G.deck, 90, 'up')
                    SMODS.calculate_context({ playing_card_added = true, cards = { pizza_card } })
                end
            }
        end
    end
}

SMODS.Joker {
    key = 'dee_dee',
    atlas = 'Joker',
    pos = { x = 4, y = 0 },
    blueprint_compat = true,
    rarity = 3,
    cost = 10,
    config = { extra = { creates = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.creates } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss and context.main_eval
            and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(card.ability.extra.creates,
                G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create


            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        local deedee_voice = {"fnaf_DeeDee1","fnaf_DeeDee2"}
                        Voicelines(deedee_voice)
                        SMODS.add_card {
                            set = 'Joker',
                            rarity = 'Common', 'Uncommon', 'Rare'
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))

            return {
                message = localize('k_plus_joker'),
                colour = G.C.BLUE,
            }
        end
    end,
}

SMODS.Joker {
    key = "glitchtrap",
    atlas = 'Joker',
    pos = { x = 3, y = 0 },
    blueprint_compat = false,
    rarity = 2,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_fnaf_glitch
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local aces = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:get_id() == 14 then
                    aces = aces + 1
                    scored_card:set_ability('m_fnaf_glitch', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if aces > 0 then
                return {
                    message = 'Glitched',
                    colour = G.C.PURPLE,
                    func = function()
                        if (pseudorandom('fnaf_glitchtrap_scored') < 1 / 20) then
                            local glitch_voice = {"fnaf_Glitchtrap_audio","fnaf_Glitchtrap_audio2"}
                            Voicelines(glitch_voice)
                        end
                    end
                }
            end
        end
    end
}

SMODS.Joker {
    key = "cassie",
    atlas = 'Joker',
    pos = { x = 3, y = 2 },
    blueprint_compat = true,
    unlocked = false,
    rarity = 2,
    cost = 4,
    config = { extra = { odds = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
        and context.consumeable.ability.set == 'fnaf_item' and (pseudorandom('fnaf_cassie') < G.GAME.probabilities.normal / card.ability.extra.odds) then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    SMODS.add_card {
                        set = 'fnaf_item',
                        key_append = 'fnaf_cassie_item'
                    }
                    G.GAME.consumeable_buffer = 0
                    return true
                end)
            }))
            return {
                message = "+1 Item",
                colour = G.C.GREEN,
            }

        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 4 } }
    end,
    check_for_unlock = function(self, args) -- equivalent to `unlock_condition = { type = 'discover_amount', tarot_count = 22 }`
        local cards_discovered = 0
        local your_consumable_name_here = 'fnaf_item'        
        for _, card in pairs(G.P_CENTER_POOLS[your_consumable_name_here]) do
            if card.discovered then
                cards_discovered = cards_discovered + 1
            end
        end

        if cards_discovered == 4 then
            return true
        end

        return false
    end
}

SMODS.Joker {
    key = "jackie",
    atlas = 'Joker',
    pos = { x = 7, y = 2 },
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    config = { extra = { cards = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn and G.GAME.current_round.hands_left == 1 and not card.ability.extra.triggered then
            card.children.center:set_sprite_pos({x=8, y= 0})
            card.ability.extra.triggered = true
            return {func = function() SMODS.draw_cards(card.ability.extra.cards) end}
        end

        if context.end_of_round and context.main_eval then
            card.ability.extra.triggered = false
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        card.children.center:set_sprite_pos({x=8, y= 0})
    end,
    remove_from_deck = function(self, card, from_debuff)
        card.children.center:set_sprite_pos({x=7, y= 2})
    end,
}

SMODS.Joker {
    key = "logbook",
    atlas = 'Joker',
    pos = { x = 6, y = 1 },
    blueprint_compat = false,
    rarity = 3,
    cost = 7,
    config = { extra = { seal = 'fnaf_guard' } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local faces = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_face() then
                    faces = faces + 1
                    scored_card:set_seal(card.ability.extra.seal, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if faces > 0 then
                return {
                    message = 'Promoted?',
                    colour = HEX('bea233')
                }
            end
        end
    end
}


SMODS.Joker {
    key = "gator",
    atlas = 'Joker',
    pos = { x = 0, y = 1 },
    blueprint_compat = false,
    rarity = 2,
    cost = 7,
    config = { extra = { xmult = 1, xmult_gain = 0.1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            local r_cards = 0
            for _, removed_card in ipairs(context.removed) do
                r_cards = r_cards + 1
            end
            if r_cards > 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + r_cards * card.ability.extra.xmult_gain
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_xmult',
                        vars = { card.ability.extra.xmult },
                        sound = 'fnaf_Monty_laugh1'
                    }
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        card:juice_up(0.1, 0.2)
        local _monty_summon = {"fnaf_Monty_Rock","fnaf_Monty_RockAndRoll","fnaf_Mont_heylittleguy"}
        Voicelines(_monty_summon)
    end,
    remove_from_deck = function(self, card, from_debuff)
        card:juice_up(0.1, 0.2)
        local _monty_spawn = {"fnaf_Monty_growl","fnaf_Monty_growl2"}
        Voicelines(_monty_spawn)
    end,
}

SMODS.Joker {
    key = "ennard",
    atlas = 'Joker',
    pos = { x = 1, y = 1 },

    blueprint_compat = false,
    rarity = 3,
    cost = 6,
    config = { extra = { price = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.price } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for _, removed_card in ipairs(context.removed) do
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
                card:set_cost()
            end
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end,
}


SMODS.Joker {
    key = "learning",
    atlas = 'Joker',
    pos = { x = 4, y = 1 },

    blueprint_compat = false,
    rarity = 3,
    cost = 9,
    config = { extra = { odds = 20 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME and G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and pseudorandom('fnaf_learning') < G.GAME.hands[context.scoring_name].played / card.ability.extra.odds then
            return {
                level_up = true,
                message = localize('k_level_up_ex')
            }
        end
    end
}

SMODS.Joker {
    key = "glam_chica",
    atlas = 'Joker',
    pos = { x = 2, y = 0 },
    unlocked = false,
    blueprint_compat = false,
    rarity = 2,
    cost = 7,
    config = { extra = { Xmult_gain = 0.15, Xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local enhanced = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(scored_card, "m_fnaf_pizza") and not scored_card.debuff and not scored_card.vampired then
                    enhanced[#enhanced + 1] = scored_card
                    local _Glam_Pizza = {"fnaf_GlamChica_Pizza","fnaf_GlamChica_Pizza1","fnaf_GlamChica_Pizza2","fnaf_GlamChica_Pizza3"}
                    Voicelines(_Glam_Pizza)
                    scored_card.vampired = true
                    SMODS.destroy_cards(scored_card)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            scored_card.vampired = nil
                            return true
                        end
                    }))
                end
            end

            if #enhanced > 0 then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain * #enhanced
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_xmult',
                        vars = {
                            card.ability.extra.Xmult
                        }
                    },
                    colour = G.C.MULT,
                    func = function()
                        card:juice_up(0.1, 0.2)
                        local _GlamChica_yes = {"fnaf_GlamChica_Eating","fnaf_GlamChica_Eating2"}
                        Voicelines(_GlamChica_yes)
                    end
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, "m_fnaf_pizza") then
                return true
            end
        end
        return false
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 5, localize { type = 'name_text', key = 'm_fnaf_pizza', set = 'Enhanced' } } }
    end,
    check_for_unlock = function(self, args) -- equivalent to `unlock_condition = { type = 'modify_deck', extra = { count = 5, enhancement = 'Glass Card', e_key = 'm_glass' } }`
        if args.type == 'modify_deck' then
            local count = 0
            for _, playing_card in ipairs(G.playing_cards or {}) do
                if SMODS.has_enhancement(playing_card, "m_fnaf_pizza") then count = count + 1 end
                if count >= 5 then
                    return true
                end
            end
        end
        return false
    end
}

SMODS.Joker {
    key = "rock_chica",
    unlocked = false,
    blueprint_compat = false,
    rarity = 3,
    cost = 7,
    atlas = 'Joker',
    pos = { x = 6, y = 2 },
    config = { extra = { hands_left = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands_left } }
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 10, localize { type = 'name_text', key = 'm_fnaf_pizza', set = 'Enhanced' } } }
    end,
    check_for_unlock = function(self, args) -- equivalent to `unlock_condition = { type = 'modify_deck', extra = { count = 5, enhancement = 'Glass Card', e_key = 'm_glass' } }`
        if args.type == 'modify_deck' then
            local count = 0
            for _, playing_card in ipairs(G.playing_cards or {}) do
                if SMODS.has_enhancement(playing_card, "m_fnaf_pizza") then count = count + 1 end
                if count >= 10 then
                    return true
                end
            end
        end
        return false
    end
}


SMODS.Joker {
    key = "s_puppet",
    atlas = 'Joker',
    pos = { x = 8, y = 2 },

    blueprint_compat = false,
    rarity = 3,
    cost = 8,
    config = { extra = { seal = 'fnaf_security' } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        info_queue[#info_queue + 1] = G.P_CENTERS.m_fnaf_kid
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and context.end_of_round then
            if SMODS.has_enhancement(context.other_card, "m_fnaf_kid") then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED
                    }
                else
                    card.children.center:set_sprite_pos({x=2, y= 2})
                    context.other_card:set_seal(card.ability.extra.seal, nil, true)
                    return {
                        message = 'Secured',
                        colour = G.C.GREEN
                    }
                end
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        card.children.center:set_sprite_pos({x=2, y= 2})
    end,
    remove_from_deck = function(self, card, from_debuff)
        card.children.center:set_sprite_pos({x=8, y= 2})
    end,
}

SMODS.Joker {
    key = "toy_chica",
    atlas = 'Joker',
    pos = { x = 5, y = 2 },

    blueprint_compat = false,
    rarity = 2,
    cost = 3,
    config = { extra = { chips = 0, chip_mod = 30 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for _, removed_card in ipairs(context.removed) do
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            end
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        local Tchica_summon = math.random(1, 3)
        if (pseudorandom('fnaf_Tchica_summon') < 1 / 2) then
            card:juice_up(0.1, 0.2)
            play_sound('fnaf_TChica_summon')
        end
    end,
}

SMODS.Joker {
    key = "r_freddy",
    atlas = 'Joker',
    pos = { x = 7, y = 1 },
    unlocked = false,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    config = { extra = { seal = 'Gold', chips_mod = 25, chips = 0 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]

        local gold_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card.seal == card.ability.extra.seal then gold_tally = gold_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.chips_mod, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local gold_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card.seal == card.ability.extra.seal then gold_tally = gold_tally + 1 end
            end
            return {
                chips = card.ability.extra.chips_mod * gold_tally
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if playing_card.seal == self.config.extra.seal then
                return true
            end
        end
        return false
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 3, localize { type = 'name_text', key = 'gold_seal', set = 'Other' } } }
    end,
    check_for_unlock = function(self, args) -- equivalent to `unlock_condition = { type = 'modify_deck', extra = { count = 3, enhancement = 'Wild Card', e_key = 'm_wild' } }`
        if args.type == 'modify_deck' then
            local count = 0
            for _, playing_card in ipairs(G.playing_cards or {}) do
                if playing_card.seal == 'Gold' then count = count + 1 end
                if count >= 3 then
                    return true
                end
            end
        end
        return false
    end
}


SMODS.Joker {
    key = "m_hippo",
    atlas = 'Joker',
    pos = { x = 1, y = 0 },
    unlocked = false,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    config = { extra = { poker_hand = 'Flush House', poker_hand2 = 'Five of a Kind', poker_hand3 = 'Flush Five' } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize(card.ability.extra.poker_hand, 'poker_hands'),
                localize(card.ability.extra.poker_hand2, 'poker_hands'),
                localize(card.ability.extra.poker_hand3, 'poker_hands')
            }
        }
    end,
    calculate = function(self, card, context)
        local valid_hand = false
        if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if next(context.poker_hands[card.ability.extra.poker_hand]) then
                valid_hand = true
            elseif next(context.poker_hands[card.ability.extra.poker_hand2]) then
                valid_hand = true
            elseif next(context.poker_hands[card.ability.extra.poker_hand3]) then
                valid_hand = true
            end

            if valid_hand == true then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Spectral',
                            key_append = 'vremade_seance'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = localize('k_plus_spectral'),
                    colour = G.C.SECONDARY_SET.Spectral,
                    valid_hand = false
                }
            end
        end
    end,
    check_for_unlock = function(self, args)
        for k, v in pairs(G.handlist) do
            if G.GAME.hands[v].visible and not SMODS.PokerHands[v].visible then
                return true
            end
	    end
        return false
    end
}

SMODS.Joker {
    key = "missing",
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = 'Joker',
    pos = { x = 3, y = 1 },
    config = { extra = { odds = 2, faces = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME and G.GAME.probabilities.normal or 1, card.ability.extra.odds, card.ability.extra.faces } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local faces = 0
            local _type = pseudorandom_element({ 'Tarot', 'Planet', 'fnaf_item' }, pseudoseed('fnaf_missing'))
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_face() then
                    faces = faces + 1
                    if faces == card.ability.extra.faces and G.consumeables.config.card_limit > #G.consumeables.cards
                        and SMODS.pseudorandom_probability(card, 'fnaf_missing', G.GAME.probabilities.normal, card.ability.extra.odds) then
                        trigger = 1
                        SMODS.add_card({ set = _type })
                        return { message = 'found', colour = HEX('363636') }
                    end
                end
            end
        end
    end
}

SMODS.Joker {
    key = "orville",
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    atlas = 'Joker',
    pos = { x = 0, y = 2 },
    calculate = function(self, card, context)
        if context.after and context.main_eval and not context.blueprint then
            local enhanced = {}
            local OrvilleUsed = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if next(SMODS.get_enhancements(scored_card)) and not scored_card.debuff then
                    enhanced[#enhanced + 1] = scored_card
                    OrvilleUsed = OrvilleUsed + 1
                    scored_card:set_ability(SMODS.poll_enhancement({ guaranteed = true }), nil, true)
                end
            end

            if OrvilleUsed > 0 then
                return {
                    message = 'MAGIC',
                    colour = G.C.ORANGE,
                    func = function()
                        if (pseudorandom('fnaf_orville_scored') < 1 / 5) then
                            card:juice_up(0.1, 0.2)
                            local _Orville_score = {"fnaf_Orville01","fnaf_Orville02","fnaf_Orville03","fnaf_Orville04"}
                            Voicelines(_Orville_score)
                        end
                    end
                }
            else
                return true
            end

        end
    end,
}

SMODS.Joker {
    key = "toy_bonnie",
    blueprint_compat = false,
    unlocked = false,
    rarity = 2,
    cost = 5,
    atlas = 'Joker',
    pos = { x = 4, y = 2 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 7, localize { type = 'name_text', key = 'm_wild', set = 'Enhanced' } } }
    end,
    check_for_unlock = function(self,args)
        for _, card in ipairs(G.playing_cards or {}) do
            if card:get_id() == 7 and SMODS.has_enhancement(card, "m_wild") then
                return true
            end
        end
        return false
    end
}

local is_suit_ref = Card.is_suit
function Card.is_suit(self, ...)
   local ret = is_suit_ref(self,...)
   if self:get_id() == 7 and next(SMODS.find_card("j_fnaf_toy_bonnie")) then
      return true
   end
   return ret
end

SMODS.Joker {
    key = "toy_freddy",
    blueprint_compat = false,
    unlocked = false,
    rarity = 3,
    cost = 7,
    atlas = 'Joker',
    pos = { x = 5, y = 3 },
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 400, G.PROFILES[G.SETTINGS.profile].career_stats.c_face_cards_played } }
    end,
    check_for_unlock = function(self, args) -- equivalent to `unlock_condition = { type = 'c_face_cards_played', extra = 300 }`
        if args.type == 'career_stat' and args.statname == 'c_face_cards_played' then
            return G.PROFILES[G.SETTINGS.profile].career_stats[args.statname] >= 400
        end
        return false
    end
}

local card_get_id_ref = Card.get_id
function Card:get_id()
    local original_id = card_get_id_ref(self)
    if not original_id then return original_id end

    if next(SMODS.find_card("j_fnaf_toy_freddy")) then
        if original_id >= 11 and original_id <= 13 then return 14 end
    end
    return original_id
end

SMODS.Joker {
    key = "time_clock",
    blueprint_compat = true,
    rarity = 1,
    cost = 3,
    atlas = 'Joker',
    pos = { x = 8, y = 1 },
    config = { extra = { chips = 100 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context) -- code made by Joker Forge. I dont know how the fuck this work
        if context.cardarea == G.jokers and context.joker_main  then
            if (next(context.poker_hands["Straight"]) and (function()
                local rankFound = true
            for i, c in ipairs(context.scoring_hand) do
                if c:is_face() then
                    rankFound = false
                    break
                end
            end

                return rankFound
            end)() and (function()
                local rankFound = true
                for i, c in ipairs(context.scoring_hand) do
                    if c:get_id() == 14 then
                        rankFound = false
                        break
                    end
                end

    return rankFound
end)()) then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}

SMODS.Joker {
    key = "frog",
    blueprint_compat = true,
    rarity = 1,
    cost = 3,
    unlocked = false,
    atlas = 'Joker',
    pos = { x = 1, y = 2 },
    config = { extra = { chip_mod = 50 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chip_mod, G.GAME.skips * card.ability.extra.chip_mod } }
    end,
    calculate = function(self, card, context)
        if context.skip_blind and not context.blueprint then
            return {
                message = localize { type = 'variable', key = 'a_chips', vars = { G.GAME.skips * card.ability.extra.chip_mod } }
            }
        end
        if context.joker_main then
            return {
                chips = G.GAME.skips * card.ability.extra.chip_mod
            }
        end
    end,
    check_for_unlock = function(self, args)
        return args.type == 'continue_game'
    end
}

SMODS.Joker {
    key = "diver",
    blueprint_compat = false,
    rarity = 1,
    cost = 4,
    unlocked = false,
    atlas = 'Joker',
    pos = { x = 9, y = 2 },
    config = { extra = { levels = 0, maxlevel = 6, chips = 0, mult = 0, xmult = 0, h_size = 0} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_bug", set = "Other" }
        return { vars = { card.ability.extra.levels, card.ability.extra.maxlevel, card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.h_size} }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'fnaf_item'
        and not (card.ability.extra.levels == card.ability.extra.maxlevel) and context.consumeable.config.center.key == 'c_fnaf_clearance' then
            card.ability.extra.levels = card.ability.extra.levels + 1

            card.ability.extra.chips = 100 * card.ability.extra.levels -- 1
            card.ability.extra.h_size = math.max(0, card.ability.extra.levels - 1) -- 2
            card.ability.extra.mult = math.max(0, 5 * (card.ability.extra.levels - 2)) -- 3
            card.ability.extra.xmult = math.max(1, 1 + (0.125 * (card.ability.extra.levels - 3)))  -- 4
            -- 5
            -- 6

            if card.ability.extra.levels >= 2 then
                G.hand:change_size(1)
            end
        end

        if context.joker_main then

            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                xmult = card.ability.extra.xmult,
            }
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 6 } }
    end,
    check_for_unlock = function(self, args) -- equivalent to `unlock_condition = { type = 'discover_amount', tarot_count = 22 }`
        local cards_discovered = 0
        local your_consumable_name_here = 'fnaf_item'        
        for _, card in pairs(G.P_CENTER_POOLS[your_consumable_name_here]) do
            if card.discovered then
                cards_discovered = cards_discovered + 1
            end
        end

        if cards_discovered == 6 then
            return true
        end

        return false
    end
}

SMODS.Joker {
    key = "king",
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    atlas = 'Joker',
    pos = { x = 6, y = 3 },
    config = {extra = { money = 5, odds = 3} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_mod_comp", set = "Other" }
        return { vars = { card.ability.extra.money, G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.money_altered and to_big(context.amount) <= to_big(-5)
        and SMODS.pseudorandom_probability(card, 'fnaf_king', G.GAME.probabilities.normal, card.ability.extra.odds)
        and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and G.STATES.SHOP then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    local sets = {'Tarot', 'Planet', 'fnaf_item'}
                    local King = pseudorandom_element(sets, 'random_consumable_set')
                    SMODS.add_card {
                        set = King ,
                        key_append = 'fnaf_king'
                    }
                    G.GAME.consumeable_buffer = 0
                    return true
                end)
            }))
            return {
                message = "GAME WIN!",
                colour = G.C.Gold,
            }
        end
    end
}

SMODS.Joker {
    key = "digi",
    blueprint_compat = true,
    rarity = 2,
    cost = 4,
    unlocked = false,
    atlas = 'Joker',
    pos = { x = 7, y = 3 },
    config = {extra = { chips = 20, } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_mod_comp", set = "Other" }
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (context.other_card.seal == "Purple" or context.other_card.seal == "Blue" or context.other_card.seal == "fnaf_vip"
                or context.other_card.seal == "fnaf_security" or context.other_card.seal == "fnaf_guard" ) then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 5 } }
    end,
    check_for_unlock = function(self, args) -- equivalent to `unlock_condition = { type = 'modify_deck', extra = { count = 3, enhancement = 'Wild Card', e_key = 'm_wild' } }`
        if args.type == 'modify_deck' then
            local count = 0
            for _, playing_card in ipairs(G.playing_cards or {}) do
                if playing_card.seal then count = count + 1 end
                if count >= 5 then
                    return true
                end
            end
        end
        return false
    end
}

SMODS.Joker {
    key = "nedd",
    blueprint_compat = true,
    rarity = 2,
    cost = 4,
    atlas = 'Joker',
    pos = { x = 8, y = 3 },
    config = {
        extra = {
                buff_description = 'k_fnaf_nobuff',
                debuff_description = 'k_fnaf_nodebuff',
                nedd_buff = 0, nedd_debuff = 0,
                chips = 400,
                mult = 50,
                xmultplier = 0.70,
                h_size = 3,
                hands = 1
            }
        },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize(card.ability.extra.buff_description, 'dictionary' ),
                localize(card.ability.extra.debuff_description, 'dictionary' )
            }
        }
    end,
    calculate = function(self, card, context)

        local chip
        local multi
        local xmulti
        local xchips

        if context.setting_blind then

            card.children.center:set_sprite_pos({x=9, y= 3})

            -- random generator
            card.ability.extra.nedd_buff = pseudorandom('neddbuff', 1, 5)
            card.ability.extra.nedd_debuff = pseudorandom('nedddebuff', 1, 5)

            while card.ability.extra.nedd_buff == card.ability.extra.nedd_debuff do
                card.ability.extra.nedd_debuff = pseudorandom('nedddebuff', 1, 5)
            end

            if card.ability.extra.nedd_buff == 4 then
                G.hand:change_size(card.ability.extra.h_size)
            elseif card.ability.extra.nedd_buff == 5 then
                ease_hands_played(card.ability.extra.hands)
            end

            -- debuff
            if card.ability.extra.nedd_debuff == 3 then
                ease_discard(-card.ability.extra.hands)
            elseif card.ability.extra.nedd_debuff == 4 then
                G.hand:change_size(-card.ability.extra.h_size)
            elseif card.ability.extra.nedd_debuff == 5 then
                ease_hands_played(-card.ability.extra.hands)
            end

            card.ability.extra.buff_description = 'k_fnaf_buff_'..tostring(card.ability.extra.nedd_buff)
            card.ability.extra.debuff_description = 'k_fnaf_debuff_'..tostring(card.ability.extra.nedd_debuff)

            return {
                message = localize('k_fnaf_buff_'..tostring(card.ability.extra.nedd_buff) ),
                colour = G.C.CHIPS,
                extra = {
                    message = localize('k_fnaf_debuff_'..tostring(card.ability.extra.nedd_debuff) ),
                    colour = G.C.RED,
                }
            }

        end

        if context.end_of_round and context.main_eval then

            Nedd_remove_buff(card.ability.extra.h_size, card.ability.extra.hands, card.ability.extra.nedd_buff, card.ability.extra.nedd_debuff )

            chip = 0
            multi = 0
            xmulti = 0
            xchips = 0

            card.children.center:set_sprite_pos({x=8, y= 3})

            card.ability.extra.buff_description = 'k_fnaf_nobuff'
            card.ability.extra.debuff_description = 'k_fnaf_nodebuff'

            return {
                message = localize('k_fnaf_reset'),
                colour = HEX('363636'),
            }
        end

        if context.joker_main then

            if card.ability.extra.nedd_buff == 1 then
                chip = card.ability.extra.chips
            elseif card.ability.extra.nedd_buff == 2 then
                multi = card.ability.extra.mult
            elseif card.ability.extra.nedd_buff == 3 then
                xmulti = 2 - card.ability.extra.xmultplier
            end

            --- debuff
            if card.ability.extra.nedd_debuff == 1 then
                xchips = card.ability.extra.xmultplier
            elseif card.ability.extra.nedd_debuff == 2 then
                xmulti = card.ability.extra.xmultplier
            end

            return {
                chips = chip,
                mult = multi,
                xmult = xmulti,
                x_chips = xchips
            }
        end
    end,
    remove_from_deck = function(self, card, from_debuff)

        Nedd_remove_buff(card.ability.extra.h_size, card.ability.extra.hands, card.ability.extra.nedd_buff, card.ability.extra.nedd_debuff )
        card.ability.extra.buff_description = 'k_fnaf_nobuff'
        card.ability.extra.debuff_description = 'k_fnaf_nodebuff'
    end
}

SMODS.Joker {
    key = "c_baby",
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    unlocked = false,
    atlas = 'Joker',
    pos = { x = 2, y = 1 },
    config = {extra = { chips = 100 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local suits = {
                ['Hearts'] = 0,
                ['Diamonds'] = 0,
                ['Spades'] = 0,
                ['Clubs'] = 0
            }
            for i = 1, #context.scoring_hand do
                if not SMODS.has_any_suit(context.scoring_hand[i]) then
                    if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then
                        suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then
                        suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0 then
                        suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0 then
                        suits["Clubs"] = suits["Clubs"] + 1
                    end
                end
            end
            for i = 1, #context.scoring_hand do
                if SMODS.has_any_suit(context.scoring_hand[i]) then
                    if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then
                        suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0 then
                        suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0 then
                        suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0 then
                        suits["Clubs"] = suits["Clubs"] + 1
                    end
                end
            end
            if suits["Hearts"] > 0 and
                suits["Diamonds"] > 0 and
                suits["Spades"] > 0 and
                suits["Clubs"] > 0 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end,
    check_for_unlock = function(self, args)
        if args.type == 'hand_contents' then
            local tally = 0
            for j = 1, #args.cards do
                if SMODS.has_enhancement(args.cards[j], 'm_wild') then
                    tally = tally + 1
                    if tally == 5 then
                        return true
                    end
                end
            end
        end
        return false
    end
}

to_big = to_big or function(x) return x end -- in case talisman is not installed

SMODS.Joker {
    key = "helpy",
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    unlocked = false,
    atlas = 'Joker',
    pos = { x = 9, y = 0 },
    config = { extra = { broke = 40 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.broke } }
    end,
    calculate = function(self, card, context)
        if G.GAME.dollars < to_big(0) and context.end_of_round and G.GAME.blind.boss and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.4)
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 1.2,
                            blockable = false,
                            func = function()
                                G.STATE = G.STATES.GAME_OVER
                                G.STATE_COMPLETE = false
                                return true
                            end
                        }))
                    return true
                end
            }))

        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.bankrupt_at = G.GAME.bankrupt_at - card.ability.extra.broke
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extra.broke
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 20 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'money' and to_big(G.GAME.dollars) == to_big(G.GAME.bankrupt_at)
    end
}

SMODS.Joker {
    key = 'r_wolf',
    atlas = 'Joker',
    pos = { x = 5, y = 4 },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = true,
    config = { extra = { seal = 'fnaf_vip' } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "fnaf_sprite_WIP", set = "Other"}
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
    end,
    calculate = function(self, card, context)
        if context.modify_scoring_hand and context.other_card:get_seal(card.ability.extra.seal) then
            return {
                add_to_hand = true
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if playing_card.seal == self.config.extra.seal then
                return true
            end
        end
        return false
    end,
}

SMODS.Joker {
    key = 'vipig',
    atlas = 'Joker',
    pos = { x = 6, y = 4 },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    eternal_compat = true,
    config = { extra = { repetitions = 1, seal = 'fnaf_vip' } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "fnaf_sprite_WIP", set = "Other"}
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play 
        and context.other_card == context.scoring_hand[1] and context.other_card.seal == card.ability.extra.seal then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if playing_card.seal == self.config.extra.seal then
                return true
            end
        end
        return false
    end,
}

SMODS.Joker {
    key = "pickles",
    atlas = 'Joker',
    pos = { x = 9, y = 1 },
    blueprint_compat = false,
    rarity = 1,
    cost = 1,
    config = { extra = { slots = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots } }
    end,

    calculate = function(self, card, context)
        if G.GAME.round_resets.blind_ante >= 38
        then
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
            G.GAME.round_resets.blind_ante = 1
            return { message = 'the pickle', colour = G.C.GREEN }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
    end
}