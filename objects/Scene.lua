Scene = Object:extend()

function Scene:new()
	self.name = randomString(5)
	self.saved = false

	self.entities = {}
end