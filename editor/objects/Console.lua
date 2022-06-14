Console = Object:extend()

function Console:new()
	self.buffer = {}
end

function Console:log(text)
	local time = os.date("[%H:%M:%S]   ")

	table.insert(self.buffer, time .. text)
end

function Console:draw()
	for _, log in pairs(self.buffer) do
		imgui.Text(log)
	end
end