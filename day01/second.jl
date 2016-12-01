using DataStructures

aoc_input = "R3, L5, R1, R2, L5, R2, R3, L2, L5, R5, L4, L3, R5, L1, R3, R4, R1, L3, R3, L2, L5, L2, R4, R5, R5, L4, L3, L3, R4, R4, R5, L5, L3, R2, R2, L3, L4, L5, R1, R3, L3, R2, L3, R5, L194, L2, L5, R2, R1, R1, L1, L5, L4, R4, R2, R2, L4, L1, R2, R53, R3, L5, R72, R2, L5, R3, L4, R187, L4, L5, L2, R1, R3, R5, L4, L4, R2, R5, L5, L4, L3, R5, L2, R1, R1, R4, L1, R2, L3, R5, L4, R2, L3, R1, L4, R4, L1, L2, R3, L1, L1, R4, R3, L4, R2, R5, L2, L3, L3, L1, R3, R5, R2, R3, R1, R2, L1, L4, L5, L2, R4, R5, L2, R4, R4, L3, R2, R1, L4, R3, L3, L4, L3, L1, R3, L2, R2, L4, L4, L5, R3, R5, R3, L2, R5, L2, L1, L5, L1, R2, R4, L5, R2, L4, L5, L4, L5, L2, L5, L4, R5, R3, R2, R2, L3, R3, L2, L5"

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
        print("collides")
        print(s)
        print(": ")
        print((x0, sy0))
        return (x0, sy0)
      end
    else
      y_between_sy = y0 >= min(sy0, sy1) && y0 <= max(sy0, sy1)
      sx_between_x = sx0 >= min(x0, x1) && sx0 <= max(x0, x1)
      if y_between_sy && sx_between_x
        print(seg)
        print("collides")
        print(s)
        print(": ")
        print((sx0, y0))
        return (sx0, y0)
      end
    end
  end
  return false
end

function parse_aoc_1b(input)
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

print(parse_aoc_1b(aoc_input))
