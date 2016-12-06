room(line) = match(r"(?P<name>[a-z\-]*)(?P<number>\d*)\[(?P<chksum>\w*)\]", line)

function room_checksum(room)
  a = zeros(UInt32, 26)
  foreach(c -> a[alpha2ord(c)] += 1, filter(isalpha, room[:name]))
  return vec(a) |>
    enumerate |>
    _ -> sort(collect(_); by=t->t[2], rev=true) |>
    _ -> take(_, 5) |>
    _ -> map(t -> ord2alpha(t[1]), _) |>
    join
end

room_valid(room) = room_checksum(room) == room[:chksum]
room_value(room) = room_valid(room) ? parse(UInt32, room[:number]) : 0
room_value(s::AbstractString) = room_value(room(s))

function room_decipher(room)
  i = parse(Int32, room[:number])
  return join(map(c -> (c != '-') ? ord2alpha(((alpha2ord(c) - 1 + i) % 26) + 1) : ' ', room[:name]))
end
room_decipher(s::AbstractString) = room_decipher(room(s))
