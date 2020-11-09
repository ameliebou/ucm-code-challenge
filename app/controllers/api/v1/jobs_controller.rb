class Api::V1::JobsController < Api::V1::BaseController
  def index
    if params[:title].present? && params[:spoken_language].present?
      @jobs = Job.search_by_title(params[:title]).search_by_spoken_language(params[:spoken_language]).limit(limit).offset(params[:offset])
    elsif params[:title].present?
      @jobs = Job.search_by_title(params[:title]).limit(limit).offset(params[:offset])
    elsif params[:spoken_language].present?
      @jobs = Job.search_by_spoken_language(params[:spoken_language]).limit(limit).offset(params[:offset])
    else
      @jobs = Job.limit(limit).offset(params[:offset])
    end
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      render json: @job, status: :created
    else
      render_error
    end
  end

  private

  def limit
    [
      params.fetch(:limit, 20).to_i,
      20
    ].min
  end

  def job_params
    params.require(:job).permit(:title, :salary_per_hour, { spoken_languages: [] }, { shifts: [] })
  end

  def render_error
    render json: { errors: @job.errors.full_messages },
      status: :unprocessable_entity
  end
end
