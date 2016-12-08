"""
    alpha2ord(c)

Converts an alpha character to a 1 indexed ordinal.
"""
function alpha2ord(c::Char; basis::Integer=1) ::Integer
  return Int(c) + -Int('a') + basis
end

"""
    ord2alpha(i)

Converts a 1 indexed ordinal to an alpha character.
"""
function ord2alpha(i::Integer; basis::Integer=1) ::Char
  return Char(i + Int('a') + -basis)
end
