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
  # if turns == key, put value. and refresh. 
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
  attr_accessor :display_array

  def initialize(mystery_word)
    @mystery_word   = mystery_word
    @display_array  = Array.new(mystery_word.length, "__")
  end

  # This creates display array with user guess input at index
  def display(guess)
    @mystery_word.each_with_index do |letter, index|
      if letter == guess
        @display_array[index] = letter
      end
    end
    print @display_array.join " "
  end
end

#######################
# Total Letter Bank
#######################

# LetterBank should display the letter options to user,
# then subtract out used letters

class LetterBank
  attr_accessor :unused_letters

  def make_bank(guesses)
    @unused_letters = ("a".."z").to_a
    @unused_letters.map.with_index do |letter, index|
      if guesses.include? letter
        @unused_letters[index] = "__"
      end
    end
    puts "Choose from these letters"
    print @unused_letters.join ", "
    puts "\n" * 3
  end
end

#######################
# Turns
#######################

# Turn class advances game

class Turn
  attr_accessor :turns

  def initialize (mystery_word)
    @mystery_word = mystery_word
    @turns = 7
  end

  def dying
    @turns -= 1
  end

  # Advances game 1 turn closer to death for wrong answers
  def turn_checker(user_guess)
    unless @mystery_word.include?(user_guess)
      dying
    end
  end
end

#######################
# PLAYER 1
#######################

def gameplay

  puts "Welcome to Hangman!"
  puts "Player 1, what is your mystery word?"
  mystery_word = gets.chomp.downcase.chars

  OriginalWord.new(mystery_word)

  puts " \n" * 100

  #######################
  # PLAYER 2
  #######################

  # Setting up neccessary arrays instantiating objects

  guesses = []
  game_progress = Turn.new(mystery_word)
  gameboard = Hangman.new
  blanks = BlankLetters.new(mystery_word)
  letter_options = LetterBank.new

  while game_progress.turns > 0

    puts " "
    puts "Player 2, what letter would you like to guess?"
    guess = gets.chomp.downcase

    # Creates array of unique entries only.
    if guesses.include?(guess)
      puts "You already guessed that letter"
      next
    else
      guesses << guess
    end

    # Display remaining letter options.
    letter_options.make_bank(guesses)

    # Advances games by 1 turn or not depending on guess
    game_progress.turn_checker(guess)

    # Display Hangman image based on turns
    gameboard.draw(game_progress.turns)

    # Creates blank slot and checks if user guess is right
    blanks.display(guess)

    if (mystery_word - guesses).empty?
      puts " "
      abort "YOU WIN!"
    end
  end

  puts ""
  puts "Sorry, You died."
  puts "The mystery word was #{mystery_word.join}"
end

gameplay

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
