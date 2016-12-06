function aoc_6(input, sort_row_func)
  lines = split(input)
  w = length(lines[1])
  a = zeros(UInt32, w, 26)
  _c_base = Int('a')
  for l in lines
    for (i, x) in enumerate(l)
      a[i, Int(x) + 1 - _c_base] += 1;
    end
  end
  s = ""
  for i in 1:w
    top_v = sort_row_func(map(x -> (x[2], x[1]), enumerate(a[i, :])))[2]
    s *= string(Char(_c_base - 1 + top_v))
  end
  return s
end
