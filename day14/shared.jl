


function contains_3_or_5_of_same(s::String)::Tuple{Set{Char}, Set{Char}}
  _3s = Set{Char}()
  _5s = Set{Char}()
  _last_4 = Array{Char}(4)
  for c in s
    if getindex(_last_4, 1) != '\0' && all(map(_ -> _ == c, _last_4))
      union!(_5s, [c])
    end
    if getindex(_last_4, 3) != '\0' && all(map(_ -> _ == c, _last_4[3:4]))
      union!(_3s, [c])
    end
    shift!(_last_4)
    push!(_last_4, c)
  end
  return (_3s, _5s)
end
