love.graphics.setPointSize(10)
local speed = 20
local w, h = love.graphics.getDimensions()
local pressed = love.keyboard.isDown
local hw, hh = math.floor(w/2), math.floor(h/2)
local points = {
  {-6, -6, -6},
  {6, -6, -6},
  {-6, 6, -6},
  {6, 6, -6},

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
	w = {0, 0, 1},
	s = {0, 0, -1},
	a = {-1, 0, 0},
	d = {1, 0, 0},
	lshift = {0, 1, 0},
	space = {0, -1, 0},

  left = {0, 0, 0, -0.1},
  right = {0, 0, 0, 0.1},
  up = {0, 0, 0, 0, -0.1},
  down = {0, 0, 0, 0, 0.1},
}
local rotate = function(x, y, rot)
	return x*math.cos(rot) - y*math.sin(rot), y*math.cos(rot) + x*math.sin(rot)
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
    love.graphics.print(math.floor(camera[i]), 1, 10*i)
  end
end

for i = 1, 20000 do
  table.insert(
  points,
  {math.random(1, 100), math.random(1, 100), math.random(1, 100)}
)
end

function love.update(dt)
  for keyName, move in pairs(cameraMoves) do
    if pressed(keyName) then
      for i = 1, #move do
        camera[i] = camera[i] + move[i] * (dt*speed)
      end
    end
  end
end
