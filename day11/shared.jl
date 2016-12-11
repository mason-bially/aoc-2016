
type ElementRTGComponents
  element::String
  gen_floor::Int
  mic_floor::Int
end

function parse_components(str)
  floor = 0
  comps = Array{ElementRTGComponents}(0)
  for s in split(str, '\n'; limit=4)
    floor += 1
    if contains(s, "contains nothing relevant")
      continue
    end

    m = match(r"The [a-z]* floor contains", s)
    for component in split(s[length(m.match):end], r", a |,* and a ")
      m = match(r"(?P<elem>[a-z]+)(?:( generator)|(\-compatible microchip))", component)
      element = m[:elem]
      existing = find(comp -> comp.element == element, comps)
      if m.offsets[3] == 0
        if length(existing) != 0
          comps[existing[1]].gen_floor = floor
        else
          push!(comps, ElementRTGComponents(element, floor, -1))
        end
      else
        if length(existing) != 0
          comps[existing[1]].mic_floor = floor
        else
          push!(comps, ElementRTGComponents(element, -1, floor))
        end
      end
    end
  end
  return comps
end

function solve_comps(comps)
  items_per_floor = zeros(Int, 4)
  item_count = length(comps) * 2

  for comp in comps
    items_per_floor[comp.gen_floor] += 1
    items_per_floor[comp.mic_floor] += 1
  end

  # Analysis presents 2 * n - 3 as the number of moves ot move up a floor
  moves = 0
  floor = 1
  while items_per_floor[4] != item_count
    moves += 2 * items_per_floor[floor] - 3
    items_per_floor[floor + 1] += items_per_floor[floor]
    floor += 1
  end

  return moves
end
