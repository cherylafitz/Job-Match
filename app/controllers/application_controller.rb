class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_user

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def is_authenticated?
    unless @current_user
      flash[:danger] = 'Access denied.'
      redirect_to login_path

    end
  end

  def scrape_website job_key
    @url = "http://www.indeed.com/viewjob?jk=#{job_key}"
    response = RestClient.get(@url)
    html = response.body
    @document = Nokogiri::HTML(html)
  end

  def get_job_title job_key
    scrape_website job_key
    @job_title = @document.css('#job_header .jobtitle').text
  end

  def get_company job_key
    scrape_website job_key
    @job_title = @document.css('#job_header .company').text
  end

  def get_location job_key
    scrape_website job_key
    @job_title = @document.css('#job_header .location').text
  end

  def get_job_description job_key
    scrape_website job_key
    @job_desc_string = @document.css('td.snip span#job_summary.summary').text.downcase
  end

  def string_to_arr job_desc_string
    # require 'active_support/core_ext/string'
    ignore_words = ['and','that','but','or','as','if','when','than',
      'because','while','where','after','so','though','since','until',
      'whether','before','although','nor','like','once','unless','now',
      'except','and/or','are','of','the','to','with','in','is','a','our',
      'for','an','we','including','not','at','on','etc.','them',',','be',
      'no','by','about','work','all','well','&','has','will','you','they','other',
      'from','have','must','this','may','your','required','*','•','1','2','3','4',
      '5','6','7','8','9',' ','–']
      # puts job_desc_string
    job_desc_string.downcase!
    job_desc_string.gsub!(/\d\s?/, '')
    # puts job_desc_string
    @words = job_desc_string.split.delete_if{|w| ignore_words.include?(w)}
    # removes punctuation
    # puts @words
    @words.reject! { |w| w.empty? }
    @words.reject! { |e| e.nil? || e == ''}

    @words.map do |word|
      word.gsub!(/(\W|\d)/, "")
      word = word.singularize
    end
    # puts @words
    # puts @words
  end

  def words_to_hash words
    w_counts = Hash.new(0)
    words.each { |word| w_counts[word] += 1 }
    w_counts.delete_if {|k,v| v == 1} && words.length > 50
    word_arr = w_counts.map do |key, value|
       {"text"=>key,"weight"=>value}
    end
  end


end
