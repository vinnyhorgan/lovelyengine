SceneManager = Object:extend()

function SceneManager:new()
	self.current = nil
end

function SceneManager:draw()
	if self.current then
		imgui.Text("Name: " .. self.current.name)

		imgui.Separator()

		for _, entity in pairs(self.current.entities) do
			if imgui.Button(entity.name) then
				state.current().entityManager.current = entity
				state.current().console:log("Selected entity: " .. entity.name)
			end
		end
	end
end

function SceneManager:save()
	if self.current then
		lf.createDirectory("project/scenes")
		lf.write("project/scenes/" .. self.current.name .. ".scene", binser.serialize(self.current))
		state.current().console:log("Saved scene: " .. self.current.name)
	end
end

function SceneManager:load(path)
	self.current = binser.deserializeN(lf.read(path))
	state.current().console:log("Loaded scene: " .. path)
end

function SceneManager:newScene()
	local newScene = Scene()

	self.current = newScene
	state.current().console:log("New scene created: " .. newScene.name)
end