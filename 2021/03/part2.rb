#!/usr/bin/env ruby

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

def get_counts(lines)
  counts = []
  lines.each do |line|
    (0...line.length).each do |i|
      if counts[i].nil?
        counts[i] = 0
      end
      counts[i] += line[i].to_i
    end
  end
  counts
end

a = $lines.dup

(0...a[0].length).each do |i|
  if 1 == a.length
    break
  end
  counts = get_counts(a)
  pp a
  puts "[#{i}]: #{counts[i]} <=> #{a.length / 2.0}"
  if counts[i] >= (a.length / 2.0)
    puts "keeping [#{i}]=1"
    a = a.filter{|s| s[i] == '1'}
  elsif counts[i] < (a.length / 2.0)
    puts "keeping [#{i}]=0"
    a = a.filter{|s| s[i] == '0'}
  end
end

oxygen = a[0]
puts "oxygen: #{oxygen}"

a = $lines.dup

(0...a[0].length).each do |i|
  if 1 == a.length
    break
  end
  counts = get_counts(a)
  pp a
  puts "[#{i}]: #{counts[i]} <=> #{a.length / 2.0}"
  if counts[i] >= (a.length / 2.0)
    puts "keeping [#{i}]=0"
    a = a.filter{|s| s[i] == '0'}
  elsif counts[i] < (a.length / 2.0)
    puts "keeping [#{i}]=1"
    a = a.filter{|s| s[i] == '1'}
  end
end

co2 = a[0]
puts "co2: #{co2}"

puts oxygen.to_i(2) * co2.to_i(2)
