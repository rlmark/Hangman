require 'colorize.rb'

#######################
# Hangman
#######################

class Hangman
  attr_accessor :board

  def initialize
    @head       = " "
    @left_arm   = " "
    @right_arm  = " "
    @upper_body = " "
    @lower_body = " "
    @left_leg   = " "
    @right_leg  = " "

    refresh
  end

  # Method redraws board each time called so new variables are printed
  def refresh
    @board = "    +----+-|\n    #{@head}     \\|\n   #{@left_arm}#{@upper_body}#{@right_arm}     |\n    #{@lower_body}      |\n   #{@left_leg} #{@right_leg}     |\n           |\n-----------"
    puts @board
  end

  # HALP! This is bad, make key into turns and body part into hash?
  def draw(turns)
    if turns >= 7
      refresh
    elsif turns == 6
      # "the value of turns is #{turns}"
      @head = 'O'.red
      refresh
    elsif turns == 5
      @left_arm = "\\".blue
      refresh
    elsif turns == 4
      @right_arm = "/".yellow
      refresh
    elsif turns == 3
      @upper_body = "|".cyan
      refresh
    elsif turns == 2
      @lower_body = "|".green
      refresh
    elsif turns == 1
      @left_leg = "/".magenta
      refresh
    elsif turns == 0
      @right_leg = "\\".light_red
      refresh
    end
  end
end

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

  # Play around with putting first part of display in separate method.
  # call it within initialize to set default value once.That way I'm not
  # Creating a NEW OBJECT each time. Create the new object outside the while
  # loop once and then call the rest of display on that object.
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
  attr_accessor :turns

  def initialize (mystery_word)
    @mystery_word = mystery_word
    @turns = 7
  end

  def dying
    @turns -= 1
  end

  # What I did is to check if anything has been duplicated once, but
  # I want to know if last guess is a duplicate of existing array


  # Checks if player 2 guesses same letter twice
  # find last element of the array, see if it occurs anytime earlier
  # in array.

  # slices of array? Give me all but last element, as an array.
  # finding if


  # def no_repeats(guesses, guess)
  #   if guesses.length > 1
  #     puts "guesses before slice comparison #{guesses}"
  #     if guesses[0..-1].include?(guess)
  #       puts "guesses last element sliced #{guesses.slice!(-1)}"
  #
  #
  #       puts "DEBUG The value of guesses is #{guesses}"
  #       puts "You already guessed that letter"
  #       @turns
  #     end
  #   end
  # end

  # Advances game 1 turn closer to death
  def turn_checker(guess, guesses)
    if @mystery_word.include?(guess)
      # no_repeats(guesses, guess)
      return @turns
      puts "Debug turns if guess right: #{turns}"
    elsif
      # no_repeats(guesses, guess)
      puts "Debug turns if guess repeated: #{turns}"
    else
      dying
      puts "Debug turns if guess wrong #{turns}"
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
gameboard = Hangman.new

while game_progress.turns > 0

  # Asks Player 2 for letter, pushes that letter to array
  puts ""
  puts "Player 2, what letter would you like to guess?"
  guess = gets.chomp.downcase

  # Creates array only of unique entries.
  if guesses.include?(guess)
    next
  else
    guesses << guess
  end

  # Display remaining letter options.
  letter_options = LetterBank.new(guesses)
  letter_options.make_bank

  # Check if user has guessed a letter twice
  #game_progress.no_repeats(guesses)

  # Advances games by 1 turn or not depending on guess
  game_progress.turn_checker(guess, guesses)

  # Display Hangman image based on turns
  gameboard.draw(game_progress.turns)

  # Creates blank slot and checks if user guess is right
  BlankLetters.new(guess, mystery_word, display_array).display

  if (mystery_word - guesses).empty?
    puts ""
    abort "YOU WIN!"
  end
end

puts ""
puts "Sorry, You died."
puts "The mystery word was #{mystery_word.join" "}"



# @board = ["    -------|",
#   "    0     \\|",
#   "   \\|/     |",
#   "    |      |",
#   "   / \\     |",
#   "           |",
#   "-----------"]



# def initialize
#   @body =       [@head       = " ",
#                 @left_arm   = " ",
#                 @right_arm  = " ",
#                 @upper_body = " ",
#                 @lower_body = " ",
#                 @left_leg   = " ",
#                 @right_leg  = " "]
#
#   @board = "    -------|\n    #{@body[0]}     \\|\n   #{@body[1]}#{@upper_body}#{@right_arm}     |\n    #{@lower_body}      |\n   #{@left_leg} #{@right_leg}     |\n           |\n-----------"
#   puts @board
# end
#
# def print(turns)
#   #maybe try if index + 6
#
#
#   # puts "for printing board turns is #{turns}"
#
#   #
#   # if turns.to_i >= 7
#   #   puts @board
#   # elsif turns == 6
#   #   # puts "the value of turns is #{turns}"
#   #   @head = 'O'
#   #   puts @board
#   # elsif turns == 5
#   #   @left_arm == "\\"
#   #   print @left_arm
#   #   print "The value of turns is #{turns}"
#   # elsif turns == 4
#   #   @right_arm == "/"
#   # elsif turns == 3
#   #   @upper_body == "|"
#   # elsif turns == 2
#   #   @lower_body == "|"
#   # elsif turns == 1
#   #   @left_leg == "/"
#   # elsif turns == 0
#   #   @right_leg == "\\"
#
# end





# @body_parts.each_with_index do |part, index|
#   unless turns == @body_parts[index + 6]
#     part = " "
#     @body_parts[index] = part
#     puts @board
#   end
# end


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
