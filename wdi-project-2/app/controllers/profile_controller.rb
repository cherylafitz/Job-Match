class ProfileController < ApplicationController
  def index
    Indeed.key=ENV['INDEED_KEY']

    # render json: job_params
    @jobs = current_user.jobs
    @jobkey_arr = current_user.jobs.map do |job|
      @job_key = job.jobkey
    end

    # @title = Job.title.where(jobkey:)
    # @location = current_user.jobs[:location]
    # @company = current_user.jobs[:company]

    job_descriptions = @jobkey_arr.map {|job_key|
      # @job_title = result["jobtitle"]
      @job_desc_string = get_job_description job_key
      @job_arr = string_to_arr @job_desc_string
      words_to_hash @words
    }



    gon.job_desc = job_descriptions

    if current_user.resume
      resume = current_user.resume

      @resume_array = string_to_arr resume
      @things = words_to_hash @words
      gon.resume = @things
    end

    # @combined_arr = job_descriptions.map
      # @combined_words = @resume_array & @job_arr

    # get_job_description result, job_key

    # job_descriptions = search_results.map {|result|
    #   # @job_title = result["jobtitle"]
    #   i = 0
    #   @jobkey_arr[i]
    #   get_job_description_arr result, job_key
    #   i+=1
    # }
    # gon.job_desc = job_descriptions
    # @search_results = search_results

    # render json: current_user.jobs
    # render plain: @resume
  end

  def edit

  end

  def destroy
    j = Job.find params[:id]
    j.delete
    redirect_to profile_path
  end

  def update
    @current_user = current_user.id
    current_user.update params[:resume]
    redirect_to profile_path
  end

  def add_job
    # @job =
    # render json: job_params
    @jobkey = params[:id]

    # @jobkey = job_params
    p @jobkey
    @description = get_job_description @jobkey
    @job_location = get_location @jobkey
    @company = get_company @jobkey
    @job_title = get_job_title @jobkey
    current_user.jobs.find_or_create_by(jobkey:@jobkey,description:@description,
      title:@job_title,company:@company,location:@job_location)
    redirect_to profile_path
  end

  private

  def job_params
    require.params(:job).permit(:jobkey)
  end

  # def compare_job_resume job_desc resume
  #   job_desc & resume
  # end

end
