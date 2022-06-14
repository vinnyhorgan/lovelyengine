Viewport = Object:extend()

function Viewport:new()
	self.width = 100
	self.height = 100

	self.canvas = lg.newCanvas(self.width, self.height)
	self.canvasTexture = nil
	self.textureSize = nil

	self.focused = false
end

function Viewport:resize(width, height)
	self.width = width - 15
	self.height = height - 35

	self.canvas = lg.newCanvas(self.width, self.height)
end

function Viewport:canvasDraw()
	lg.clear(135/255, 206/255, 235/255)

	lg.rectangle("fill", 10, 10, 25, 25)
end

function Viewport:draw()
	local newWidth = imgui.GetWindowWidth()
	local newHeight = imgui.GetWindowHeight()

	if newWidth ~= self.width and newWidth > 100 or newHeight ~= self.height and newHeight > 100 then
		self:resize(newWidth, newHeight)
	end

	self.canvas:renderTo(self.canvasDraw)

	self.canvasTexture = lg.newImage(self.canvas:newImageData())
	self.textureSize = imgui.ImVec2_Float(self.canvasTexture:getDimensions())

	imgui.Image(self.canvasTexture, self.textureSize)

	self.focused = imgui.IsWindowHovered()
end