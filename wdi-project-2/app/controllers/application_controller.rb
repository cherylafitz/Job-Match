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

  def get_job_description_arr result, job_key
      # @job = Job.new

      # :jobkey = @jobkey
      @url = "http://www.indeed.com/viewjob?jk=#{job_key}"
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
        'no','by','about','work','all','well','&','has','will','you','they','other',
        'from','have','must','this','may','your','required']
      words = job_desc_string.split.delete_if{|w| ignore_words.include?(w)}
      # removes punctuation
      words.each do |word|
        word.gsub(/[^\p{Alnum}\p{Punct}\p]/, '').chomp
      end

      words_to_hash words
      # counts words and turns into hash

  end

  def words_to_hash words
    w_counts = Hash.new(0)
    words.each { |word| w_counts[word] += 1 }
    w_counts.delete_if {|k,v| v == 1}
    word_arr = w_counts.map do |key, value|
       {"text"=>key,"weight"=>value}
    end
  end


end
