require "board"

local function wrap(value, max)
	return ((value - 1) % max) + 1
end

local function checkNeighborhood(b, x, y)
	-- define lo que es un vecindario
	-- y calcula cuantas celulas hay al rededor de la central

	local surround =
	{ { 1, 1, 1 },
		{ 1, 0, 1 },
		{ 1, 1, 1 } }

	local count = 0
	local bounds = (#surround - 1) / 2

	for i = -bounds, bounds, 1 do
		for j = -bounds, bounds, 1 do
			local x2, y2 = wrap(x + j, b.x), wrap(y + i, b.y)
			count = count + (b.state[y2][x2] and 1 or 0) * surround[i + bounds + 1][j + bounds + 1]
		end
	end

	return count
end

function conwayStep(b, x, y)
	-- reglas del conway normal:
	-- stable 2 vecinos
	-- born 3 vecinos
	-- resto cel muere o se queda muerta

	local surround = checkNeighborhood(b, x, y)

	b.neighbours[y][x] = surround

	if surround == 2 then
		b.nextState[y][x] = b.state[y][x]
	elseif surround == 3 then
		b.nextState[y][x] = true
	else
		b.nextState[y][x] = false
	end
end

return function(b)
	for i = 1, b.y, 1 do
		for j = 1, b.x, 1 do
			conwayStep(b, j, i)
		end
	end
end
