SMODS.ConsumableType {
    key = 'fnaf_remnant',

    loc_txt = {
        collection = 'Remnant Cards',
        name = 'Remnant',
        undiscovered = {
            name = 'Not Discovered',
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
            },
        },
    },

    pools = {
 		['fnaf_remnant'] = true,
 	},

    default = "c_fnaf_meltedhead",

    primary_colour = G.C.REMN,
    secondary_colour = G.C.REMN,
    collection_rows = { 4, 4 },

    shop_rate = 0
}

SMODS.UndiscoveredSprite{
    key = 'fnaf_remnant',
    atlas = 'RemnantFnaf',
    pos = {x = 9, y = 2}
}

Draw_remn = function(card, scale_mod, rotate_mod)
    if card ~= G.CONTROLLER.hovering.target and card ~= G.CONTROLLER.focused.target then
        card.children.floating_sprite:draw_shader('dissolve',0, nil, nil, card.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
        card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
    else
        if card.ability.activated then
            card.children.floating_sprite:draw_shader('dissolve',0, nil, nil, card.children.center,scale_mod, rotate_mod,nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
            card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        end
    end
end

SMODS.Consumable{
    key = 'meltedhead',
    set = 'fnaf_remnant',
    atlas = 'RemnantFnaf',
    pos = {x = 0, y = 0},
    soul_pos = {x = 0, y = 1,
        draw = Draw_remn
    },
    config = { extra = { chips = 20, usages = 6, uses = 0, } },
    activated = false,
    destroyed = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "fnaf_remnant_info", set = "Other"}
        return { vars = { card.ability.extra.chips, card.ability.extra.usages, card.ability.extra.uses } }
    end,

    calculate = function(self, card, context)
        if card.ability.activated and context.other_joker and
        context.other_joker.config.center.fnaf_type == 'Animatronic' then
            return {
                chips = card.ability.extra.chips,
            }
        end
        local bad_context = context.repetition or context.individual or context.blueprint
        if context.after and not card.ability.destroyed and card.ability.activated and not bad_context then
            FNAF_BALATRO.fnaf_remnant.run_remn(card, 1)
        end
    end,

    can_use = function(self, card)
        local joker_anim = #Find_type("Animatronic", card)
        if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or
        card.area == G.consumeables then
            if joker_anim > 0 then
                return true
            end
        end
    end,
}

SMODS.Consumable{
    key = 'discolored',
    set = 'fnaf_remnant',
    atlas = 'RemnantFnaf',
    pos = {x = 1, y = 0},
    soul_pos = {x = 1, y = 1,
        draw = Draw_remn
    },
    config = { extra = { usages = 4, uses = 0, } },
    activated = false,
    destroyed = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "fnaf_remnant_info", set = "Other"}
        return { vars = { card.ability.extra.usages, card.ability.extra.uses } }
    end,

    calculate = function(self, card, context)
        if context.after and not card.ability.destroyed and card.ability.activated then
            FNAF_BALATRO.fnaf_remnant.run_remn(card, 1)
        end
    end,

    can_use = function(self, card)
        if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or
        card.area == G.consumeables then
            return true
        end
    end
}

local smods_smeared_check_ref = SMODS.smeared_check
function SMODS.smeared_check(card, suit, ...)
    if FNAF_BALATRO.fnaf_remnant.find_active_remn("c_fnaf_discolored") then
        if ((card.base.suit == 'Hearts' or card.base.suit == 'Spades') and (suit == 'Hearts' or suit == 'Spades')) then
            return true
        end
    end
    return smods_smeared_check_ref(card, suit, ...)
end

SMODS.Consumable{
    key = 'starpack',
    set = 'fnaf_remnant',
    atlas = 'RemnantFnaf',
    pos = {x = 2, y = 0},
    soul_pos = {x = 2, y = 1,
        draw = Draw_remn
    },
    config = { extra = { usages = 4, uses = 0, seal = 'Blue' } },
    activated = false,
    destroyed = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "fnaf_remnant_info", set = "Other"}
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.extra.usages, card.ability.extra.uses } }
    end,

    calculate = function(self, card, context)
        local bad_context = context.repetition or context.individual or context.blueprint
        local count = 0
        if context.after and not card.ability.destroyed and card.ability.activated and not bad_context then
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card.seal == card.ability.extra.seal and not scored_card.debuff and not scored_card.vampired then
                    count = count + 1
                end
            end

            if count > 0 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('timpani')
                        SMODS.add_card({ set = 'Planet', })
                        card:juice_up(0.3, 0.5)
                        FNAF_BALATRO.fnaf_remnant.run_remn(card, 1)
                        return true
                    end
                }))
            end
        end
        if not card.ability.activated then
            card.children.center:set_sprite_pos({x=6, y= 0})
        end
    end,

    can_use = function(self, card)
        if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or
        card.area == G.consumeables then
            return true
        end
    end
}

SMODS.Consumable{
    key = 'greed',
    set = 'fnaf_remnant',
    atlas = 'RemnantFnaf',
    pos = {x = 3, y = 0},
    soul_pos = {x = 3, y = 1,
        draw = Draw_remn
    },
    config = { extra = { usages = 4, uses = 0, dollars = 1 } },
    activated = false,
    destroyed = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "fnaf_remnant_info", set = "Other"}
        info_queue[#info_queue+1] = {key = "fnaf_sprite_WIP", set = "Other"}
        return { vars = { card.ability.extra.usages, card.ability.extra.uses, card.ability.extra.dollars } }
    end,

    calculate = function(self, card, context)
        local bad_context = context.repetition or context.individual or context.blueprint
        local count = 0
        if context.after and not card.ability.destroyed and card.ability.activated and not bad_context then
            for _, scored_card in ipairs(context.scoring_hand) do
                if not scored_card.debuff and not scored_card.vampired then
                    count = count + 1
                end
            end

            if count > 0  then
                return {
                    dollars = card.ability.extra.dollars * count,
                    FNAF_BALATRO.fnaf_remnant.run_remn(card, 1)
                }
            end
        end
    end,

    can_use = function(self, card)
        if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or
        card.area == G.consumeables then
            return true
        end
    end
}

SMODS.Consumable{
    key = 'Fortnite_Remnant',
    set = 'fnaf_remnant',
    atlas = 'RemnantFnaf',
    pos = {x = 4, y = 0},
    soul_pos = {x = 4, y = 1,
        draw = Draw_remn
    },
    config = { extra = { usages = 4, uses = 0, repetitions = 1 } },
    activated = false,
    destroyed = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "fnaf_remnant_info", set = "Other"}
        info_queue[#info_queue + 1] = G.P_CENTERS.m_fnaf_glitch
        return { vars = { card.ability.extra.usages, card.ability.extra.uses, card.ability.extra.repetitions, localize { type = 'name_text', set = 'Enhanced', key = 'm_fnaf_glitch' } } }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and card.ability.activated then
            if SMODS.has_enhancement(context.other_card, "m_fnaf_glitch") then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
        local bad_context = context.repetition or context.individual or context.blueprint
        local rept = 0
        if context.after and not card.ability.destroyed and card.ability.activated and not bad_context then
            for _, scored_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(scored_card, "m_fnaf_glitch") and not scored_card.debuff and not scored_card.vampired then
                    rept = rept + 1
                end
            end

            if rept > 0  then
                return {
                    FNAF_BALATRO.fnaf_remnant.run_remn(card, 1)
                }
            end
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, "m_fnaf_glitch") then
                return true
            end
        end
        return false
    end,
    can_use = function(self, card)
        if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or
        card.area == G.consumeables then
            return true
        end
    end
}

SMODS.Consumable{
    key = 'discount',
    set = 'fnaf_remnant',
    atlas = 'RemnantFnaf',
    pos = {x = 5, y = 0},
    soul_pos = {x = 5, y = 1,
        draw = Draw_remn
    },
    config = { extra = { usages = 3, uses = 0, perc = 20 } },
    activated = false,
    destroyed = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "fnaf_remnant_info", set = "Other"}
        info_queue[#info_queue+1] = {key = "fnaf_sprite_WIP", set = "Other"}
        return { vars = { card.ability.extra.usages, card.ability.extra.uses, card.ability.extra.perc } }
    end,

    calculate = function(self, card, context)
        local bad_context = context.repetition or context.individual or context.blueprint
        if context.setting_blind and not card.ability.destroyed and card.ability.activated and not bad_context then
            G.GAME.blind.chips = G.GAME.blind.chips - ((card.ability.extra.perc / 100) * G.GAME.blind.chips)
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            FNAF_BALATRO.fnaf_remnant.run_remn(card, 1)
            return {
                message = '-20% score',
                colour = G.C.ORANGE,
            }
        end
    end,

    can_use = function(self, card)
        if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or
        card.area == G.consumeables then
            return true
        end
    end
}

SMODS.Consumable{
    key = 'remnmisc',
    set = 'fnaf_remnant',
    atlas = 'RemnantFnaf',
    pos = {x = 6, y = 0},
    soul_pos = {x = 6, y = 1,
        draw = Draw_remn
    },
    config = { extra = { mult = 10, usages = 6, uses = 0, } },
    activated = false,
    destroyed = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "fnaf_remnant_info", set = "Other"}
        info_queue[#info_queue+1] = {key = "fnaf_sprite_WIP", set = "Other"}
        return { vars = { card.ability.extra.mult, card.ability.extra.usages, card.ability.extra.uses } }
    end,

    calculate = function(self, card, context)
        if card.ability.activated and context.other_joker and
        context.other_joker.config.center.fnaf_type == 'Misc' then
            return {
                mult = card.ability.extra.mult,
            }
        end
        local bad_context = context.repetition or context.individual or context.blueprint
        if context.after and not card.ability.destroyed and card.ability.activated and not bad_context then
            FNAF_BALATRO.fnaf_remnant.run_remn(card, 1)
        end
    end,

    can_use = function(self, card)
        local joker_anim = #Find_type("Misc", card)
        if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or
        card.area == G.consumeables then
            if joker_anim > 0 then
                return true
            end
        end
    end,
}

SMODS.Consumable{
    key = 'remntarot',
    set = 'fnaf_remnant',
    atlas = 'RemnantFnaf',
    pos = {x = 7, y = 0},
    soul_pos = {x = 7, y = 1,
        draw = Draw_remn
    },
    config = { extra = { usages = 4, uses = 0, } },
    activated = false,
    destroyed = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "fnaf_remnant_info", set = "Other"}
        info_queue[#info_queue+1] = {key = "fnaf_sprite_WIP", set = "Other"}
        return { vars = { card.ability.extra.usages, card.ability.extra.uses } }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.config.center.key == "c_magician" then
            FNAF_BALATRO.fnaf_remnant.run_remn(card, 1)
        end
    end,

    can_use = function(self, card)
        if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or
        card.area == G.consumeables then
            return true
        end
    end
}