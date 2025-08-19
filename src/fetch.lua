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