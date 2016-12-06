#workspace()
using Nettle
include("../util/aoc.jl")
using AoC
#include("shared.jl")

function aoc_5b(input)
  p = fill('_', 8); c = 0;
  i = 0; h = Hasher("MD5")

  while c < 8
    update!(h, "$input$i"); i += 1
    s = hexdigest!(h)
    if startswith(s, "00000") && isdigit(s[6])
      pos = parse(Int, s[6]) + 1
      if pos > 8 || p[pos] != '_'
        continue
      end
      p[pos] = s[7]; c += 1
      println(string(join(p)))
    end
  end
  return string(join(p))
end

print(aoc_5b(@aoc_input))
