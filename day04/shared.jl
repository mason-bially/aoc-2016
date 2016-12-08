using DataStructures

room(line) = match(r"(?P<name>[a-z\-]*)(?P<number>\d*)\[(?P<chksum>\w*)\]", line)

function room_checksum(room)
  return room[:name] |> _ -> filter(isalpha, _) |>
    collect ∘ counter ∘ collect |>
    _ -> sort(_; by=t->t[1], rev=false) |>
    _ -> sort(_; by=t->t[2], rev=true) |>
    _ -> take(_, 5) |>
    _ -> map(t -> t[1], _) |>
    join
end

room_valid(room) = room_checksum(room) == room[:chksum]
room_value(room) = room_valid(room) ? parse(UInt32, room[:number]) : 0
room_value(s::AbstractString) = room_value(room(s))

function room_decipher(c::Char, i::Int32)
  return c != '-' ? ord2alpha((alpha2ord(c; basis=0) + i) % 26; basis=0) : ' '
end

function room_decipher(room)
  i = parse(Int32, room[:number])
  return room[:name] |>
    _ -> map(c -> room_decipher(c, i), _) |>
    join
end
room_decipher(s::AbstractString) = room_decipher(room(s))
