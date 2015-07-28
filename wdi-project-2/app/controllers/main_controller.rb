class MainController < ApplicationController
  def index
    Indeed.key=ENV['INDEED_KEY']
    # AlchemyAPI.key=ENV['ALCHEMY_KEY']
    # search_results = Indeed.search(:q => 'design', :l => 'seattle')

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
      get_job_description_arr result, job_key

    }
    @job_descriptions = job_descriptions
    gon.job_desc = job_descriptions
    @job = Job.new

  end


  def job_params
    require.params(:job).permit(:jobkey,:user_id)
  end


end
