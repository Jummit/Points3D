love.graphics.setPointSize(10)
local speed = 100
local w, h = love.graphics.getDimensions()
local pressed = love.keyboard.isDown
local hw, hh = math.floor(w/2), math.floor(h/2)
local points = {
  {6, 6, -3},
  {6, 6, 0},
  {6, 6, 3},

  {-6, -6, 6},
  {6, -6, 6},
  {-6, 6, 6},
  {6, 6, 6},
}
local camera = {0, 0, 0, 0, 0}
local cameraMoves = {
	--[[w = {0, 0, 1},
	s = {0, 0, -1},
	a = {-1, 0, 0},
	d = {1, 0, 0},]]
	lshift = {0, 1, 0},
	space = {0, -1, 0},

  left = {0, 0, 0, -0.1},
  right = {0, 0, 0, 0.1},
  up = {0, 0, 0, 0, -0.1},
  down = {0, 0, 0, 0, 0.1},
}
local rotate = function(x, y, rot)
	return x*math.cos(rot) - y*math.sin(rot),
  y*math.cos(rot) + x*math.sin(rot)
end

function love.draw()
	for i = 1, #points do
		local point = points[i]
    local x = point[1] + camera[1]
    local y = point[2] + camera[2]
    local z = point[3] + camera[3]

    x, z = rotate(x, z, camera[4])
    y, z = rotate(y, z, camera[5])

		if z < 0 then
			local f = hh/z
			love.graphics.points(
				x*f + hw,
				y*f + hh
			)
		end
	end

  for i = 1, #camera do
    love.graphics.print(camera[i], 1, 10*i)
  end
end

for i = 1, 10000 do
  table.insert(
  points,
  {math.random(-1000, 1000), math.random(-1000, 1000), math.random(-1000, 1000)}
)
end

function love.update(dt)
  if pressed("q") then
    table.insert(
      points,
      {
        -camera[1],
        -camera[2],
        -camera[3]
      }
    )
  end
  for keyName, move in pairs(cameraMoves) do
    if pressed(keyName) then
      for i = 1, #move do
        local s = dt*speed/10
        camera[i] = camera[i] + move[i] * s
      end
    end
  end

  local s = dt*speed
  local direc
  if pressed("w") then
    direc = 1
  elseif pressed("s") then
    direc = -1
  end
  if direc then
    camera[1] = camera[1] + math.sin(camera[4])*s*direc
    camera[2] = camera[2] + math.sin(camera[5])*s*direc
    camera[3] = camera[3] + math.cos(camera[4])*s*direc
  end
end
