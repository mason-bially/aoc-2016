using DataStructures
include("../util/aoc.jl")
using AoC;

function check_collision(list, seg)
  x0, y0, x1, y1 = seg
  vert = (x0 - x1 == 0)

  for s in drop(list, 1)
    sx0, sy0, sx1, sy1 = s
    svert = (sx0 - sx1 == 0)

    # parallel
    if vert == svert
      continue
    end

    if vert
      x_between_sx = x0 >= min(sx0, sx1) && x0 <= max(sx0, sx1)
      sy_between_y = sy0 >= min(y0, y1) && sy0 <= max(y0, y1)
      if x_between_sx && sy_between_y
        print(seg)
        print(" collides ")
        print(s)
        print(": ")
        println((x0, sy0))
        return (x0, sy0)
      end
    else
      y_between_sy = y0 >= min(sy0, sy1) && y0 <= max(sy0, sy1)
      sx_between_x = sx0 >= min(x0, x1) && sx0 <= max(x0, x1)
      if y_between_sy && sx_between_x
        print(seg)
        print(" collides ")
        print(s)
        print(": ")
        println((sx0, y0))
        return (sx0, y0)
      end
    end
  end
  return false
end

function aoc_1b(input)
  entries = split(input, ", "; keep=false)

  x = 0; y = 0

  facing_y = true
  facing_neg = false

  l = nil()

  for e in entries
    facing_y = ! facing_y
    if e[1] == 'R' && facing_y
      facing_neg = ! facing_neg
    elseif e[1] == 'L' && !facing_y
      facing_neg = ! facing_neg
    end

    v = parse(Int32, e[2:end])
    if facing_neg
      v = -v
    end

    oldx = x; oldy = y

    if facing_y
      y += v
    else
      x += v
    end

    this_seg = (oldx, oldy, x, y)

    r = check_collision(l,  this_seg)
    if r != false
      return abs(r[1]) + abs(r[2])
    end
    l = cons(this_seg, l)
  end

  return l
end

print(aoc_1b(@aoc_input))
