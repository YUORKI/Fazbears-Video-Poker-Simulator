local INI = {};

function INI.parse(file)
	local fstruct = {
		data = {},
		get = function (self, key)
			return self.data[key]
		end,
		set = function (self, key, value)
			self.data[key] = value
			return self
		end
	};
	fstruct.mt.__index		= fstruct.data
	fstruct.mt.__newindex	= fstruct.data
	for k, v in string.gmatch(file, "(%w+)=(%w+)") do
		fstruct[k] = v
	end
	return fstruct
end

return INI

-- Example: INI.parse(<loaded text file>).hs
-- shoutout to LasagnaCake for the help https://lasagnacake.github.io/

-- ok so this file is not working

-- I fucking hate scott for not programing a "normal" save file system
-- fuck him

-- oh ok so I can't import a text file so I gonna do this manualy
-- so this entire file is useless them

