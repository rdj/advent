#!/usr/bin/env ruby

require 'set'

# Couple helper functions to gloss over some potentially confusing syntax
def intersection(array_of_sets)
  array_of_sets.reduce(&:intersection)
end

def string_to_set(s)
  Set[*s.chars]
end

def union(array_of_sets)
  array_of_sets.reduce(&:union)
end

class Cipher
  VOCABULARY = [
    'abcefg',
    'cf',
    'acdeg',
    'acdfg',
    'bcdf',
    'abdfg',
    'abdefg',
    'acf',
    'abcdefg',
    'abcdfg'
  ].map{ |s| string_to_set(s) }

  ALPHABET = union(VOCABULARY)

  def initialize
    # At first, each letter could substitute for any other letter
    @possible_subs = {}
    ALPHABET.each do |letter|
      @possible_subs[letter] = ALPHABET
    end
  end

  def decode_phrase(cipher_phrase)
    code = 0
    cipher_phrase.split(' ').each do |cipher_string|
      code *= 10
      code += decode(cipher_string)
    end
    return code
  end

  def decode(cipher_string)
    cipher_letters = string_to_set(cipher_string)
    plain_string = cipher_letters.map{ |cipher_letter| @possible_subs[cipher_letter].first }.join('')
    return VOCABULARY.index(string_to_set(plain_string))
  end

  def learn_phrase(cipher_phrase)
    cipher_phrase.split(' ').each do |cipher_string|
      learn(cipher_string)
    end
  end

  def learn(cipher_string)
    cipher_letters = string_to_set(cipher_string)

    # The letters in our cipher string can only substitute for letters
    # in strings of the same length from our vocabulary
    possible_words = VOCABULARY.select{|w| w.length == cipher_string.length}

    # This teaches us something about each cipher letter in our
    # alphabet, based on whether it did or did not appear in this
    # particular cipher string
    ALPHABET.each do |letter|
      if cipher_letters.include? letter
        learn_positive(letter, possible_words)
      else
        learn_negative(letter, possible_words)
      end

      handle_if_solved(letter)
    end
    #puts "After learning #{cipher_string} => #{possible_words}"
    #pp @possible_subs
  end

  def learn_negative(cipher_letter, possible_words)
    must_not_be_in_set = intersection(possible_words)
    @possible_subs[cipher_letter] = @possible_subs[cipher_letter] - must_not_be_in_set
  end

  def learn_positive(cipher_letter, possible_words)
    must_be_in_set = union(possible_words)
    @possible_subs[cipher_letter] = @possible_subs[cipher_letter].intersection(must_be_in_set)
  end

  # If we have eliminated all but one possible sub for this cipher
  # letter, then it is solved, and we know for sure what plaintext
  # letter it maps to. We can then eliminate that plaintext letter
  # from the possibilities for all the remaining cipher letters.
  def handle_if_solved(cipher_letter)
    if @possible_subs[cipher_letter].length > 1
      return
    end

    solved_cipher_letter_set = Set[cipher_letter]
    solved_plain_letter_set = @possible_subs[cipher_letter]
    (ALPHABET - solved_cipher_letter_set).each do |letter|
      @possible_subs[letter] = @possible_subs[letter] - solved_plain_letter_set
    end
  end
end

codes = []
$lines = ARGF.readlines.map(&:chomp)
$lines.each do |line|
  cipher = Cipher.new
  phrase_to_learn,phrase_to_decode = line.split(' | ')
  cipher.learn_phrase(phrase_to_learn)
  codes.push(cipher.decode_phrase(phrase_to_decode))
end
puts codes.sum
