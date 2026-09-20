Voicelines = function(audio) --Voicelines for Cards
    local volume = FNAF.config.volumes
    if FNAF.config.voices then
        play_sound(audio[math.random(#audio)], nil, volume / 100 )
    end
end


Nedd_remove_buff = function(extra_h_size, extra_hands, nedd_buff, nedd_debuff)
    if nedd_buff == 4 then
        G.hand:change_size(-extra_h_size)
    elseif nedd_buff == 5 then
        ease_hands_played(-extra_hands)
    end

    if nedd_debuff == 3 then
        ease_discard(extra_hands)
    elseif nedd_debuff == 4 then
        G.hand:change_size(extra_h_size)
    elseif nedd_debuff == 5 then
        ease_hands_played(extra_hands)
    end

end

info_type = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "fnaf_" .. card.config.center.fnaf_type , set = "Other" }

    if card.config.center.fnaf_broken == true then
        info_queue[#info_queue + 1] = { key = "fnaf_Condition", set = "Other" }
    end

end

Find_type = function(type, card)
  local found = {}
  if G.jokers and G.jokers.cards then
    for k, v in pairs(G.jokers.cards) do
      if v.config.center.fnaf_type == type then
        table.insert(found, v)
      end
    end
  end
  return found
end


-- Glossary for Types of Cards
--- Animatronics
--- Humans
--- ??? (Other)
--- Misc

FNAF_BALATRO.fnaf_remnant = {
    --- Returns the first non-debuffed remnant card with a specified key, nil if none qualify
    --- @return table | nil # Balatro card object of activated remnant Tape, or nil
    find_active_remn = function(key)
        local remnant = SMODS.find_card(key)
        if remnant and #remnant > 0 then
            for _, v in ipairs(remnant) do
                if not v.debuff and v.ability.activated then
                    return v
                end
            end
        end

        return nil
    end,

    --- Gets the number of remnant cards in the consumable slots
    --- @return number
    get_remn_count = function()
        if not G.consumeables then return 0 end
        local count = 0
        for i, v in ipairs(G.consumeables.cards) do
            if v.ability.set == "fnaf_remnant" then
                count = count+1
            end
        end
        return count
    end,

    --- activates the remnant cards
    --- @param card Card 
    activ_remn = function(card)
        if not card.ability.activation then return end

        if card.ability.activated then
            card.ability.activated = false
        else
            card.ability.activated = true
        end
    end,

    run_remn = function(card, loc_str, mod)
        card.ability.uses = card.ability.uses + (mod or 1)
        if card.ability.uses >= card.ability.runtime then
            FNAF_BALATRO.fnaf_remnant.remove_rem(card)
        else
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = "Gone",
                colour = G.C.remnant,
                sound = 'tarot1',
                delay = 0.45,
            })
        end
    end,

    --- Destroys a remnant tape and calls all relevant contexts
    --- @param card Card
    --- @param delay_time number Event delay in seconds
    --- @param silent boolean | nil Plays tarot sound effect on destruction if true
    --- @param loc_message string | nil Custom loc string for destruction message, defaults to 'k_remnant_destroyed'
    remove_rem = function(card, delay_time, ach, silent, loc_message)
        card.ability.destroyed = true
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = delay_time,
            func = function()
                play_sound('generic1')

                delay(0.15)

                if not silent then
                    play_sound('tarot1')
                end
                card.T.r = -0.1
                card:juice_up(0.3, 0.4)
                card.states.drag.is = true
                card.children.center.pinch.x = true

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    blockable = false,
                    func = function()
                        if card.config.center.activate and type(card.config.center.activate) == 'function' then
                            card.config.center.activate(card.config.center, card, false)
                        end

                        SMODS.calculate_context({remnant_death = true, card = card})

                        card:remove()
                        return true
                    end
                }))
                if ach then
                    check_for_unlock({ type = ach })
                end
                return true
            end
        }))
    end
}

local ref_set_ability = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    local ret = ref_set_ability(self, center, initial, delay_sprites)

    if self.ability.set == 'fnaf_remnant' then
        self.ability.activation = true
        self.ability.activated = false
        self.ability.destroyed = false
        self.ability.runtime = center.runtime or 3
        self.ability.uses = 0
    end

    return ret
end

local ref_use_card = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
    local card = e.config.ref_table
    if card.area == G.consumeables and (card.ability.activation or (card.config.center.activate and type(card.config.center.activate) == 'function')) then
        if card.config.center.activate and type(card.config.center.activate) == 'function' then
            card.config.center.activate(card.config.center, card, not card.ability.activated)
        end

        if card.ability.activation then
            FNAF_BALATRO.fnaf_remnant.activ_remn(card)
            if G.CONTROLLER.HID.controller then
                card.children.focused_ui = G.UIDEF.card_focus_ui(card)
                G.CONTROLLER.locks.use = false
            else
                card:highlight(true)
            end
        end

        return
    end

    return ref_use_card(e, mute, nosave)
end
