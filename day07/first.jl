workspace()
include("../util/aoc.jl")
using AoC
#include("shared.jl")

function ip_supports_tls(s)
  found = false

  valid = true
  c0 = '_'; c1 = '_'; c2 = '_'; c3 = '_'
  for c in s
    if c == '['
      valid = false
      c0 = '_'; c1 = '_'; c2 = '_'; c3 = '_'
    end

    if c == ']'
      valid = true
    end

    c3 = c2; c2 = c1; c1 = c0; c0 = c;

    if c3 != '_' && c0 == c3 && c1 == c2 && c0 != c1
      if !valid
        return false
      else
        found = true
      end
    end
  end
  return found
end

aoc_7a(input) = input |>
  split |>
  _ -> count(ip_supports_tls, _)

print(aoc_7a(@aoc_input))
