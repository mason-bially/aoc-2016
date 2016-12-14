include("../util/aoc.jl")
using AoC
using Iterators
using DataStructures
using Nettle
include("shared.jl")

function aoc_14a()
  i = 0; h = Hasher("MD5")
  list = nil()
  viable_hashes = 0

  last_key = 0

  looking_for = Dict{Char, Int64}()
  pot_key = Dict{Int64, Set{Char}}()

  salt = "yjdafjpo"
  #salt = "abc"
  while viable_hashes != 64

    if i % 10000 == 0
      println("$i")
    end

    Nettle.update!(h, "$salt$i");
    s = hexdigest!(h)
    (_3s, _5s) = contains_3_or_5_of_same(s)

    for _5 in _5s
      if haskey(looking_for, _5) && looking_for[_5] > 0
        key_set = Set{Int64}()
        for (k, v) in pot_key
          if in(_5, v)
            union!(key_set, [k])
          end
        end

        for key in key_set
          println("KEY: $key")
          viable_hashes += 1
          for c in pot_key[key]
            looking_for[c] -= 1
          end
          delete!(pot_key, key)
        end
      end
    end

    if length(_3s) != 0
      for _3 in _3s
        if !haskey(looking_for, _3)
          looking_for[_3] = 0
        end
        looking_for[_3] += 1
      end
      pot_key[i] = _3s
    end

    if haskey(pot_key, i - 1000)
      for c in pot_key[i - 1000]
        looking_for[c] -= 1
      end
      delete!(pot_key, i - 1000)
    end

    if viable_hashes >= 64
      break;
    end
    i += 1
  end
  return i;
end

print(aoc_14a())
