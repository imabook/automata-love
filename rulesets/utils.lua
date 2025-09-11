DIRECTION = { UP = 1, RIGHT = 2, DOWN = 3, LEFT = 4 }

function wrap(value, max)
	return ((value - 1) % max) + 1
end
