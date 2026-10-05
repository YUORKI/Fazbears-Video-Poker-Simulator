---@diagnostic disable: undefined-global
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
    collection_rows = { 6, 6 },
    stack = false,
    divide = false,

    shop_rate = 4
}

SMODS.UndiscoveredSprite{
    key = 'fnaf_item',
    atlas = 'TarotFnaf',
    pos = {x = 0, y = 2}
}

SMODS.Consumable{
    key = 'meltedhead',
    set = 'fnaf_remnant',
    atlas = 'TarotFnaf',
    pos = {x = 4, y = 0},
    config = { extra = { chips = 20, usages = 6, uses = 0, } },
    activated = false,
    destroyed = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "fnaf_remnant_info", set = "Other"}
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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
    atlas = 'TarotFnaf',
    pos = {x = 5, y = 0},
    config = { extra = { usages = 4, uses = 0, } },
    activated = false,
    destroyed = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "fnaf_remnant_info", set = "Other"}
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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
    atlas = 'TarotFnaf',
    pos = {x = 6, y = 0},
    config = { extra = { usages = 4, uses = 0, seal = 'Blue'} },
    activated = false,
    destroyed = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "fnaf_remnant_info", set = "Other"}
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        info_queue[#info_queue + 1] = { key = "fnaf_sprite_WIP", set = "Other" }
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

            if count == 5 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
    end,

    can_use = function(self, card)
        if to_big(#G.consumeables.cards) < to_big(G.consumeables.config.card_limit) or
        card.area == G.consumeables then
            return true
        end
    end
}