game = {}

function game:enter(editor)

end

function game:update(dt)

end

function game:draw()
	lg.print("Running game, press esc to go back to editor")
end

function game:keypressed(key)
	if key == "escape" then
		return state.pop()
	end
end