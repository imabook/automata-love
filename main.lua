require "globals"
require "board"

local start = false
local heatmap = false
local numbers = false

local debugNumbers = {}

function love.load()
	Board:setup(ROWS, COLUMNS)
	love.window.setMode(WIDTH, HEIGHT, {
		resizable = false,
		fullscreen = false
	})

	W, H = WIDTH / Board.x, HEIGHT / Board.y
	local font = love.graphics.newFont((W + H) / 4)
	for i = 0, 9, 1 do
		debugNumbers[i] = love.graphics.newText(font, i)
	end

	love.window.setTitle("sim")
end

function love.update(dt)
	Board:sim(start, dt)
end

function love.draw()
	love.graphics.setLineWidth(math.floor((W + H) / 50))

	if heatmap then
		for i = 1, Board.y, 1 do
			for j = 1, Board.x, 1 do
				love.graphics.setColor(Board.neighbours[i][j] * (1 / 9), 0, 0)
				love.graphics.rectangle("fill", (j - 1) * W, (i - 1) * H, W, H)
			end
		end
	else
		for i = 1, Board.y, 1 do
			for j = 1, Board.x, 1 do
				if Board.state[i][j] then
					love.graphics.setColor(0.6, 0.6, 0.6)
					love.graphics.rectangle("fill", (j - 1) * W, (i - 1) * H, W, H)
				else
					love.graphics.setColor(0.2, 0.2, 0.2)
					love.graphics.rectangle("line", (j - 1) * W, (i - 1) * H, W, H)
				end
			end
		end
	end

	if numbers then
		debug()
	end
end

function debug()
	love.graphics.setColor(0.2, 0.6, 0.2)

	for i = 1, Board.y, 1 do
		for j = 1, Board.x, 1 do
			love.graphics.draw(debugNumbers[Board.neighbours[i][j]], (j - 1) * W + W / 3, (i - 1) * H + H / 5)
		end
	end
end

function love.keypressed(key)
	if key == "space" then
		start = not start
	elseif key == "r" then
		for i = 1, Board.y, 1 do
			for j = 1, Board.x, 1 do
				Board.state[i][j] = (math.random() < 0.5) and true or false
			end
		end
	elseif key == "up" then
		VEL = VEL + 0.5
	elseif key == "down" then
		VEL = VEL - 0.5
	elseif key == "h" then
		heatmap = not heatmap
	elseif key == "n" then
		numbers = not numbers
	elseif key == "escape" then
		love.event.quit()
	end
end

function love.mousepressed(x, y, button, istouch, presses)
	Board:handleClick(x, y)
end
