require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = (0...5).map { (65 + rand(26)).chr }
  end

  def score
    @answer = params[:play]
    @letters = params[:letters]
      if @answer.chars.sort.all? { |letter| @letters.split(" ").include?(letter.upcase) }
      @message = 'word was formed from provided letters checking the dictionary to see if its an english word'
      url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
      word_dictionary = open(url).read
      word = JSON.parse(word_dictionary)
        if word["found"]
        @result = 'its an english word'
      else
        @result = 'its not and English word, try again !'
      end
    else
       @message = "please use the provided letters to form a word"
    end
  end
end
