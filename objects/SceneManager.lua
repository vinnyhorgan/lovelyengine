SceneManager = Object:extend()

function SceneManager:new()
	self.current = nil
end

function SceneManager:draw()

end

function SceneManager:save(scene)
	lf.createDirectory("scenes")
	lf.write("scenes/" .. self.current.name .. ".scene", binser.serialize(self.current))
end