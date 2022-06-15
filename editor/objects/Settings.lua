Settings = Object:extend()

function Settings:new()
	self.name = ffi.new("char[?]", 50)
	self.run = ffi.new("char[?]", 50)
	self.edit = ffi.new("char[?]", 50)
	self.main = ffi.new("char[?]", 50)

	self.settings = self:get() or {name = "", run = "", edit = "", main = ""}
end

function Settings:get()
	local settings = lf.read(state.current().project .. "lovely.project")

	if settings then
		return binser.deserializeN(settings)
	end
end

function Settings:draw()
	imgui.Text(self.settings.name)
	imgui.InputText("Project Name", self.name, 50)
	imgui.Text(self.settings.run)
	imgui.InputText("Run Command", self.run, 50)
	imgui.Text(self.settings.edit)
	imgui.InputText("Edit Command", self.edit, 50)
	imgui.Text(self.settings.main)
	imgui.InputText("Main Scene", self.main, 50)

	imgui.Separator()

	if imgui.Button("Save") then
		local name = ""
		local run = ""
		local edit = ""
		local main = ""

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

		if ffi.string(self.main) == "" then
			main = self.settings.main
		else
			main = ffi.string(self.main)
		end

		local settingsTable = {
			name = name,
			run = run,
			edit = edit,
			main = main
		}

		lf.write(state.current().project .. "lovely.project", binser.serialize(settingsTable))

		self.settings = self:get()
	end
end