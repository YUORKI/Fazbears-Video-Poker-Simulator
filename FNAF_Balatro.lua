local mod_path = "" .. SMODS.current_mod.path
local files = NFS.getDirectoryItems(mod_path .. "src")
for _, file in ipairs(files) do
	if string.match(file, "%.lua$") then
		local f, err = SMODS.load_file("src/" .. file)
		assert(f, err)()
	end
end
