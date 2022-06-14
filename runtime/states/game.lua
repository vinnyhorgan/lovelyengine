game = {}

function game:enter()

end

function game:update(dt)

end

function game:draw()
	lg.print("YEEEEEEE")
end

--[[ function game:enter(editor)
	self.editor = editor

	self.loadedScripts = {}

	for _, entity in pairs(self.editor.sceneManager.current.entities) do
		local script = self.editor.entityManager:getComponent(entity, "Script")

		if script then
			local newScript = require(script.path)
			newScript:start(entity)
			table.insert(self.loadedScripts, newScript)
		end
	end
end

function game:update(dt)
	for _, script in pairs(self.loadedScripts) do
		script:update(dt)
	end
end

function game:draw()
	lg.clear(135/255, 206/255, 235/255)

	for _, entity in pairs(self.editor.sceneManager.current.entities) do
		local transform = self.editor.entityManager:getComponent(entity, "Transform")
		local spriteRenderer = self.editor.entityManager:getComponent(entity, "Sprite Renderer")

		if spriteRenderer then
			lg.rectangle("fill", transform.x, transform.y, 25, 25)
		end
	end
end

function game:keypressed(key)
	if key == "escape" then
		return state.pop()
	end
end ]]