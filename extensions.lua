----------------------------------------------
-- extensions
----------------------------------------------

-- combine two tables into one
function table.combine(t1, t2)
  for key, value in pairs(t2) do
    t1[#t1 + 1] = value
  end
end
