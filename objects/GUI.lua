GUI = Object:extend()

function GUI:new()
	imgui.love.Init()
	self.io = imgui.GetIO()

	self.io["ConfigFlags"] = imgui.love.ConfigFlags("DockingEnable")

	self.showAbout = ffi.new("bool[1]")
end

function GUI:update(dt)
	imgui.love.Update(dt)
	imgui.NewFrame()
end

function GUI:draw()
	imgui.DockSpaceOverViewport()

	if imgui.BeginMainMenuBar() then
		if imgui.BeginMenu("File") then
			if imgui.MenuItem_Bool("New Scene") then

			end

			if imgui.MenuItem_Bool("Save Scene") then

			end

			if imgui.MenuItem_Bool("New Entity") then

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

	if (self.showAbout[0]) then
		if imgui.Begin("About", self.showAbout, imgui.love.WindowFlags("NoDocking", "NoResize", "NoSavedSettings")) then
			imgui.Text("Lovely Engine Alpha")
			imgui.Separator()
			imgui.Text("MIT LICENSE 2022")
		end
		imgui.End()
	end

	if imgui.Begin("Scene") then
		state:current().sceneManager:draw()
	end
	imgui.End()

	if imgui.Begin("Inspector") then
		state:current().entityManager:draw()
	end
	imgui.End()

	if imgui.Begin("Console") then
		state:current().console:draw()
	end
	imgui.End()

	if imgui.Begin("Viewport") then
		-- TODO
	end
	imgui.End()

	imgui.Render()
	imgui.love.RenderDrawLists()
end

function GUI:mousemoved(x, y)
	imgui.love.MouseMoved(x, y)
end

function GUI:mousepressed(x, y, button)
	imgui.love.MousePressed(button)
end

function GUI:mousereleased(x, y, button)
	imgui.love.MouseReleased(button)
end

function GUI:wheelmoved(x, y)
	imgui.love.WheelMoved(x, y)
end

function GUI:keypressed(key)
	imgui.love.KeyPressed(key)
end

function GUI:keyreleased(key)
	imgui.love.KeyReleased(key)
end

function GUI:textinput(t)
	imgui.love.TextInput(t)
end

function GUI:quit()
	return imgui.love.Shutdown()
end