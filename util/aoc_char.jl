
function char2ord(c::Char) ::Int
  return Int(c) + 1 + -Int('a')
end

function ord2char(i::Int) ::Char
  return Char(i + -1 + Int('a'))
end
