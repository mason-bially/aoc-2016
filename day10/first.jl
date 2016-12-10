workspace()
include("../util/aoc.jl")
using AoC
using Iterators
using DataStructures
include("shared.jl")

type Bot
     v_in1::Int
     v_in2::Int
     b_low::Int
     b_high::Int
 end

function bot_complete(bots, botnum)
  b = bots[botnum]
  return b.v_in1 != -1 && b.v_in2 != -1 && b.b_low != 0 && b.b_high != 0
end

function ensure_bot(bots, botnum, ouputs)
  if botnum < 0
    resize!(ouputs, -botnum)
  end
  if botnum > length(bots)
    resize!(bots, botnum)
  end
  if !isdefined(bots, botnum)
    bots[botnum] = Bot(-1, -1, 0, 0)
  end
end

function bot_apply_num(bots, botnum, value)
  if bots[botnum].v_in1 == -1
    bots[botnum].v_in1 = value
  elseif bots[botnum].v_in2 == -1
    bots[botnum].v_in2 = value
    l, h = min(bots[botnum].v_in1, bots[botnum].v_in2), max(bots[botnum].v_in1, bots[botnum].v_in2)
    bots[botnum].v_in1 = l
    bots[botnum].v_in2 = h
  else
    println("$botnum got too mny values")
  end
end

function do_bot(bots, botnum, outputs)
  if botnum != 0 && bot_complete(bots, botnum)
    if bots[botnum].b_low > 0
      bot_apply_num(bots, bots[botnum].b_low, bots[botnum].v_in1)
      do_bot(bots, bots[botnum].b_low)
    else
      outputs[-bots[botnum].b_low] = bots[botnum].v_in1
    end
    if bots[botnum].b_high > 0
      bot_apply_num(bots, bots[botnum].b_high, bots[botnum].v_in2)
      do_bot(bots, bots[botnum].b_high)
    else
      outputs[-bots[botnum].b_high] = bots[botnum].v_in2
    end
  end
end

function aoc_10a(input)
  bots = []
  outputs = []
  for line in split(input, '\n')
    botnum = 0
    if startswith(line, "value")
      m = match(r"value (?P<value>\d*) goes to bot (?P<botnum>\d*)", line)
      botnum = parse(m[:botnum]) + 1
      ensure_bot(bots, botnum, outputs)
      bot_apply_num(bots, botnum, parse(m[:value]))
    elseif startswith(line, "bot")
      m = match(r"bot (?P<botnum>\d*) gives low to (?P<low_loc>[a-z]*) (?P<low_locnum>\d*) and high to (?P<high_loc>[a-z]*) (?P<high_locnum>\d*)", line)
      botnum = parse(m[:botnum]) + 1
      lowlocnum = parse(m[:low_locnum]) + 1
      highlocnum = parse(m[:high_locnum]) + 1
      ensure_bot(bots, botnum, outputs)
      bots[botnum].b_low = (startswith(m[:low_loc], "output")) ? -lowlocnum : lowlocnum
      bots[botnum].b_high = (startswith(m[:high_loc], "output")) ? -highlocnum : highlocnum
      ensure_bot(bots, lowlocnum, outputs)
      ensure_bot(bots, highlocnum, outputs)
    end
    do_bot(bots, botnum)
  end
  for (i, bot) in enumerate(bots)
    if (bot.v_in1 == 17) && (bot.v_in2 == 61)
      return i - 1
    end
  end
end

print(aoc_10a(@aoc_input))
