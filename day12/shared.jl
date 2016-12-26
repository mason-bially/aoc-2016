abstract AssemBunny
abstract AssemBunny12 <: AssemBunny

type AssemBunnyArgument
  is_reg::Bool
  value::Int64
end

type AssemBunnyInstruction
  op::Char
  argc::UInt8
  arg1::AssemBunnyArgument
  arg2::AssemBunnyArgument
end

typealias AssemBunnyCode Array{AssemBunnyInstruction}
typealias AssemBunnyState Array{Int64,1}

function eval_arg(s::AssemBunnyState, a::AssemBunnyArgument) ::Int64
  if a.is_reg
    return s[a.value]
  else
    return a.value
  end
end

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

function inst_cpy(s::AssemBunnyState, a1::AssemBunnyArgument, a2::AssemBunnyArgument)
  if a2.is_reg
    s[a2.value] = eval_arg(s, a1)
  end
end

function inst_inc(s::AssemBunnyState, r::AssemBunnyArgument)
  if r.is_reg
    s[r.value] += 1
  end
end

function inst_dec(s::AssemBunnyState, r::AssemBunnyArgument)
  if r.is_reg
    s[r.value] -= 1
  end
end

function inst_jnz(s::AssemBunnyState, r1::AssemBunnyArgument, r2::AssemBunnyArgument)
  v = eval_arg(s, r1)
  j = eval_arg(s, r2)
  if v != 0
    s[5] += j - 1
  end
end

function parse_arg(format, str) ::AssemBunnyArgument
  if isalpha(str[1])
    if length(str) == 1
      return AssemBunnyArgument(true, reg_map(str[1]))
    end
  else
    return AssemBunnyArgument(false, parse(Int64, str))
  end
  throw(str)
end

function parse_op(format ::Type{AssemBunny12}, str)
  local op::Char
  local argc::UInt8
  if (str == "cpy") op = 'c'; argc = 2;
  elseif (str == "inc") op = '+'; argc = 1;
  elseif (str == "dec") op = '-'; argc = 1;
  elseif (str == "jnz") op = 'j'; argc = 2;
  else
    throw(str)
  end
  return (op, argc)
end

function parse_inst(format, str) ::AssemBunnyInstruction
  parts = split(str, ' '; keep=false)

  op, argc = parse_op(format, parts[1])

  arg1 = AssemBunnyArgument(true, 0)
  arg2 = AssemBunnyArgument(true, 0)
  if length(parts) > 1
    arg1 = parse_arg(format, parts[2])
  end
  if length(parts) > 2
    arg2 = parse_arg(format, parts[3])
  end

  return AssemBunnyInstruction(op, argc, arg1, arg2)
end

function parse_program(format, input) ::AssemBunnyCode
  ret = AssemBunnyCode(0)

  for l in split(input, '\n'; keep=false)
    push!(ret, parse_inst(format, l))
  end

  return ret
end

function exec_inst(
  format::Type{AssemBunny12},
  inst ::AssemBunnyInstruction,
  prog ::AssemBunnyCode,
  state ::AssemBunnyState)

  if inst.op == 'c' inst_cpy(state, inst.arg1, inst.arg2)
  elseif inst.op == '+' inst_inc(state, inst.arg1)
  elseif inst.op == '-' inst_dec(state, inst.arg1)
  elseif inst.op == 'j' inst_jnz(state, inst.arg1, inst.arg2)
  else
    throw(inst)
  end
end

function exec_program(format, prog::AssemBunnyCode, state::AssemBunnyState)
  pl = length(prog)

  while(state[5] <= pl)
    i = state[5]
    state[5] += 1

    exec_inst(format, prog[i], prog, state)
  end

  return state
end

parse_and_run(format, input, state::AssemBunnyState) = exec_program(format, parse_program(format, input), state)

aoc_12(input, state::AssemBunnyState) = parse_and_run(AssemBunny12, input, state)[1]
