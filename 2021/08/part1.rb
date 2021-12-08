#!/usr/bin/env ruby

knowns = [
  'abcefg',
  'cf',
  'acdeg',
  'acdfg',
  'bcdf',
  'abdfg',
  'abdefg',
  'acf',
  'abcdefg',
  'abcdfg',
]

# 0 (6)
# 1 (2)
# 2 (5)
# 3 (5)
# 4 (4)
# 5 (5)
# 6 (6)
# 7 (3)
# 8 (7)
# 9 (6)

# (0...knowns.length).each do |i|
#   puts "#{i} (#{knowns[i].length})"
# end

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

easies = 0

$lines.each do |line|
  samples,code = line.split(' | ')
  easies += code.split(' ').filter{|s| [2, 4, 3, 7].include?(s.length)}.count
end
puts easies
