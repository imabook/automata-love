require "globals"

Board = { state = {}, nextState = {}, neighbours = {}, x = nil, y = nil }

function Board:setup(x, y)
	self.state = {}
	self.x = x
	self.y = y

	for i = 1, y, 1 do
		table.insert(self.state, {})
		table.insert(self.nextState, {})
		table.insert(self.neighbours, {})
		for j = 1, x, 1 do
			table.insert(self.state[i], false)
			-- table.insert(self.nextState[i], false)
			table.insert(self.neighbours[i], 0)
		end
	end
end

function Board:handleClick(x, y, button)
	local i, j = math.ceil(y / H), math.ceil(x / W)

	if button == 1 then
		self.state[i][j] = not self.state[i][j]
	elseif button == 2 then
		toggleAnt(i, j)
	end
end

local totalFrames = 0
function Board:sim(start, dt)
	if not start then
		totalFrames = 0
		return
	end

	totalFrames = totalFrames + dt
	-- print(totalFrames)

	if totalFrames % (1 / VEL) >= totalFrames then
		return
	end

	totalFrames = totalFrames % (1 / VEL)

	-- require "rulesets.cellular" (self) -- wow bastante cursed
	require "rulesets.ant" (self)
	-- self.state[math.random(self.y)][math.random(self.x)] = 1

	for i = 1, self.y, 1 do
		for j = 1, self.x, 1 do
			self.state[i][j] = self.nextState[i][j]
		end
	end
end
