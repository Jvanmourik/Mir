----------------------------------------------
-- extensions
----------------------------------------------

-- shallow copy a table
function table.copy(t)
  local o = {}
  for key, value in pairs(t) do
    o[key] = value
  end
  return o
end

-- combine two tables into one
function table.combine(t1, t2)
  for key, value in pairs(t2) do
    t1[#t1 + 1] = value
  end
end

-- remove element from table identified by its key and return it
function table.removekey(t, k)
    local e = t[k]
    t[k] = nil
    return e
end
