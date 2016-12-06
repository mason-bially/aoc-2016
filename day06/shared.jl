function aoc_6(input, sort_row_func)
  lines = split(input)
  width = length(lines[1])
  a = zeros(UInt32, width, 26)
  for l in lines
    for (i, x) in enumerate(l)
      a[i, alpha2ord(x)] += 1;
    end
  end
  return 1:width |>
    c -> map(r -> (a[r, :] |>
      enumerate |>
      _ -> map(t -> (t[2], t[1]), _) |>
      sort_row_func |>
      _ -> ord2alpha(_[2])
    ),  c) |>
    join
end
