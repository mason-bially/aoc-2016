module AoC

∘(f::Function, g::Function) = x->f(g(x))

include("aoc_input.jl")
export @aoc_input

include("aoc_alpha.jl")
export alpha2ord
export ord2alpha

end
