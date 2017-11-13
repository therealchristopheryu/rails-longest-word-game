require "open-uri"
class WordsController < ApplicationController
#   def game
#     @start_time = Time.now
#   end

#   def score
#     @attempt = params[:answer]
#     @end_time = Time.now
#     @grid_i = params[:size].to_i
#     @grid = generate_grid(10)
#     # @test = params[:size].class
#     # @score = run_game(@attempt, @grid, @start_time, @end_time)
#   end
# end

# def generate_grid(grid_size)
#   # TODO: generate random grid of letters
#   grid = []
#   letters = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
#   i = 0
#   while i < @grid_i
#     grid_size.times do
#       grid << letters[rand(26)]
#       i += 1
#     end
#   end
#   return grid
# end

# def time_check(start_time, end_time)
#   time_diff = @end_time - @start_time
#   points = @attempt.length / time_diff
# end

# # def run_game(attempt, grid, start_time, end_time)
# #   # TODO: runs the game and return detailed hash of result
# #   time_check(start_time, end_time)
# # end

  VOWELS = %w(A E I O U Y)

  def game
    #creating array of size 5 with array elements from VOWELS 
    @letters = Array.new(5) { VOWELS.sample }
    #adding another 5 elements (consonants) to @letters array
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
    @start_time = Time.now
  end

  def score
    @end_time = Time.now
    #passed start_time param through form and recalled it here
    @start_time = params[:start_time]
    @attempt = params[:word]
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
    @attempt = params[:word]
    @points = @attempt.length / time_check(Time.parse(@start_time), @end_time)
  end

  def time_check (start_time, end_time)
    @time_diff = end_time - start_time
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
