local vector = {}

-- calculate the angle in radians of two vectors
function vector.angle(x1, y1, x2, y2)
	local d = vector.dot(x1, y1, x2, y2)
  local l1 = vector.length(x1, y1)
  local l2 = vector.length(x2, y2)
  return math.acos(d / (l1 * l2))
end

-- calculate dot product of two vectors
function vector.dot(x1, y1, x2, y2)
  return x1 * x2 + y1 * y2
end

-- calculate magnitude of vector
function vector.length(x, y)
	return math.sqrt(x * x + y * y)
end

-- normalize vector
function vector.normalize(x, y)
	local l = vector.length(x, y)
	if l > 0 then
		x, y = x / l, y / l
	end
	return x, y
end

return vector
