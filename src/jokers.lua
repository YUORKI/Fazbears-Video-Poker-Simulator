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
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
    end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.add_card('j_fnaf_balloon_boy')
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
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
        return { vars = { card.ability.extra.x_chips, center.ability.extra.round, center.ability.extra.maxround}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local bb_voice = math.random(1, 3)
            return {
                x_chips = card.ability.extra.x_chips,
                func = function()
                    if (pseudorandom('fnaf_bb_voice') < 1 / 3) then
                        card:juice_up(0.1, 0.2)
                        if bb_voice == 1 then
                            play_sound('fnaf_bb_voice1')
                        elseif bb_voice == 2 then
                            play_sound('fnaf_bb_voice2')
                        elseif bb_voice == 3 then
                            play_sound('fnaf_bb_voice3')
                        end
                    end
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
}


SMODS.Joker {
    key = 'pizzabot',
    atlas = 'Joker',
    pos = { x = 5, y = 0 },
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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
    pos = { x = 6, y = 1 },
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
                        play_sound('fnaf_DeeDee1')
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
    pos = { x = 5, y = 1 },
    blueprint_compat = false,
    rarity = 3,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_fnaf_glitch
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local faces = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                scored_card:set_ability('m_fnaf_glitch', nil, true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        scored_card:juice_up()
                        return true
                    end
                }))
            end
            return { 
                message = 'Glitched',
                colour = G.C.PURPLE,                
                func = function()
                    if (pseudorandom('fnaf_freddy_scored') < 1 / 20) then
                        sound = 'fnaf_Glitchtrap_summon'
                    end
                end
            }
        end
    end
}

SMODS.Joker {
    key = "cassie",
    atlas = 'Joker',
    pos = { x = 5, y = 4 },
    blueprint_compat = true,
    rarity = 2,
    cost = 4,
    config = { extra = { odds = 3 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
        info_queue[#info_queue + 1] = { key = "fnaf_code_WIP", set = "Other" }
        return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if context.using_consumeable and not context.blueprint
                and context.consumeable.ability.set == 'fnaf_item' and (pseudorandom('fnaf_cassie') < G.GAME.probabilities.normal / card.ability.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'fnaf_item',
                            key_append = 'fnaf_cassie'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = "+1 Item"
                }
            end
        end
    end,
}

SMODS.Joker {
    key = "jackie",
    atlas = 'Joker',
    pos = { x = 8, y = 0 },
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    config = { extra = { cards = 3 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
        return { vars = { card.ability.extra.cards } }
    end,
    calculate = function(self, card, context)
        if context.drawing_cards and G.GAME.current_round.hands_left == 1 then
            for i = 1, card.ability.extra.cards do
                draw_card(G.deck, G.hand, 100, 'up', true)
            end
        end
    end,
}

SMODS.Joker {
    key = "logbook",
    atlas = 'Joker',
    pos = { x = 5, y = 5 },
    blueprint_compat = false,
    rarity = 3,
    cost = 7,
    config = { extra = { seal = 'fnaf_guard' } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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
    pos = { x = 0, y = 2 },
    blueprint_compat = false,
    rarity = 2,
    cost = 7,
    config = { extra = { xmult = 1, xmult_gain = 0.1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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
                        vars = { card.ability.extra.xmult } 
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
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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
    pos = { x = 7, y = 2 },

    blueprint_compat = false,
    rarity = 3,
    cost = 9,
    config = { extra = { odds = 20 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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

    blueprint_compat = false,
    rarity = 2,
    cost = 7,
    config = { extra = { Xmult_gain = 0.15, Xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
        return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local enhanced = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(scored_card, "m_fnaf_pizza") and not scored_card.debuff and not scored_card.vampired then
                    enhanced[#enhanced + 1] = scored_card
                    play_sound('fnaf_GlamChica_Pizza')
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
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end,
}

SMODS.Joker {
    key = "pickles",
    atlas = 'Joker',
    pos = { x = 1, y = 5 },
    blueprint_compat = false,
    rarity = 1,
    cost = 1,
    config = { extra = { slots = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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

SMODS.Joker {
    key = "s_puppet",
    atlas = 'Joker',
    pos = { x = 4, y = 3 },

    blueprint_compat = false,
    rarity = 3,
    cost = 8,
    config = { extra = { seal = 'fnaf_security' } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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
                    context.other_card:set_seal(card.ability.extra.seal, nil, true)
                    return {
                        message = 'Secured',
                        colour = G.C.GREEN
                    }
                end
            end
        end
    end,
}

SMODS.Joker {
    key = "toy_chica",
    atlas = 'Joker',
    pos = { x = 7, y = 3 },

    blueprint_compat = false,
    rarity = 2,
    cost = 3,
    config = { extra = { chips = 0, chip_mod = 30 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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
}

SMODS.Joker {
    key = "r_freddy",
    atlas = 'Joker',
    pos = { x = 7, y = 1 },

    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    config = { extra = { seal = 'Gold', chips_mod = 25, chips = 0 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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
    end
}


SMODS.Joker {
    key = "m_hippo",
    atlas = 'Joker',
    pos = { x = 9, y = 1 },

    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    config = { extra = { poker_hand = 'Flush House', poker_hand2 = 'Five of a Kind', poker_hand3 = 'Flush Five' } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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
}

SMODS.Joker {
    key = "missing",
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = 'Joker',
    pos = { x = 1, y = 4 },
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
    pos = { x = 2, y = 4 },

    config = { extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
    end,
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
                    sound = 'fnaf_Orville01',
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
    rarity = 2,
    cost = 5,
    atlas = 'Joker',
    pos = { x = 3, y = 5 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
    end,
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
    key = "rock_chica",
    blueprint_compat = false,
    rarity = 3,
    cost = 7,
    atlas = 'Joker',
    pos = { x = 8, y = 4 },
    config = { extra = { hands_left = 10 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
        return { vars = { card.ability.extra.hands_left } }
    end,
}

SMODS.Joker {
    key = "time_clock",
    blueprint_compat = true,
    rarity = 1,
    cost = 3,
    atlas = 'Joker',
    pos = { x = 0, y = 5 },
    config = { extra = { chips = 100 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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
    atlas = 'Joker',
    pos = { x = 3, y = 4 },
    config = { extra = { chip_mod = 50 }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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
}

SMODS.Joker {
    key = "c_baby",
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    atlas = 'Joker',
    pos = { x = 5, y = 2 },
    config = {extra = { chips = 100 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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
    end
}

to_big = to_big or function(x) return x end -- in case talisman is not installed

SMODS.Joker {
    key = "helpy",
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    atlas = 'Joker',
    pos = { x = 9, y = 0 },
    config = { extra = { broke = 40 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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
}

