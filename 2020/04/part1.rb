#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)

$expected = %w{ byr iyr eyr hgt hcl ecl pid }.sort
$optional = %w{ cid }

def valid(keys)
  (keys - $optional).sort == $expected
end

nvalid = 0
keys = []
$lines.each do |line|
  if line.empty?
    if valid(keys)
      nvalid += 1
    end
    keys = []
  else
    keys.append(*line.split.map{|w| w.split(':')[0]})
  end
end
puts nvalid
