#!/usr/bin/env ruby

grand_total = 0
ARGF.each do |line|
  (pos1, pos2, char, pw) = /(\d+)-(\d+) ([a-z]): ([a-z]+)/.match(line).captures
  c1 = pw[pos1.to_i - 1]
  c2 = pw[pos2.to_i - 1]

  if c1 != c2 && ( c1 == char || c2 == char )
    puts line
    grand_total += 1
  end
end
puts grand_total
