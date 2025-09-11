require "rulesets.utils"
ant = { x = 5, y = 5, dir = DIRECTION.DOWN }


-- CAMBIAR EN BOARD PARA QUE UTILIZE EL ULTIMO ESTADO DE STATE SI NEXTSTATE NO SE HA CAMBIADO
function copyBoard(b)
	for i = 1, b.y, 1 do
		for j = 1, b.x, 1 do
			b.nextState[i][j] = b.state[i][j]
		end
	end
end

return function(b)
	copyBoard(b)
	-- si esta en cuadrado blanco gira izquierda, sino derecha
	ant.dir = (ant.dir + (b.state[ant.y][ant.x] and -1 or 1) - 1) % 4 + 1

	b.nextState[ant.y][ant.x] = not b.state[ant.y][ant.x]

	if ant.dir == DIRECTION.UP then
		ant.y = wrap(ant.y - 1, b.y)
	elseif ant.dir == DIRECTION.RIGHT then
		ant.x = wrap(ant.x + 1, b.x)
	elseif ant.dir == DIRECTION.DOWN then
		ant.y = wrap(ant.y + 1, b.y)
	else
		ant.x = wrap(ant.x - 1, b.x)
	end
end
