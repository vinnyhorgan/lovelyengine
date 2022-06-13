Scene = Object:extend()

function Scene:new()
	self.name = "Unsaved"
	self.saved = false

	self.entities = {}
end