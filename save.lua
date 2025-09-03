local saved_frames = 0
local save_file = nil
local save = true


function start_save()
	if save_file then
		-- si ya esta creada que la continue o se pause
		save = not save
		if save then print("continuando guardado..") else print("pausando guardado") end
		return
		-- save_file:close()
		-- save_file = nil
	end

	print("empezando guardado")
	save = true

	-- creacion de archivo y cabecera
	-- 2 bytes para width
	-- 2 bytes para height

	save_file = io.open("frames.fdt", "wb")
	save_file:write(string.char(math.floor(COLUMNS % 2 ^ 8)))
	save_file:write(string.char(math.floor(COLUMNS / 2 ^ 8)))
	save_file:write(string.char(math.floor(ROWS % 2 ^ 8)))
	save_file:write(string.char(math.floor(ROWS / 2 ^ 8)))
	saved_frames = 0
end

function end_save()
	if save_file then
		print("saving and closing the file")
		save_file:close()
		save_file = nil
	end
end

function save_frame()
	if save_file and save then
		-- va pixel por pixel y los guarda en el fdt, la info de 1 pixel se guarda en 4 bits
		-- en un byte hay info de 2 pixeles

		local buff = nil
		for _, line in ipairs(Board.neighbours) do
			for _, l in ipairs(line) do
				if buff then
					-- seria mucho mas facil si me dejara hacerlo con bitwise op
					buff = tonumber(buff) * 2 ^ 4 + tonumber(l)
					save_file:write(string.char(buff))

					buff = nil
				else
					buff = l
				end
			end
		end

		if buff then
			-- rellenar con F porque las dimensiones no son pares entonces sobra medio byte
			buff = tonumber(buff) * 2 ^ 4 + 15
			save_file:write(string.char(buff))
		end

		saved_frames = saved_frames + 1
	end
end

local total_frames = 0
function save_frames(start, dt)
	if not start then
		total_frames = 0
		return
	end

	total_frames = total_frames + dt

	if total_frames % (1 / VEL) >= total_frames then
		return
	end

	total_frames = total_frames % (1 / VEL)

	save_frame()

	if saved_frames == FRAMES and save_file then
		print("DONE SAVING STABLISHED STATES/FRAMES")
		end_save()
	end
end
