
function alpha2ord(c::Char) ::Integer
  return Int(c) + -Int('a') + 1
end

function ord2alpha(i::Integer) ::Char
  return Char(i + Int('a') + -1)
end
