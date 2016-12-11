workspace()
include("../util/aoc.jl")
using AoC
using Iterators
using DataStructures
include("shared.jl")

function aoc_11b(input)
    comps = parse_components(input)
    push!(comps, ElementRTGComponents("elerium", 1, 1))
    push!(comps, ElementRTGComponents("dilithium", 1, 1))
    return solve_comps(comps)
end

print(aoc_11b(@aoc_input))
