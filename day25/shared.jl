include("../day23/shared.jl")

abstract AssemBunny25 <: AssemBunny

function inst_out(s::AssemBunnyState, p::AssemBunnyCode, r1::AssemBunnyArgument)
  v = eval_arg(s, r1)

  if s[6] == v
    throw(false)
  elseif s[7] > 10000
    throw(true)
  end

  s[6] = v
  s[7] += 1
end

function parse_op(format ::Type{AssemBunny25}, str)
  if (str == "out") return ('o', 1);
  else return parse_op(AssemBunny23, str)
  end
end

function exec_inst(
  format::Type{AssemBunny25},
  inst ::AssemBunnyInstruction,
  prog ::AssemBunnyCode,
  state ::AssemBunnyState)

  if inst.op == 'o' inst_out(state, prog, inst.arg1)
  else
    exec_inst(AssemBunny23, inst, prog, state)
  end
end

function aoc_25(input)
  prog = parse_program(AssemBunny25, input)

  a = -1

  local found::Bool = false
  while !found
    a += 1
    state = [a, 0, 0, 0, 1, 1, 0]
    try
      exec_program(AssemBunny25, prog, state)
    catch e
      if isa(e, Bool)
        found = e
        r6 = state[6]
        r7 = state[7]
        println("$a : $r6, $r7")
      else
        rethrow(e)
      end
    end
  end
  return a
end
