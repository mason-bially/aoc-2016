include("../util/aoc.jl")
using AoC

room_format = r"(?P<name>[a-z\-]*)(?P<number>\d*)\[(?P<chksum>\w*)\]"

function room_value(line)
  room = match(room_format, line)
  a = zeros(UInt32, 26)
  foreach(c -> a[alpha2ord(c)] += 1, filter(isalpha, room[:name]))
  chksum = vec(a) |>
    enumerate |>
    _ -> sort(collect(_); by=t->t[2], rev=true) |>
    _ -> take(_, 5) |>
    _ -> map(t -> ord2alpha(t[1]), _) |>
    join
  if chksum == room[:chksum] return parse(UInt32, room[:number]) end
  return 0
end

function aoc_4a(input)
  return sum(map(room_value, split(input)))
end

print(aoc_4a(@aoc_input))
