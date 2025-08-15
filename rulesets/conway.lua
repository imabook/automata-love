require "board"

local function wrap(value, max)
	return ((value - 1) % max) + 1
end

return function(b, x, y)
	local surround = 0
	for i = -1, 1, 1 do
		for j = -1, 1, 1 do
			local x2, y2 = wrap(x + j, b.x), wrap(y + i, b.y)
			surround = surround + (b.state[y2][x2] and 1 or 0)
		end
	end

	b.neighbours[y][x] = surround

	if b.state[y][x] then
		-- esta viva
		if surround < 3 then
			b.nextState[y][x] = false
		elseif surround > 4 then
			b.nextState[y][x] = false
		else
			b.nextState[y][x] = true
		end
	else
		-- esta muerta
		if surround == 3 then
			b.nextState[y][x] = true
		else
			b.nextState[y][x] = false
		end
	end
end
