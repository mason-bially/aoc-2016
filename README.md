Solutions for AOC2016 using julia.

I recommend using the [Juno atom addon](https://github.com/JunoLab/uber-juno/blob/master/setup.md). Then just hit `ctrl + shift + enter` on a file to see the result.

### Organization

* `template.jl`: Template of a first/second file.
* `util`: Library of helpers and functions specific to this competition.
* `day##`: Numbered day folder.
  * `input.txt`: Input file from website.
  * `first.jl`: Solution to the first half.
  * `second.jl`: Solution to the secont half.
  * `shared.jl`: Code shared between both solutions.
