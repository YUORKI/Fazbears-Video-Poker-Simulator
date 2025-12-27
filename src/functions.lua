Voicelines = function(audio)
    local volume = FNAF.config.volumes
    if FNAF.config.voices then
        play_sound(audio[math.random(#audio)], nil, volume / 100 )
    end
end

