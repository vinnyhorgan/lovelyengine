EntityManager = Object:extend()

function EntityManager:new()
	self.current = nil

	self.componentList = {Transform, SpriteRenderer}
end

function EntityManager:newEntity()
	if state.current().sceneManager.current then
		local newEntity = Entity()

		table.insert(state.current().sceneManager.current.entities, newEntity)
		self.current = newEntity

		state.current().console:log("Created new entity: " .. newEntity.name)
	end
end

function EntityManager:addComponent(component)
	if self.current then
		local canAdd = true

		for _, c in pairs(self.current.components) do
			if c.name == component.name then
				canAdd = false
			end
		end

		if canAdd then
			table.insert(self.current.components, component())
			state.current().console:log("Added component: " .. component.name)
		end
	end
end

function EntityManager:draw()
	if self.current then
		imgui.Text(self.current.name)
		imgui.Separator()

		for _, component in pairs(self.current.components) do
			imgui.Text(component.name)

			if component.name == "Transform" then
				local x = ffi.new("int[1]")
				x[0] = component.x
				local y = ffi.new("int[1]")
				y[0] = component.y

				imgui.InputInt("X", x)
				imgui.InputInt("Y", y)

				component.x = x[0]
				component.y = y[0]
			elseif component.name == "Sprite Renderer" then
				imgui.Text(tostring(component.texture))

				local texture = ffi.new("char[?]", 50)

				imgui.InputText("Texture", texture, 50)

				if ffi.string(texture) ~= "" then
					component.texture = ffi.string(texture)
				end
			end

			imgui.Separator()
		end
	end
end