function randomString(length)
	local s = ""

	for i = 1, length do
		s = s .. string.char(math.random(97, 122))
	end

	return s
end

function removeFromTable(tab, item)
	for k, v in pairs(tab) do
		if v == item then
			table.remove(tab, k)
		end
	end
end

function pop(tab)
	table.remove(tab, #tab)
end