#!/usr/bin/env ruby

PAIRS = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>'
}

POINTS = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137
}

INCOMPLETE_POINTS = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}

$lines = ARGF.readlines.map(&:chomp)#.map{|s| s.to_i(10)}

incomplete = []
$lines.each do |line|
  expected = []
  line.chars.each do |c|
    pair = PAIRS[c]
    if !pair.nil?
      expected.push(pair)
    else
      expect = expected.pop
      if c != expect
        # corrupt line
        expected = []
        break
      end
    end
  end
  if !expected.empty?
    score = 0
    while c = expected.pop
      score *= 5
      score += INCOMPLETE_POINTS[c]
    end
    incomplete.push score
  end
end

incomplete.sort!
puts incomplete[incomplete.length / 2]
