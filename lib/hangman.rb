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

def compare_guess(secret, guess, current)
  secret.each_with_index do |letter, index|
    current[index] = letter if guess == letter
  end
  current
end

secret_word = random_word.chomp.split('')
guesses_remaining = 6
correct_letters = Array.new(secret_word.length, '_')
puts 'Welcome to Hangman!'
while guesses_remaining >= 0
  display_hangman(guesses_remaining)
  puts correct_letters.join(' ')
  puts 'Please input a letter to guess:'
  guess = gets.chomp
  while guess.length > 1 || guess.to_i.to_s == guess
    puts 'Please enter a valid letter:'
    guess = gets.chomp
  end
  correct_letters = compare_guess(secret_word, guess, correct_letters)
end
