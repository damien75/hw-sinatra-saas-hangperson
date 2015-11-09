class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses , :word_with_guesses , :check_win_or_lose
  
  def initialize(word)
    @word = word
    @word_with_guesses = '-' * word.length
    @guesses = ''
    @wrong_guesses = ''
    @check_win_or_lose = :play
  end
  
  def guess(letter)
    raise ArgumentError, 'Input guess must not be empty or nil' unless !letter.nil? && letter.length > 0
    letter.downcase!
    raise ArgumentError, 'Input guess must be a letter' unless letter >= 'a' && letter <= 'z'
    if !@word.include?(letter)
      if @wrong_guesses.include?(letter)
        return false
      else
        @wrong_guesses << letter
        if @wrong_guesses.length >= 7
          @check_win_or_lose = :lose
        end
        return true
      end
    else
      if @guesses.include?(letter)
        return false
      else
        @guesses << letter
        l_index = @word.index(letter)
        while !l_index.nil? do
          @word_with_guesses[l_index] = letter
          l_index = @word.index(letter , l_index + 1)
        end
        if @word == @word_with_guesses
          @check_win_or_lose = :win
        end
        return true
      end
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
