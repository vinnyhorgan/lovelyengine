SceneManager = Object:extend()

function SceneManager:new()
	self.current = nil
end

function SceneManager:draw()

end

function SceneManager:save(scene)
	love.filesystem.createDirectory("scenes")
	love.filesystem.write("scenes/" .. self.current.name .. ".scene", binser.serialize(self.current))
end