#workspace()
using Nettle
include("../util/aoc.jl")
using AoC
#include("shared.jl")

function aoc_5a(input)
  p = ""; c = 0;
  i = 0; h = Hasher("MD5")
  while c < 8
    update!(h, "$input$i"); i += 1
    s = hexdigest!(h)
    if startswith(s, "00000")
      p *= string(s[6]); c += 1
      println(p)
    end
  end
  return p
end

print(aoc_5a(@aoc_input))
