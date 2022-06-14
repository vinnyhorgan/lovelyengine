SceneManager = Object:extend()

function SceneManager:new()
	self.current = nil
end

function SceneManager:draw()
	if self.current then
		imgui.Text("Name: " .. self.current.name)
	end
end

function SceneManager:save(scene)
	if self.current then
		lf.createDirectory("project/scenes")
		lf.write("project/scenes/" .. self.current.name .. ".scene", binser.serialize(self.current))
	end
end

function SceneManager:load(path)
	self.current = binser.deserializeN(lf.read(path))
end

function SceneManager:newScene()
	self.current = Scene()
end