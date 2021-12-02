#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp).map{|s| s.to_i(10)}

PREAMBLE = 25
target = nil

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
    target = cur
    puts "[#{i}] = #{cur} is not the sum of two of the previous #{PREAMBLE} numbers"
    break
  end
end

(0...$lines.count).each do |first|
  (first+1...$lines.count).each do |last|
    sub = $lines[first...last]
    if sub.sum == target
      puts "[#{first}..#{last}] == #{target}"
      puts sub.min + sub.max
    end
  end
end
