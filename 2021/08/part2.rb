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

LETTERS = 'abcdefg'.chars

values = []
$lines.each do |line|
  samples,code = line.split(' | ')
  letters = Hash.new{|n| 'abcdefg'.chars}
  samples.split(' ').each do |sample|
    possibilities = knowns.filter{|k| k.length == sample.length}.map(&:chars)
    LETTERS.each do |c|
      if sample.chars.include? c
        letters[c] = letters[c].intersection(possibilities.flatten.uniq)
      else
        letters[c] = letters[c] - possibilities.reduce(LETTERS, :intersection)
      end
      if letters[c].length == 1
        (LETTERS - [c]).each do |r|
          letters[r] = letters[r] - letters[c]
        end
      end
    end
    #pp letters
  end
#  pp letters
  value = []
  code.split(' ').each do |word|
    deword = word.split('').map{|c| letters[c]}.sort.join('')
    decode = knowns.index(deword)
#    puts "#{decode} :  #{word} => #{deword}"
    value.push(decode)
  end
  value = value.join('').to_i
  puts "#{value} <= #{code}"
  values.push(value)
end

puts values.sum
