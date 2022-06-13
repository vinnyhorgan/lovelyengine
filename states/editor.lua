editor = {}

function editor:enter()
	self.sceneManager = SceneManager()
	self.entityManager = EntityManager()
	self.console = Console()

	self.gui = GUI()
end

function editor:update(dt)
	self.gui:update(dt)
end

function editor:draw()
	self.gui:draw()
end

function editor:mousemoved(x, y)
	self.gui:mousemoved(x, y)
end

function editor:mousepressed(x, y, button)
	self.gui:mousepressed(x, y, button)
end

function editor:mousereleased(x, y, button)
	self.gui:mousereleased(x, y, button)
end

function editor:wheelmoved(x, y)
	self.gui:wheelmoved(x, y)
end

function editor:keypressed(key)
	self.gui:keypressed(key)
end

function editor:keyreleased(key)
	self.gui:keyreleased(key)
end

function editor:textinput(t)
	self.gui:textinput(t)
end

function editor:quit()
	return self.gui:quit()
end