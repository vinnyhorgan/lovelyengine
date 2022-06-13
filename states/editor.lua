editor = {}

function editor:enter()
	-- GUI
	imgui.love.Init()
	self.io = imgui.GetIO()

	self.io["ConfigFlags"] = imgui.love.ConfigFlags("DockingEnable")

	self.showAbout = ffi.new("bool[1]")

	-- SCENES
	self.currentScene = nil
	self.saveScene = false
	self.saveInput = ffi.new("char[?]", 10)
end

function editor:update(dt)
	-- GUI
	imgui.love.Update(dt)
	imgui.NewFrame()
end

function editor:draw()
	-- GUI
	imgui.DockSpaceOverViewport()

	if imgui.BeginMainMenuBar() then
		if imgui.BeginMenu("File") then
			if imgui.MenuItem_Bool("New Scene") then
				self.currentScene = Scene()
			end

			if imgui.MenuItem_Bool("Save Scene") then
				self.saveScene = true
			end

			if imgui.MenuItem_Bool("Exit") then
				love.event.push("quit")
			end

			imgui.EndMenu()
		end

		if imgui.BeginMenu("Help") then
			if imgui.MenuItem_Bool("About") then
				self.showAbout[0] = true
			end

			imgui.EndMenu()
		end

		imgui.EndMainMenuBar()
	end

	imgui.ShowDemoWindow()

	if (self.showAbout[0]) then
		if imgui.Begin("About", self.showAbout, imgui.love.WindowFlags("NoDocking", "NoResize", "NoSavedSettings")) then
			imgui.Text("Lovely Engine Alpha")
			imgui.Separator()
			imgui.Text("MIT LICENSE 2022")
		end
		imgui.End()
	end

	if self.currentScene and not self.currentScene.saved then
		imgui.Begin("Scene", nil, imgui.love.WindowFlags("UnsavedDocument"))
	else
		imgui.Begin("Scene")
	end

	if self.currentScene then
		imgui.Text("Name: " .. self.currentScene.name)

		if self.saveScene then
			imgui.OpenPopup_Str("Save")
			self.saveScene = false
		end

		if imgui.BeginPopupModal("Save") then
			imgui.Text("Scene name:")

			imgui.InputText("savename", self.saveInput, 10)

			if imgui.Button("Close") then
				self.currentScene.name = ffi.string(self.saveInput)
				self.currentScene.saved = true

				love.filesystem.createDirectory("scenes")
				love.filesystem.write("scenes/" .. self.currentScene.name .. ".scene", binser.serialize(self.currentScene))

				imgui.CloseCurrentPopup()
			end

			imgui.EndPopup()
		end
	else
		imgui.TextWrapped("No scene selected! Create a new one from the menu bar or by clicking this button.")

		if imgui.Button("New Scene") then
			self.currentScene = Scene()
		end
	end

	imgui.End()

	imgui.Render()
	imgui.love.RenderDrawLists()
end

-- Love2d callbacks

function editor:mousemoved(x, y, ...)
	imgui.love.MouseMoved(x, y)
	if not imgui.love.GetWantCaptureMouse() then

	end
end

function editor:mousepressed(x, y, button, ...)
	imgui.love.MousePressed(button)
	if not imgui.love.GetWantCaptureMouse() then

	end
end

function editor:mousereleased(x, y, button, ...)
	imgui.love.MouseReleased(button)
	if not imgui.love.GetWantCaptureMouse() then

	end
end

function editor:wheelmoved(x, y)
	imgui.love.WheelMoved(x, y)
	if not imgui.love.GetWantCaptureMouse() then

	end
end

function editor:keypressed(key, ...)
	imgui.love.KeyPressed(key)
	if not imgui.love.GetWantCaptureKeyboard() then

	end
end

function editor:keyreleased(key, ...)
	imgui.love.KeyReleased(key)
	if not imgui.love.GetWantCaptureKeyboard() then

	end
end

function editor:textinput(t)
	if imgui.love.GetWantCaptureKeyboard() then
		imgui.love.TextInput(t)
	else

	end
end

function editor:quit()
	return imgui.love.Shutdown()
end