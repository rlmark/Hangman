require 'colorize.rb'

#######################
# Hanging Man Image
#######################

#######################
# Original Word
#######################

class OriginalWord
  attr_accessor :mystery_word, :mystery_length

  def initialize(mystery_word)
    @mystery_word = mystery_word
    @mystery_length = mystery_word.length
  end
end

#######################
# Blank Letter Slot
#######################

# The goal is to print out a series of hidden letters
# and uncover them as user guesses

# Maybe in future, have Blankletter Inherit from OriginalWord
class BlankLetters
  attr_accessor :guess, :mystery_word, :mystery_length, :display_array

  def initialize(guess, mystery_word, mystery_length, display_array)
    @guess = guess
    @mystery_word = mystery_word
    @mystery_length = mystery_length
    @display_array = display_array
  end


  def display
    # This creates display array for very first time.
    if @display_array == []
      @mystery_length.times do
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

class LetterBank
  attr_accessor :unused_letters, :guesses

  def initialize(guesses)
    @guesses = guesses
  end

  def make_bank

  end
end

#######################
# User Guess
#######################

# class UserGuess
#   attr_accessor
#
#   def initialize
#   end
# end


#######################
# Used Letters
#######################



#######################
# Turns
#######################

class Turns
  attr_accessor :guesses, :mystery_word

  def initialize(guesses, mystery_word)
    @guesses = guesses
    @mystery_word = mystery_word
  end

  def win_checker
    (@guesses - @mystery_word).empty?
  end

end


#######################
# PLAYER 1
#######################

puts "Welcome to Hangman!"
puts "Player 1, what is your mystery word?"
mystery_word = gets.chomp.downcase.chars

p1_input = OriginalWord.new(mystery_word)
p1_input.mystery_length

#puts " " * 9000

# Setting up neccessary arrays and variables
guesses = []
display_array = []
turns = 6

while turns > 0

  # Asks Player 2 for letter, pushes that letter to array
  puts ""
  puts "Player 2, what letter would you like to guess?"
  guess = gets.chomp.downcase
  guesses << guess

  # Display Hangman image based on turns

  # Display remaining letter options.

  # Creates blank slot and checks if user guess is right
  create_blanks = BlankLetters.new(guess, mystery_word, p1_input.mystery_length, display_array)
  create_blanks.display

  turns -=1
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
