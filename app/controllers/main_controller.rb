class MainController < ApplicationController
  def index
    gon.job_desc
    Indeed.key=ENV['INDEED_KEY']
    unless params[:skill].nil?
      search_results = Indeed.search(:q => params[:skill], :l => params[:location])
      @results = search_results

      if search_results.empty?
        flash[:danger] = 'Sorry, there were no results for that skill. Try searching for a different one.'
      end

    @full_results = search_results[0..20].each_slice(3).to_a

    search_results = search_results[0..5]

    @search_results = search_results
    @i = 0
    job_descriptions = search_results.map {|result|
      job_key = result["jobkey"]
      @job_desc_string = get_job_description job_key
      string_to_arr @job_desc_string
      words_to_hash @words
    }
    @job_descriptions = job_descriptions
    gon.job_desc = job_descriptions
    @job = Job.new

    end
  end

end
