workspace()
include("../util/aoc.jl")
using AoC
using Iterators
using DataStructures
include("shared.jl")

function aoc_8b(input)
  println("[][][]")
  println("[][][]")
  println("[][][]")
  d = gen_display(input)
  for i in 1:5:50
    println("CHAR$i")
    display_char(view(d, i:i+4, 1:6))
  end
end

print(aoc_8b(@aoc_input))
