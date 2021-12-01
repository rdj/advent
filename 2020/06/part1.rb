#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)

total = 0
counts = {}
$lines.each do |line|
  if line.empty?
    total += counts.values.sum
    counts = {}
  end
  line.chars.each do |c|
    counts[c] = 1
  end
end
total += counts.values.sum
puts total
