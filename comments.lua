--[[ function game:loadScene(name)
	local scene = binser.deserializeN(love.filesystem.read("scenes/" .. name .. ".scene"))

	print(inspect(self.editor.currentScene) == inspect(scene))
end ]]

--[[ 	self.scenes = {}

	self.currentScene = nil
	self.currentEntity = nil

	self.saveDialog = false
	self.noSceneDialog = false
	self.noImageDialog = false

	self.componentSelection = false

	self.textures = {}


	self:loadScenes()

	imgui.love.Init()

	io = imgui.GetIO()

	io["ConfigFlags"] = bit.bor(io["ConfigFlags"], imgui.ImGuiConfigFlags_DockingEnable)


	self.about = false

	self.wtf = ffi.new("bool[1]")

	self.testPlayer = {
		x = 10,
		y = 10
	}


	self.canvas = love.graphics.newCanvas(100, 100)
	self.img = love.graphics.newImage(self.canvas:newImageData())
	self.size = imgui.ImVec2_Float(self.img:getDimensions())

	self.viewWidth = 100
	self.viewHeight = 100

	self.cam = Camera()
	self.camPointer = {x = 0, y = 0}

	self.aboutWin = false

	self.viewFocus = false

	self.dragging = false
	self.dragX = 0
	self.dragY = 0 ]]

--[[ function editor:regenCanvas()
	self.img = love.graphics.newImage(self.canvas:newImageData())
	self.size = imgui.ImVec2_Float(self.img:getDimensions())
end

function editor:resizeViewport()
	self.canvas = love.graphics.newCanvas(self.viewWidth, self.viewHeight)
end

function editor:loadTextures()
	for _, entity in pairs(self.currentScene.entities) do
		if self:entityHasComponent(entity, "Texture") then
			local texture = self:entityGetComponent(entity, "Texture")

			if texture.texturePath then
				if not love.filesystem.getInfo(texture.texturePath) then
					self.noImageDialog = true
				else
					table.insert(self.textures, {
						id = texture.id,
						image = love.graphics.newImage(texture.texturePath)
					})
				end
			end
		end
	end
end ]]

--	Slab.BeginWindow("Menu", {Title = "Menu"})

--	if Slab.Button("Run") then
--		self:run()
--	end

--	Slab.Separator()

--	if Slab.Button("New Scene") then
--		self:newScene()
--	end

--	Slab.Separator()

--	Slab.Text("Active Scenes")

--	for _, scene in pairs(self.scenes) do
--		if Slab.Button(scene.name) then
--			self.currentScene = scene

--			self:loadTextures()
--		end
--	end

--	Slab.EndWindow()

--	if self.currentScene and self.currentScene.saved or not self.currentScene then
--		Slab.BeginWindow("Scene", {Title = "Scene"})
--	else
--		Slab.BeginWindow("Scene", {Title = "Scene *"})
--	end

--	if self.currentScene then
--		Slab.Text("NAME")
--		if Slab.Input("SceneName", {Text = self.currentScene.name}) then
--			self.currentScene.name = Slab.GetInputText()
--		end

--		if Slab.Button("Save") then
--			self:saveScene(self.currentScene)
--		end

--		if Slab.Button("New Entity") then
--			self:newEntity(self.currentScene)
--		end

--		Slab.Text("Entities")
--		Slab.Separator()

--		for _, entity in pairs(self.currentScene.entities) do
--			if Slab.Button(entity.name) then
--				self.currentEntity = entity
--			end
--		end

--		if Slab.Button("Delete") then
--			self:deleteScene(self.currentScene)
--			self.currentScene = nil
--			self.currentEntity = nil
--		end
--	end

--	if self.componentSelection then
--		Slab.BeginWindow("Components", {Title = "Components"})

--		if Slab.Button("Transform") then
--			table.insert(self.currentEntity.components, TransformComponent())
--			self.componentSelection = false
--		end

--		if Slab.Button("Texture") then
--			table.insert(self.currentEntity.components, TextureComponent())
--			self.componentSelection = false
--		end

--		Slab.EndWindow()
--	end

--	if self.saveDialog then
--		local result = Slab.MessageBox("ERROR", "You need to save the current scene before running it!")

--		if result ~= "" then
--			self.saveDialog = false
--		end
--	end

--	if self.noSceneDialog then
--		local result = Slab.MessageBox("ERROR", "No scene selected!")

--		if result ~= "" then
--			self.noSceneDialog = false
--		end
--	end

--	if self.noImageDialog then
--		local result = Slab.MessageBox("ERROR", "Error loading image!!")

--		if result ~= "" then
--			self.noImageDialog = false
--		end
--	end

--	Slab.EndWindow()

--	Slab.BeginWindow("Inspector", {Title = "Inspector"})

--	if self.currentEntity then
--		Slab.Text("NAME")
--		if Slab.Input("EntityName", {Text = self.currentEntity.name}) then
--			self.currentEntity.name = Slab.GetInputText()
--		end

--		if Slab.Button("New Component") then
--			self.componentSelection = true
--		end

--		Slab.Text("Components:")
--		Slab.Separator()

--		for _, component in pairs(self.currentEntity.components) do
--			if component.type == "Transform" then
--				Slab.Text("Transform")

--				Slab.Text("X")
--				if Slab.Input("x", {Text = component.x, ReturnOnText = false}) then
--					component.x = Slab.GetInputText()
--				end

--				Slab.Text("Y")
--				if Slab.Input("y", {Text = component.y, ReturnOnText = false}) then
--					component.y = Slab.GetInputText()
--				end

--			elseif component.type == "Texture" then
--				Slab.Text("Texture")

--				Slab.Text("Path")
--				if Slab.Input("texture", {Text = component.texturePath, ReturnOnText = false}) then
--					component.texturePath = Slab.GetInputText()
--					self:loadTextures()
--				end
--			end

--			Slab.Separator()
--		end
--	end

--	Slab.EndWindow()

--[[ 	if love.keyboard.isDown("w") then
		self.camPointer.y = self.camPointer.y - 100 * dt
	elseif love.keyboard.isDown("s") then
		self.camPointer.y = self.camPointer.y + 100 * dt
	end

	if love.keyboard.isDown("a") then
		self.camPointer.x = self.camPointer.x - 100 * dt
	elseif love.keyboard.isDown("d") then
		self.camPointer.x = self.camPointer.x + 100 * dt
	end

	if self.dragging then
		self.camPointer.x = self.camPointer.x + (love.mouse.getX() - self.dragX) / 10 * -1
		self.camPointer.y = self.camPointer.y + (love.mouse.getY() - self.dragY) / 10 * -1
	end


	imgui.love.Update(dt)
	imgui.NewFrame() ]]

--	self.cam:draw(function(l, t, w, h)
--		if self.currentScene then
--			for _, entity in pairs(self.currentScene.entities) do
--				if self:entityHasComponent(entity, "Transform") and self:entityHasComponent(entity, "Texture") then
--					local transform = self:entityGetComponent(entity, "Transform")
--					local texture = self:entityGetComponent(entity, "Texture")


--					for _, t in pairs(self.textures) do
--						if t.id == texture.id then
--							love.graphics.setColor(1, 1, 1)
--							love.graphics.draw(t.image, transform.x, transform.y)

--							if entity == self.currentEntity then
--								love.graphics.rectangle("line", transform.x, transform.y, t.image:getWidth(), t.image:getHeight())
--								love.graphics.setColor(1, 0, 0)
--								love.graphics.line(transform.x + t.image:getWidth()/2, transform.y + t.image:getHeight()/2, transform.x + t.image:getWidth()/2, transform.y + t.image:getHeight()/2 - 100)
--								love.graphics.setColor(0, 0, 1)
--								love.graphics.line(transform.x + t.image:getWidth()/2, transform.y + t.image:getHeight()/2, transform.x + t.image:getWidth()/2 + 100, transform.y + t.image:getHeight()/2)
--								love.graphics.setColor(1, 1, 1)
--							end
--						end
--					end
--				end
--			end
--		end
--	end)

--[[ 	if imgui.BeginMainMenuBar() then
		if imgui.BeginMenu("File") then
			imgui.MenuItem_Bool("Save")

			imgui.EndMenu()
		end

		if imgui.BeginMenu("Actions") then
			if imgui.MenuItem_Bool("Run") then
				state.push(game)
			end

			imgui.EndMenu()
		end

		if imgui.BeginMenu("Help") then
			if imgui.MenuItem_Bool("About") then
				self.aboutWin = true
			end

			imgui.EndMenu()
		end

		imgui.EndMainMenuBar()
	end

	imgui.DockSpaceOverViewport(imgui.GetMainViewport())

	if self.aboutWin then
		if imgui.Begin("AboutCringe") then
			imgui.Text("M ADIO CANE STORTO")
			if imgui.Button("Close") then
				self.aboutWin = false
			end
		end
		imgui.End()
	end



	self:regenCanvas()

	love.graphics.setCanvas(self.canvas)
		love.graphics.clear(135/255, 206/255, 235/255)

		self.cam:attach(0, 0, self.viewWidth, self.viewHeight)
		love.graphics.rectangle("fill", self.testPlayer.x, self.testPlayer.y, 25, 25)
		love.graphics.rectangle("fill", self.camPointer.x, self.camPointer.y, 10, 10)
		self.cam:detach()

		love.graphics.print("(" .. math.floor(self.camPointer.x) .. ", " .. math.floor(self.camPointer.y) .. ")", self.viewWidth - 100, self.viewHeight - 50)
	love.graphics.setCanvas()

	self.cam:lookAt(self.camPointer.x, self.camPointer.y)





	imgui.ShowDemoWindow()

	if imgui.Begin("Bruh", nil, imgui.ImGuiWindowFlags_MenuBar) then
		if imgui.BeginMenuBar() then
			if imgui.BeginMenu("Menu") then
				imgui.MenuItem_Bool("Pizza")
				imgui.MenuItem_Bool("Mafia")
				imgui.MenuItem_Bool("Mandolino")

				imgui.EndMenu()
			end

			if imgui.BeginMenu("About") then
				self.about = true

				imgui.EndMenu()
			end

			imgui.EndMenuBar()
		end
	end
	imgui.End()

	if self.about then
		if imgui.Begin("About", nil) then
			imgui.Text("Bella fra")
			imgui.Separator()
			imgui.BulletText("si zi")
			imgui.Separator()

			imgui.Text("DIO")
			imgui.SameLine()
			imgui.Text("PORCO")

			imgui.Checkbox("FRA??", self.wtf)
		end
		imgui.End()
	end

	if imgui.Begin("Viewport", nil) then
		imgui.Image(self.img, self.size)

		local newWidth = imgui.GetWindowWidth() - 20
		local newHeight = imgui.GetWindowHeight() - 40


		if newWidth ~= self.viewWidth or newHeight ~= self.viewHeight then
			self.toResize = true
		end

		self.viewWidth = newWidth
		self.viewHeight = newHeight

		self.viewFocus = imgui.IsWindowHovered()
	end
	imgui.End()

	if self.toResize then
		self:resizeViewport()
		self.toResize = false
	end


	imgui.Render()
	imgui.love.RenderDrawLists() ]]

--[[ function editor:newScene()
	local newScene = Scene(randomString(5))

	table.insert(self.scenes, newScene)
	self.currentScene = newScene
end ]]

--[[ function editor:run()
	if self.currentScene then
		if self.currentScene.saved then
			state.push(game)
		else
			self.saveDialog = true
		end
	else
		self.noSceneDialog = true
	end
end
 ]]
--[[ function editor:loadScenes()
	local scenes = love.filesystem.getDirectoryItems("scenes")

	for _, scene in pairs(scenes) do
		local loaded = binser.deserializeN(love.filesystem.read("scenes/" .. scene))
		table.insert(self.scenes, loaded)
	end
end

function editor:saveScene(scene)
	scene.saved = true
	love.filesystem.createDirectory("scenes")
	love.filesystem.write("scenes/" .. scene.name .. ".scene", binser.serialize(scene))
end

function editor:deleteScene(scene)
	love.filesystem.remove("scenes/" .. scene.name .. ".scene")
	removeFromTable(self.scenes, scene)
end

function editor:newEntity(scene)
	table.insert(scene.entities, Entity(randomString(4)))
end

function editor:entityHasComponent(entity, comp)
	for _, component in pairs(entity.components) do
		if component.type == comp then
			return true
		end
	end

	return false
end

function editor:entityGetComponent(entity, comp)
	for _, component in pairs(entity.components) do
		if component.type == comp then
			return component
		end
	end

	return false
end ]]

--[[ 	if self.viewFocus then
		self.cam.scale = self.cam.scale + 0.2 * y

		if self.cam.scale < 0 then
			self.cam.scale = 0
		end
	end ]]

--[[ 	if button == 3 then
		self.dragging = false
	end ]]

--[[ 	if button == 3 then
		self.dragX = love.mouse.getX()
		self.dragY = love.mouse.getY()
		self.dragging = true
	end ]]