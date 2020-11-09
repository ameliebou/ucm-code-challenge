class Api::V1::JobsController < Api::V1::BaseController
  def index
    @jobs = Job.limit(limit).offset(params[:offset])
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
