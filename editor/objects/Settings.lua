Settings = Object:extend()

function Settings:new()
	self.name = ffi.new("char[?]", 50)
	self.run = ffi.new("char[?]", 50)
	self.edit = ffi.new("char[?]", 50)

	self.settings = self:get()
end

function Settings:get()
	return binser.deserializeN(lf.read(state.current().project .. "lovely.project"))
end

function Settings:draw()
	imgui.Text(self.settings.name)
	imgui.InputText("Project Name", self.name, 50)
	imgui.Text(self.settings.run)
	imgui.InputText("Run Command", self.run, 50)
	imgui.Text(self.settings.edit)
	imgui.InputText("Edit Command", self.edit, 50)

	imgui.Separator()

	if imgui.Button("Save") then
		local name = ""
		local run = ""
		local edit = ""

		if ffi.string(self.name) == "" then
			name = self.settings.name
		else
			name = ffi.string(self.name)
		end

		if ffi.string(self.run) == "" then
			run = self.settings.run
		else
			run = ffi.string(self.run)
		end

		if ffi.string(self.edit) == "" then
			edit = self.settings.edit
		else
			edit = ffi.string(self.edit)
		end

		local settingsTable = {
			name = name,
			run = run,
			edit = edit,
		}

		lf.write(state.current().project .. "lovely.project", binser.serialize(settingsTable))

		self.settings = self:get()
	end
end