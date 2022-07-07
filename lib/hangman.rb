# frozen_string_literal: true

require 'json'

# class to save/load game
class GameState
  attr_accessor :secret_word, :guesses_remaining, :correct_letters, :used_letters

  def initialize(secret_word, guesses_remaining, correct_letters, used_letters)
    @secret_word = secret_word
    @guesses_remaining = guesses_remaining
    @correct_letters = correct_letters
    @used_letters = used_letters
  end

  def save
    JSON.dump({
                secret_word: @secret_word,
                guesses_remaining: @guesses_remaining,
                correct_letters: @correct_letters,
                used_letters: @used_letters
              })
  end

  def self.load(string)
    data = JSON.parse(string)
    new(data['secret_word'], data['guesses_remaining'], data['correct_letters'], data['used_letters'])
  end
end

def random_word
  valid_words = []
  words = File.readlines('dictionary.txt')
  words.each do |word|
    valid_words.push(word) if word.length > 4 && word.length < 13
  end
  valid_words.sample.downcase
end

def display_hangman(guesses)
  puts "\n"
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

puts "\nIf you would like to load a previously saved game to play, please type 'load' and press enter"
if gets.chomp.downcase == 'load'
  puts "\nPlease type one of the following save files and press enter to play:"
  Dir.chdir('save_files')
  puts Dir.glob('*').join("\n")
  Dir.chdir('..')
  file_name = gets.chomp

  if File.exist?("save_files/#{file_name}")
    game = GameState.load(File.read("save_files/#{file_name}"))
    secret_word = game.secret_word
    guesses_remaining = game.guesses_remaining
    correct_letters = game.correct_letters
    used_letters = game.used_letters
  else
    puts "\nWe'll start a fresh game then."
  end
end

while guesses_remaining >= 0
  display_hangman(guesses_remaining)
  puts correct_letters.join(' ')

  puts "\nIf you would like to save and end your game please type 'save' and press enter"
  if gets.chomp.downcase == 'save'
    puts "\nName your save file:"
    name = gets.chomp
    while File.exist?("save_files/#{name}")
      puts "\nThat save file already exists, please enter another:"
      name = gets.chomp
    end
    game = GameState.new(secret_word, guesses_remaining, correct_letters, used_letters)
    Dir.mkdir('save_files') unless File.exist?('save_files')
    File.open("save_files/#{name}", 'w') do |file|
      file.puts(game.save)
    end
    return
  end

  if guesses_remaining.zero?
    puts "\nYou are out of guesses!"
    return
  elsif secret_word == correct_letters
    puts "\nYou win!"
    return
  else
    puts "\nPlease input a letter to guess:"
    guess = gets.chomp.downcase
    while guess.length > 1 || !guess.match?(/\A[a-zA-Z]*\z/) || used_letters.include?(guess)
      puts "\nPlease enter a valid letter:"
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
