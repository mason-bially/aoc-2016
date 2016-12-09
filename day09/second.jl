workspace()
include("../util/aoc.jl")
using AoC
using Iterators
using DataStructures
include("shared.jl")

function aoc_9b(input)
  i::Int128 = 0
  in_marker = false
  count_stack = Stack(Any)
  next = nothing
  count_since_last_push = 0
  parse_str = ""
  multiplier::Int128 = 0
  to_count::Int128 = 0
  last_count::Int128 = 0

  push!(count_stack, (1, -1, -1))
  for c in input
    count_since_last_push += 1
    multiplier, to_count, last_count = top(count_stack)
    println("top is $multiplier, $to_count")
    if c == '('
      in_marker = true
    elseif in_marker && c == 'x'
      next = parse(parse_str)
      parse_str = "";
    elseif in_marker && c == ')'
      in_marker = false
      next = (parse(parse_str) * multiplier, next, count_since_last_push)
      push!(count_stack, next)
      count_since_last_push = 0
      parse_str = "";
    elseif in_marker
      parse_str *= string(c)
    elseif to_count != 0 && !isspace(c)
      i += multiplier
      println("$c counted $multiplier times")
      while to_count != -1 && count_since_last_push >= to_count;
        multiplier, to_count, last_count = pop!(count_stack)
        count_since_last_push += last_count
        multiplier, to_count, last_count = top(count_stack)
      end
    end
  end
  return i
end

print(aoc_9b(@aoc_input))
