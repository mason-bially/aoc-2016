include("../day12/shared.jl")

abstract AssemBunny23 <: AssemBunny

function inst_tgl(s::AssemBunnyState, p::AssemBunnyCode, r1::AssemBunnyArgument)
  o = eval_arg(s, r1)
  i = o + s[5] - 1

  # Outside program, nothing happens
  if i < 1 || i > length(p)
    return
  end

  # One argument
  if p[i].argc == 1
    # inc becomes dec
    if p[i].op == '+'
      p[i].op = '-'
    # All other becomes inc
    else
      p[i].op = '+'
    end
  # Two argument
  elseif p[i].argc == 2
    # jnz becomes cpy
    if p[i].op == 'j'
      p[i].op = 'c'
    # All other becomes jnz
    else
      p[i].op = 'j'
    end
  end
  # Invalid instructions are already ignored
  # Interpreter already skips this instruction
end

function parse_op(format ::Type{AssemBunny23}, str)
  if (str == "tgl") return ('t', 1);
  else return parse_op(AssemBunny12, str)
  end
end

function exec_inst(
  format::Type{AssemBunny23},
  inst ::AssemBunnyInstruction,
  prog ::AssemBunnyCode,
  state ::AssemBunnyState)

  if inst.op == 't' inst_tgl(state, prog, inst.arg1)
  else
    exec_inst(AssemBunny12, inst, prog, state)
  end
end

aoc_23(input, state::AssemBunnyState) = parse_and_run(AssemBunny23, input, state)[1]
