#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp).map{|s| s.to_i(10)}

PREAMBLE = 25

(PREAMBLE...$lines.count).each do |i|
  cur = $lines[i]
  found = false
  (i-PREAMBLE...i).each do |j|
    (j+1...i).each do |k|
      if cur == $lines[j] + $lines[k]
        found = true
        break
      end
    end
    if found
      break
    end
  end
  if !found
    puts "[#{i}] = #{cur} is not the sum of two of the previous #{PREAMBLE} numbers"
    exit 0
  end
end
