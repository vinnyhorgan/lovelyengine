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

	if self.width < 100 then
		self.width = 100
	end

	if self.height < 100 then
		self.height = 100
	end

	self.canvas = lg.newCanvas(self.width, self.height)
end

function Viewport:canvasDraw()
	lg.clear(135/255, 206/255, 235/255)

	if state.current().sceneManager.current then
		for _, entity in pairs(state.current().sceneManager.current.entities) do
			local transform = state.current().entityManager:getComponent(entity, "Transform")
			local spriteRenderer = state.current().entityManager:getComponent(entity, "Sprite Renderer")

			if entity == state.current().entityManager.current then
				lg.setColor(1, 0, 0)
				lg.line(transform.x, transform.y, transform.x + 50, transform.y)
				lg.circle("fill", transform.x + 50, transform.y, 5)
				lg.setColor(0, 0, 1)
				lg.line(transform.x, transform.y, transform.x, transform.y - 50)
				lg.circle("fill", transform.x, transform.y - 50, 5)
				lg.setColor(1, 1, 1)
			end

			if spriteRenderer then
				lg.rectangle("fill", transform.x, transform.y, 25, 25)
			end
		end
	end
end

function Viewport:draw()
	local newWidth = imgui.GetWindowWidth()
	local newHeight = imgui.GetWindowHeight()

	if newWidth ~= self.width or newHeight ~= self.height then
		self:resize(newWidth, newHeight)
	end

	self.canvas:renderTo(self.canvasDraw)

	self.canvasTexture = lg.newImage(self.canvas:newImageData())
	self.textureSize = imgui.ImVec2_Float(self.canvasTexture:getDimensions())

	imgui.Image(self.canvasTexture, self.textureSize)

	self.focused = imgui.IsWindowHovered()
end