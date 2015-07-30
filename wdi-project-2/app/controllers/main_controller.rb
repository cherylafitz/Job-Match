class MainController < ApplicationController
  def index
    Indeed.key=ENV['INDEED_KEY']
    # AlchemyAPI.key=ENV['ALCHEMY_KEY']
    # search_results = Indeed.search(:q => 'design', :l => 'seattle')
    unless params[:skill].nil?
      search_results = Indeed.search(:q => params[:skill], :l => params[:location])
      @results = search_results



    # result.totalResults #indeed returns number of results
    # Indeed.get('f8abbe5539f14420', '4fb26405a44d7eb8')

    search_results = search_results[0..2]

    @search_results = search_results
    # @mult_results = result[2...3]
    job_descriptions = search_results.map {|result|
      # @job_title = result["jobtitle"]
      job_key = result["jobkey"]
      @job_desc_string = get_job_description job_key
      # puts @job_desc_string
      string_to_arr @job_desc_string
      # puts string_to_arr @job_desc_string
      # puts words_to_hash @words
      words_to_hash @words
    }
    @job_descriptions = job_descriptions
    gon.job_desc = job_descriptions
    @job = Job.new
    end

  end


  def job_params
    require.params(:job).permit(:jobkey,:user_id)
  end


end
