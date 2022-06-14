Entity = Object:extend()

function Entity:new()
	self.name = randomString(5)
	self.components = {}
end