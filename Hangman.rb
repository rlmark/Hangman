require 'colorize.rb'


#######################
# Original Word
#######################

class OriginalWord
  attr_accessor :mystery_word

  def initialize(mystery_word)
    @mystery_word = mystery_word
  end
end

#######################
# Blank Letter Slot
#######################

# The goal is to print out a series of hidden letters
# and uncover them as user guesses

class BlankLetters
  attr_accessor :guess, :mystery_word, :display_array

  def initialize(guess, mystery_word, display_array)
    @guess          = guess
    @mystery_word   = mystery_word
    @display_array  = display_array
  end

  def display
    # This creates display array for very first time.
    if @display_array == []
      @mystery_word.length.times do
        @display_array << "___"
      end
    end

    # This creates display array with user guess input at index
    @mystery_word.each_with_index do |letter, index|
      if letter == @guess
        @display_array[index] = letter
      end
    end
    print @display_array
  end
end

#######################
# Total Letter Bank
#######################

# Should display the letter options to user, then subtract or color out used letters
# Note, colorize doesn't appear to work because not using print/puts method...

class LetterBank
  attr_accessor :unused_letters, :guesses

  def initialize(guesses)
    @guesses = guesses
  end

  def make_bank
    @unused_letters = ("a".."z").to_a
    @unused_letters.map.with_index do |letter, index|
      if @guesses.include? letter
        @unused_letters[index] = "___"
      end
    end
    puts "Choose from these letters"
    print @unused_letters
    puts "\n" * 3
  end
end

#######################
# Turns
#######################

class Turn
  attr_accessor :guess, :turns

  def initialize (mystery_word)
    @mystery_word = mystery_word
    @turns = 7
  end

  def turn_checker(guess)
    puts "Value of guess as param #{guess}"
    if @mystery_word.include? (guess)
      @turns = @turns
      # puts "Value of turns if correct guess #{@turns}"
    else
      @turns -= 1
      # puts "Value of turns if incorrect guess #{@turns}"
    end
  end
end

#######################
# PLAYER 1
#######################

puts "Welcome to Hangman!"
puts "Player 1, what is your mystery word?"
mystery_word = gets.chomp.downcase.chars

OriginalWord.new(mystery_word)

puts " \n" * 100

# Setting up neccessary arrays and variables
guesses = []
display_array = []

#######################
# PLAYER 2
#######################

game_progress = Turn.new(mystery_word)

while game_progress.turns > 0

  # Asks Player 2 for letter, pushes that letter to array
  puts ""
  puts "Player 2, what letter would you like to guess?"
  guess = gets.chomp.downcase
  guesses << guess

  # Display remaining letter options.
  letter_options = LetterBank.new(guesses)
  letter_options.make_bank

  # Display Hangman image based on turns


  # Creates blank slot and checks if user guess is right
  BlankLetters.new(guess, mystery_word, display_array).display

  # Need to add +1 function for turns.
  game_progress.turn_checker(guess)

  if (mystery_word - guesses).empty?
    puts ""
    abort "YOU WIN!"
  end

end
puts ""
puts "Sorry, You died."















# @display_array.map.with_index { |letter, index|
#     if letter = @guess
#       @display_array[index] = @guess
#       print @display_array
#     else
#       puts ""
#       #print @display_array
#     end
#   }
#   #print @display_array
  # @display_array.collect { |letter, index|
  #     if letter == @guess
  #       @display[index] = @guess
  #       print @display_array
  #     else
  #       puts ""
  #       #print @display_array
  #       puts ""
  #     end
  #     print @display_array
  #   }

    #puts "DEBUG: Is letter showing up " + @guess
    #   # put the guess into the new array, at that same index.
    #   @mystery_word.each do |letter|
    #     if @guess == letter
    #     end
    #   end
    # end
    #   # Need to run through array of chars and see guess matches, if guess matches,
    #   # then print out unhidden version of guess.
    #   #  puts letter
    #
    #   # Try map with index
    #
    #   #displays the unguessed letters as slots.
