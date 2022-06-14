GUI = Object:extend()

function GUI:new()
	imgui.love.Init()
	self.io = imgui.GetIO()

	self.io["ConfigFlags"] = imgui.love.ConfigFlags("DockingEnable")

	self.showSettings = ffi.new("bool[1]")
	self.showAbout = ffi.new("bool[1]")
end

function GUI:update(dt)
	imgui.love.Update(dt)
	imgui.NewFrame()
end

function GUI:draw()
	imgui.DockSpaceOverViewport()

	if imgui.BeginMainMenuBar() then
		if imgui.BeginMenu("System") then
			if imgui.MenuItem_Bool("Run") then
				if state.current().sceneManager.current then
					local runCommand = state.current().settings:get().run

					if runCommand then
						os.execute(runCommand)
					else
						state.current().console:log("Command not defined in settings: run")
					end
				else
					state.current().console:log("Cannot run: no scene selected")
				end
			end

			if imgui.MenuItem_Bool("Edit") then
				local editCommand = state.current().settings:get().edit

				if editCommand then
					print(lf.getSaveDirectory() .. "/scripts")
					os.execute(editCommand .. " " .. lf.getSaveDirectory() .. "/scripts")
				else
					state.current().console:log("Command not defined in settings: edit")
				end
			end

			if imgui.MenuItem_Bool("Project Settings") then
				self.showSettings[0] = true
				state.current().console:log("Opened window: Project Settings")
			end

			if imgui.MenuItem_Bool("Exit") then
				le.push("quit")
			end

			imgui.EndMenu()
		end

		if imgui.BeginMenu("Scene") then
			if imgui.MenuItem_Bool("New") then
				state.current().sceneManager:newScene()
			end

			if imgui.MenuItem_Bool("Save") then
				state.current().sceneManager:save()
			end

			imgui.EndMenu()
		end

		if imgui.BeginMenu("Entity") then
			if imgui.MenuItem_Bool("New") then
				state.current().entityManager:newEntity()
			end

			if imgui.BeginMenu("Add Component") then
				for _, component in pairs(state.current().entityManager.componentList) do
					if imgui.MenuItem_Bool(component.name) then
						state.current().entityManager:addComponent(component)
					end
				end

				imgui.EndMenu()
			end

			imgui.EndMenu()
		end

		if imgui.BeginMenu("Help") then
			if imgui.MenuItem_Bool("About") then
				self.showAbout[0] = true
				state.current().console:log("Opened window: About")
			end

			imgui.EndMenu()
		end

		imgui.EndMainMenuBar()
	end

	if (self.showSettings[0]) then
		if imgui.Begin("Project Settings", self.showSettings, imgui.love.WindowFlags("NoDocking")) then
			state.current().settings:draw()
		end
		imgui.End()
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
		state.current().sceneManager:draw()
	end
	imgui.End()

	if imgui.Begin("Inspector") then
		state.current().entityManager:draw()
	end
	imgui.End()

	if imgui.Begin("Console") then
		state.current().console:draw()
	end
	imgui.End()

	if imgui.Begin("Filesystem") then
		state.current().filesystem:draw()
	end
	imgui.End()

	if imgui.Begin("Viewport") then
		state.current().viewport:draw()
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