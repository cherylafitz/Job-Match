class UsersController < ApplicationController

  def index
    Indeed.key=ENV['INDEED_KEY']
    # AlchemyAPI.key=ENV['ALCHEMY_KEY']

    search_results = Indeed.search(:q => "designer", :l => "Seattle")
 # @query = params[:q]
    # result.totalResults #indeed returns number of results
    # Indeed.get('f8abbe5539f14420', '4fb26405a44d7eb8')
    search_results = search_results[0..3]
    # @mult_results = result[2...3]
    job_descriptions = search_results.map {|result|
      # @job_title = result["jobtitle"]
      @url = result["url"]
      # gets full description data from indeed
      response = RestClient.get(@url)
      html = response.body
      document = Nokogiri::HTML(html)
      job_desc_string = document.css('td.snip span#job_summary.summary').text.downcase
      # ignores filler words
      ignore_words = ['and','that','but','or','as','if','when','than',
        'because','while','where','after','so','though','since','until',
        'whether','before','although','nor','like','once','unless','now',
        'except','and/or','are','of','the','to','with','in','is','a','our',
        'for','an','we','including','not','at','on','etc.','them',',','be',
        'no','by','about','work','all','well']
      words = job_desc_string.split.delete_if{|w| ignore_words.include?(w)}
      # removes punctuation
      words.each do |word|
        word.gsub(/[^\p{Alnum}\p{Punct}\p]/, '').chomp
      end
      # counts words and turns into hash
      w_counts = Hash.new(0)
      words.each { |word| w_counts[word] += 1 }
      w_counts.delete_if {|k,v| v == 1}
      word_arr = w_counts.map do |key, value|
         {"text"=>key,"weight"=>value}
      end
    }
      @results = search_results

      gon.job_desc = job_descriptions

      # gon.word_arr = [{"word": "the","weight":1}]

      # gives word to jquery
      # gon.word_arr = word_arr

      # @word_arr = word_arr

    end


    # render :json => @data
    # @data = result.first


  end


