function reg_map(c)
  if c == 'a'
    return 1;
  elseif c == 'b'
    return 2;
  elseif c == 'c'
    return 3
  elseif c == 'd'
    return 4
  else
    return false
  end
end

function inst_cpy_vreg(s, n, r)
  s[r] = n
end

function inst_cpy_rreg(s, r0, r1)
  s[r1] = s[r0]
end

function inst_inc(s, r)
  s[r] += 1
end

function inst_dec(s, r)
  s[r] -= 1
end

function inst_jnz(s, r, o)
  if r == false || s[r] != 0
    s[5] += o - 1
  end
end

function inst(str) ::Tuple{Char, Int, Int}
  if startswith(str, "cpy")
    if isalpha(str[5])
      return ('r', reg_map(str[5]), reg_map(str[7]))
    else
      return ('v', parse(str[5:end-2]), reg_map(str[end]))
    end
  elseif startswith(str, "inc")
    return ('i', reg_map(str[5]), 0)
  elseif startswith(str, "dec")
    return ('d', reg_map(str[5]), 0)
  elseif startswith(str, "jnz")
    return ('j', reg_map(str[5]), parse(str[7:end]))
  else
    println(str)
  end
end

function aoc_12(input, state=[0, 0, 0, 0, 1])
  prog = Array{Tuple{Char, Int, Int}}(0)

  for l in split(input, '\n'; keep=false)
    push!(prog, inst(l))
  end

  pl = length(prog)
  while(state[5] <= pl)
    i = state[5]
    state[5] += 1

    p = prog[i]
    if p[1] == 'r' inst_cpy_rreg(state, p[2], p[3])
    elseif p[1] == 'v' inst_cpy_vreg(state, p[2], p[3])
    elseif p[1] == 'i' inst_inc(state, p[2])
    elseif p[1] == 'd' inst_dec(state, p[2])
    elseif p[1] == 'j' inst_jnz(state, p[2], p[3])
    else end
  end

  return state[1]
end
