workspace()
using Iterators
include("../util/aoc.jl")
using AoC
#include("shared.jl")

iter_aba(s) = partition(s, 3, 1) |>
  _ -> filter(r -> r[1] != r[2] && r[1] == r[3], _)
has_aba(s) = !isempty(iter_abba(s))

aba_inv(s::Tuple{Char,Char,Char}) = (s[2], s[1], s[2])
aba_inv(i) = map(aba_inv, i)

function ip_supports_ssl(s)
  ip = split(s, ('[',']')) |> _ -> map(iter_aba, _)
  return !isempty(reduce(∪, ip[1:2:end]) ∩ reduce(∪, map(aba_inv, ip[2:2:end])))
end

aoc_7b(input) = input |>
  split |>
  _ -> count(ip_supports_ssl, _)

print(aoc_7b(@aoc_input))
