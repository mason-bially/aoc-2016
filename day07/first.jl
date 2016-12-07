workspace()
using Iterators
include("../util/aoc.jl")
using AoC
#include("shared.jl")

iter_abba(s) = partition(s, 4, 1) |>
  _ -> filter(r -> r[1] != r[2] && r[1] == r[4] && r[2] == r[3], _)
has_abba(s) = !isempty(iter_abba(s))

function ip_supports_tls(s)
  ip = split(s, ('[',']')) |> _ -> map(has_abba, _)
  return !any(ip[2:2:end]) && any(ip[1:2:end])
end

aoc_7a(input) = input |>
  split |>
  _ -> count(ip_supports_tls, _)

print(aoc_7a(@aoc_input))
