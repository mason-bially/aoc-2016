
function command(str)
  m = match(r"(rect (?P<x>\d*)x(?P<y>\d*))|(rotate (?P<rot>row|column) (y|x)=(?P<t>\d*) by (?P<s>\d*))", str)
  kind = '?'
  if m[:rot] != nothing && m[:t] != nothing && m[:s] != nothing
    if m[:rot] == "row"
      return ('y', parse(m[:t]), parse(m[:s]))
    elseif m[:rot] == "column"
      return ('x', parse(m[:t]), parse(m[:s]))
    end
  elseif m[:x] != nothing && m[:y] != nothing
    return ('r', parse(m[:x]), parse(m[:y]))
  end
  return ('v')
end

function gen_display(input)
  a = zeros(UInt8, 50, 6)
  for cmd in split(input, "\n"; keep=false)
    c, t, s = command(cmd)
    if c == 'r'
      setindex!(a, ones(UInt8, t, s), 1:t, 1:s)
    elseif c == 'x'
      setindex!(a, circshift(view(a, t+1, 1:6), s), t+1, 1:6)
    elseif c == 'y'
      setindex!(a, circshift(view(a, 1:50, t+1), s), 1:50, t+1)
    end
  end
  return a
end

function display_char(c)
  for y in 1:6
    s = c[1:5, y] |> _ -> map(c -> c == 1 ? '*' : ' ', _) |> join
    println(s)
  end
  println("_____")
end
