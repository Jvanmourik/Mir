local vector = {}

function vector.length(x, y)
	return math.sqrt(x * x + y * y)
end

function vector.normalize(x, y)
	local l = vector.length(x, y)
	if l > 0 then
		x, y = x / l, y / l
	end
	return x, y
end

return vector
