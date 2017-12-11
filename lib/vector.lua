local vector = {}

-- calculate the angle in radians of two vectors
function vector.angle(x1, y1, x2, y2)
	local dot = vector.dot(x1, y1, x2, y2)
  local det = vector.det(x1, y1, x2, y2)
  return math.atan2(det, dot)
end

-- calculate the determinant of two vectors
function vector.det(x1, y1, x2, y2)
  return x1 * y2 - y1 * x2
end

-- calculate the dot product of two vectors
function vector.dot(x1, y1, x2, y2)
  return x1 * x2 + y1 * y2
end

-- calculate the magnitude of a vector
function vector.length(x, y)
	return math.sqrt(x * x + y * y)
end

-- normalize a vector
function vector.normalize(x, y)
	local l = vector.length(x, y)
	if l > 0 then
		x, y = x / l, y / l
	end
	return x, y
end

return vector
