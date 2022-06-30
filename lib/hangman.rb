# frozen_string_literal: true

def random_word
  valid_words = []
  words = File.readlines('dictionary.txt')
  words.each do |word|
    valid_words.push(word) if word.length > 4 && word.length < 13
  end
  valid_words.sample
end

puts random_word
