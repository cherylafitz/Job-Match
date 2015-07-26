class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  require 'jqcloud-rails'
  require 'indeed'
  require 'rest-client'
  require 'nokogiri'

  def get_job_cloud result
      @job_title = result["jobtitle"]
      @url = result["url"]
      # gets full description data from indeed
      response = RestClient.get(@url)
      html = response.body
      document = Nokogiri::HTML(html)
      job_description = document.css('td.snip span#job_summary.summary').text.downcase
      # ignores filler words
      ignore_words = ['of','a','an','also','besides','equally','further','furthermore','in',
        'addition','moreover','too','after','before','when','while','as','by','the','that',
        'since','until','soon','once','so','whenever','every','first','last','because','even',
        'though','although','whereas','if','unless','only','whether','or','not','next','likewise',
        'however','contrary','other','hand','contrast','nevertheless','brief','summary','short',
        'for','example','instance','fact','finally','conclusion','inshort','insummary','therefore',
        'accordingly','asaresult','consequently','afterward','meantime','later','meanwhile','second',
        'earlier','still','then','third','and','but','than','where','nor','like','now','except',
        'and/or','are','to','with','is','our','we','including','at','on','etc','them','be','no',
        'about','work','all','well','this','any','it','have']
      words = job_description.split.delete_if{|w| ignore_words.include?(w)}
      # removes punctuation
      words.each do |word|
        word.gsub!(/[^a-z ]/, '')
      end
      # counts words and turns into hash
      w_counts = Hash.new(0)
      words.each { |word| w_counts[word] += 1 }
      w_counts.delete_if {|k,v| v == 1}
      @word_arr = w_counts.map do |key, value|
         {"text"=>key,"weight"=>value}
      end
  end
end
