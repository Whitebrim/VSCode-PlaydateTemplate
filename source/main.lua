local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X')

local function loadGame()
	math.randomseed(playdate.getSecondsSinceEpoch())
	
end

local function updateGame()

end

local function drawGame()
	gfx.clear()
	font:drawText("Template", 155, 110)
end

playdate.display.setRefreshRate(50)
loadGame()

function playdate.update()
	updateGame()
	drawGame()
	playdate.drawFPS(0,0)
end