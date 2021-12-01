#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)

total = 0
counts = {}
group = 0
$lines.each do |line|
  if line.empty?
    total += counts.values.filter{ |v| v == group }.length
    counts = {}
    group = 0
    next
  end
  group += 1
  line.chars.each do |c|
    if !counts[c]
      counts[c] = 1
    else
      counts[c] += 1
    end
  end
end
puts total
