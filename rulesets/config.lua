NEIGHBOURHOOD =
{ { 0, 2, 0 },
	{ 1, 0, 1 },
	{ 3, 0, 0 } }
SELF_COUNT = true -- en el heatmap cuenta la propia celula como vecino
MAX_NEIGHBOURS = SELF_COUNT and 1 or 0

for i, _ in ipairs(NEIGHBOURHOOD) do
	for _, v in ipairs(NEIGHBOURHOOD[i]) do
		MAX_NEIGHBOURS = MAX_NEIGHBOURS + v
	end
end

-- reglas del conway normal:
-- stable 2 vecinos
-- born 3 vecinos
-- resto cel muere o se queda muerta
STABLE = 4
BORN = 1

-- ANTS:

ANTS = {}
