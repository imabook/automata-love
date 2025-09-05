require "board"
require "rulesets.config"

local function wrap(value, max)
	return ((value - 1) % max) + 1
end

local function checkNeighbourhood(b, x, y)
	-- considera como vecindario el grid de config.lua
	-- y calcula cuantas celulas hay alrededor de la central

	local count = 0
	local bounds = (#NEIGHBOURHOOD - 1) / 2

	for i = -bounds, bounds, 1 do
		for j = -bounds, bounds, 1 do
			local x2, y2 = wrap(x + j, b.x), wrap(y + i, b.y)
			count = count + (b.state[y2][x2] and 1 or 0) * NEIGHBOURHOOD[i + bounds + 1][j + bounds + 1]
		end
	end

	return count
end

function simulateStep(b, x, y)
	local surround = checkNeighbourhood(b, x, y)

	b.neighbours[y][x] = surround + (SELF_COUNT and b.state[y][x] and 1 or 0)

	if surround == STABLE then
		b.nextState[y][x] = b.state[y][x]
	elseif surround == BORN then
		b.nextState[y][x] = true
	else
		b.nextState[y][x] = false
	end
end

return function(b)
	for i = 1, b.y, 1 do
		for j = 1, b.x, 1 do
			simulateStep(b, j, i)
		end
	end
end
