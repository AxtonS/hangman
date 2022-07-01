# frozen_string_literal: true

def random_word
  valid_words = []
  words = File.readlines('dictionary.txt')
  words.each do |word|
    valid_words.push(word) if word.length > 4 && word.length < 13
  end
  valid_words.sample.downcase
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
used_letters = []
puts 'Welcome to Hangman!'

while guesses_remaining >= 0
  display_hangman(guesses_remaining)
  puts correct_letters.join(' ')

  if guesses_remaining.zero?
    puts 'You are out of guesses!'
    return
  elsif secret_word == correct_letters
    puts 'You win!'
    return
  else
    puts 'Please input a letter to guess:'
    guess = gets.chomp.downcase
    while guess.length > 1 || !guess.match?(/\A[a-zA-Z]*\z/) || used_letters.include?(guess)
      puts 'Please enter a valid letter:'
      guess = gets.chomp.downcase
    end
    used_letters.push(guess)
    if secret_word.include?(guess)
      correct_letters = compare_guess(secret_word, guess, correct_letters)
    else
      guesses_remaining -= 1
    end
  end
end
