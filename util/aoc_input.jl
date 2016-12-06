
macro aoc_input()
  return :(open(joinpath(dirname(Base.source_path()), "input.txt")) do f; readstring(f) end)
end
