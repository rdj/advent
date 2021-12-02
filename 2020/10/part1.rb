#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp).map{|s| s.to_i(10)}

$lines.sort!
mine = $lines.max + 3
puts "mine #{mine}"
$lines.unshift(0)
$lines.push(mine)

diffs = []
(1...$lines.length).each do |i|
  diffs.push($lines[i] - $lines[i-1])
end
pp $lines
pp diffs
ones = diffs.count(1)
threes = diffs.count(3)
puts "1: #{ones}; 3: #{threes}"
puts ones * threes
