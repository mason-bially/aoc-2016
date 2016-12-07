workspace()
include("../util/aoc.jl")
using AoC
#include("shared.jl")

function ip_supports_ssl(s)
  a = Set(); b = Set()

  valid = true
  c0 = '_'; c1 = '_'; c2 = '_';
  for c in s
    if c == '['
      valid = false;
      c0 = '_'; c1 = '_'; c2 = '_';
    end

    if c == ']'
      valid = true;
    end

    c2 = c1; c1 = c0; c0 = c;

    if c2 != '_' && c0 == c2 && c0 != c1
      if !valid
        union!(b, [ (c1, c0) ])
      else
        union!(a, [ (c0, c1) ])
      end
    end
  end
  return !isempty(∩(a, b))
end

aoc_7b(input) = input |>
  split |>
  _ -> count(ip_supports_ssl, _)

print(aoc_7b(@aoc_input))
