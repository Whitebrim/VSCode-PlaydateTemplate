import "dvd"
local dvd = dvd(1, -1)

local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X')

local function loadGame()
	playdate.display.setRefreshRate(50)
	math.randomseed(playdate.getSecondsSinceEpoch())
	gfx.setFont(font)
end

local function updateGame()
	dvd:update()
end

local function drawGame()
	gfx.clear()
	dvd:draw()
end

loadGame()

function playdate.update()
	updateGame()
	drawGame()
	playdate.drawFPS(0,0)
end