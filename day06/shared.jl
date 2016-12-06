function aoc_6(input, sort_row_func)
  lines = split(input)
  w = length(lines[1])
  a = zeros(UInt32, w, 26)
  for l in lines
    for (i, x) in enumerate(l)
      a[i, char2ord(x)] += 1;
    end
  end
  s = ""
  for i in 1:w
    top_v = sort_row_func(map(x -> (x[2], x[1]), enumerate(a[i, :])))[2]
    s *= string(ord2char(top_v))
  end
  return s
end
