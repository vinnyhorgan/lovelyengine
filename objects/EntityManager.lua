EntityManager = Object:extend()

function EntityManager:new()
	self.current = nil
end

function EntityManager:newEntity()
	if state.current().sceneManager.current then
		local newEntity = Entity()

		table.insert(state.current().sceneManager.current.entities, newEntity)
		self.current = newEntity

		state.current().console:log("Created new entity: " .. newEntity.name)
	end
end

function EntityManager:draw()
	if self.current then
		imgui.Text(self.current.name)
	end
end