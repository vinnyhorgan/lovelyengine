Filesystem = Object:extend()

function Filesystem:new()
	self.path = {}
	self.items = {}
end

function Filesystem:draw()
	local currentPath = ""

	for _, item in pairs(self.path) do
		currentPath = currentPath .. item .. "/"
	end

	currentPath = "project/" .. currentPath

	print(currentPath)

	self.items = lf.getDirectoryItems(currentPath)

	if imgui.Button("..") then
		pop(self.path)
	end

	for _, file in pairs(self.items) do
		local filetype = lf.getInfo(currentPath .. file).type
		local scene = string.sub(file, -5) == "scene"

		if scene then
			if imgui.Button(file) then
				state.current().sceneManager:load(currentPath .. file)
			end
		else
			if filetype == "file" then
				imgui.Text(file)
			elseif filetype == "directory" then
				if imgui.Button(file) then
					table.insert(self.path, file)
				end
			end
		end
	end
end