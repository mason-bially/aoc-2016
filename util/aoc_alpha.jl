"""
    alpha2ord(c)

Converts an alpha character to a 1 indexed ordinal.
"""
function alpha2ord(c::Char) ::Integer
  return Int(c) + -Int('a') + 1
end

"""
    ord2alpha(i)

Converts a 1 indexed ordinal to an alpha character.
"""
function ord2alpha(i::Integer) ::Char
  return Char(i + Int('a') + -1)
end
