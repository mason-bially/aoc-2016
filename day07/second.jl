using DataStructures
include("../util/aoc.jl")
using AoC
#include("shared.jl")

function ip_supports_ssl(s)
  a_l = nil()
  b_l = nil()
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

    c2 = c1;
    c1 = c0;
    c0 = c;

    if c2 != '_' && c0 == c2 && c0 != c1
      if !valid
        b_l = cons("$c1$c0$c1", b_l)
      else
        a_l = cons("$c0$c1$c2", a_l)
      end
    end
  end
  if a_l == nil() || b_l == nil()
    return false
  end
  for a in a_l
    for b in b_l
      if a == b
        return true;
      end
    end
  end
  return false
end

function aoc_7b(input)
  res = 0
  for l in split(input)
    if ip_supports_ssl(l)
      res += 1
    end
  end
  return res
end

print(aoc_7b(@aoc_input))
