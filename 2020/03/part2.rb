#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)

def treecount(colinc, rowinc)
  row = 0
  col = 0
  trees = 0
  ncols = $lines[0].length
  while row < $lines.count
    c = $lines[row][col]
    puts "#{row}, #{col} = #{c}"
    if $lines[row][col] == '#'
      trees += 1
    end
    row += rowinc
    col = (col + colinc) % ncols
  end
  return trees
end

puts (
  treecount(1, 1) *
  treecount(3, 1) *
  treecount(5, 1) *
  treecount(7, 1) *
  treecount(1, 2) )
