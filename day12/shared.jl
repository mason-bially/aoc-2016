abstract AssemBunny
abstract AssemBunny12 <: AssemBunny

type AssemBunnyInstruction
  op::Char
  arg0::Int64
  arg1::Int64
end

typealias AssemBunnyCode Array{AssemBunnyInstruction}
typealias AssemBunnyState Array{Int64,1}

function reg_map(c)::Int64
  if c == 'a'
    return 1;
  elseif c == 'b'
    return 2;
  elseif c == 'c'
    return 3
  elseif c == 'd'
    return 4
  else
    return 0
  end
end

function inst_cpy_vreg(s::AssemBunnyState, n::Int64, r::Int64)
  s[r] = n
end

function inst_cpy_rreg(s::AssemBunnyState, r0::Int64, r1::Int64)
  s[r1] = s[r0]
end

function inst_inc(s::AssemBunnyState, r::Int64)
  s[r] += 1
end

function inst_dec(s::AssemBunnyState, r::Int64)
  s[r] -= 1
end

function inst_jnz(s::AssemBunnyState, r::Int64, o::Int64)
  if r == 0 || s[r] != 0
    s[5] += o - 1
  end
end

function parse_inst(format ::Type{AssemBunny12}, str) ::AssemBunnyInstruction
  if startswith(str, "cpy")
    if isalpha(str[5])
      return AssemBunnyInstruction('r', reg_map(str[5]), reg_map(str[7]))
    else
      return AssemBunnyInstruction('v', parse(str[5:end-2]), reg_map(str[end]))
    end
  elseif startswith(str, "inc")
    return AssemBunnyInstruction('i', reg_map(str[5]), 0)
  elseif startswith(str, "dec")
    return AssemBunnyInstruction('d', reg_map(str[5]), 0)
  elseif startswith(str, "jnz")
    return AssemBunnyInstruction('j', reg_map(str[5]), parse(str[7:end]))
  else
    println(str)
  end
end

function parse_program(format, input) ::AssemBunnyCode
  ret = AssemBunnyCode(0)

  for l in split(input, '\n'; keep=false)
    push!(ret, parse_inst(format, l))
  end

  return ret
end

function exec_inst(format ::Type{AssemBunny12}, inst ::AssemBunnyInstruction, state ::AssemBunnyState)
  if inst.op == 'r' inst_cpy_rreg(state, inst.arg0, inst.arg1)
  elseif inst.op == 'v' inst_cpy_vreg(state, inst.arg0, inst.arg1)
  elseif inst.op == 'i' inst_inc(state, inst.arg0)
  elseif inst.op == 'd' inst_dec(state, inst.arg0)
  elseif inst.op == 'j' inst_jnz(state, inst.arg0, inst.arg1)
  else
    throw(inst)
  end
end

function exec_program(format, prog::AssemBunnyCode, state::AssemBunnyState)
  pl = length(prog)

  while(state[5] <= pl)
    i = state[5]
    state[5] += 1

    exec_inst(format, prog[i], state)
  end

  return state
end

parse_and_run(format, input, state::AssemBunnyState) = exec_program(format, parse_program(format, input), state)

aoc_12(input, state::AssemBunnyState) = parse_and_run(AssemBunny12, input, state)[1]
