#!/usr/bin/env ruby

grand_total = 0
ARGF.each do |line|
  (atleast, atmost, char, pw) = /(\d+)-(\d+) ([a-z]): ([a-z]+)/.match(line).captures
  count = pw.count(char)
  if count >= atleast.to_i && count <= atmost.to_i
    puts line
    grand_total += 1
  end
end
puts grand_total
