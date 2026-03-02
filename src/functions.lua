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