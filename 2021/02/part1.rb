#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

horz = 0
depth = 0

$lines.each do |s|
  dir, arg = /^(\S+) (\d+)$/.match(s).captures
  n = arg.to_i
  case dir
  when 'forward'
    horz += n
  when 'down'
    depth += n
  when 'up'
    depth -= n
  end
end

puts horz * depth
