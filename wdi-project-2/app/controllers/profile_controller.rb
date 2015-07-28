class ProfileController < ApplicationController
  def index
    Indeed.key=ENV['INDEED_KEY']

    # render json: job_params
    @jobs = Job.where(user_id:current_user)
    @jobkey_arr = current_user.jobs.map do |job|
      job_key = job.jobkey
    end
    search_results = Indeed.get(@jobkey)
    job_descriptions = search_results.map {|result|
      # @job_title = result["jobtitle"]
      i = 0
      @jobkey_arr[i]
      get_job_description_arr result, job_key
      i+=1
    }
    gon.job_desc = job_descriptions
    @search_results = search_results
  end

  def add_job
    # @job =
    # render json: job_params
    @jobkey = params[:id]

    # @jobkey = job_params
    p @jobkey
    current_user.jobs.find_or_create_by jobkey:@jobkey
    redirect_to profile_index_path
  end

  private

  def job_params
    require.params(:job).permit(:jobkey)
  end

end
