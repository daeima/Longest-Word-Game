require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    api_answer = JSON.parse(open(url).read)
    api_answer['found']
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].chars

    if (@word.chars - @letters).empty?
      if english_word?(@word)
        @output = "Congratulations! #{@word} is a valid English word"
      else
        @output = "Sorry but #{@word} is not a English word"
      end
    else
      @output = "Sorry but #{@word} can't be build out of #{@letters.join(',')}"
    end
  end
end
