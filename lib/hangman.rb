# frozen_string_literal: true

def random_word
  valid_words = []
  words = File.readlines('dictionary.txt')
  words.each do |word|
    valid_words.push(word) if word.length > 4 && word.length < 13
  end
  valid_words.sample
end

def display_hangman(guesses)
  case guesses
  when 5
    puts '  O  '
    puts '     '
    puts '     '
  when 4
    puts ' _O  '
    puts '     '
    puts '     '
  when 3
    puts ' _O_ '
    puts '     '
    puts '     '
  when 2
    puts ' _O_ '
    puts '  |  '
    puts '     '
  when 1
    puts ' _O_ '
    puts '  |  '
    puts ' /   '
  when 0
    puts ' _O_ '
    puts '  |  '
    puts ' / \ '
  end
end

secret_word = random_word
puts secret_word

puts display_hangman(0)
