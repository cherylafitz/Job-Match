class UsersController < ApplicationController

  require 'indeed'
  require 'jqcloud-rails'

  def index
    Indeed.key = ENV['INDEED_KEY']

    result = Indeed.search(:q => "ruby", :l => "Boston")
    # result.totalResults #indeed returns number of results
    # Indeed.get('f8abbe5539f14420', '4fb26405a44d7eb8')
    desc_string = result[0]["snippet"]
    words = desc_string.split(' ')
    words.each do |word|
      word.gsub(/[^\p{Alnum}\p{Punct}\p]/, '')
    end
    w_counts = Hash.new(0)
    words.each { |word| w_counts[word] += 1 }
    w_c_object = Hash.new(0)

    word_arr = w_counts.map do |key, value|
       {"text"=>key,"weight"=>value}
    end

    gon.word_arr = word_arr

    @word_arr = word_arr

    # render :json => @data
    # @data = result.first


  end

end
