GameObject = Object:extend()

function GameObject:new(name)
	self.name = name
	self.components = {}
end