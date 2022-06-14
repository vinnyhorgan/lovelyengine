GameObject = Object:extend()

function GameObject:new()
	self.name = randomString(5)
	self.components = {}
end