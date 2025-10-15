local function create_config_node(config_name)
    return
    {n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
        {n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
            create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = config, ref_value = config_name },
        }},
        {n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
            { n = G.UIT.T, config = { text = localize('lobc_'..config_name), scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
        }},
    }}
end

SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT, config = {r = 0.1, align = "c", padding = 0.1, colour = G.C.BLACK, minh = 6}, nodes = {
        {n = G.UIT.R, config = {align = "tm", padding = 0}, nodes = {
            {n = G.UIT.C, config = {align = "t", padding = 0.1}, nodes = {
                create_config_node("setting_1"),
            }},
        }},
    }}
end