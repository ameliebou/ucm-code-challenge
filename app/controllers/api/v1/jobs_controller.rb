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
    @job = Job.create(job_params)
    shifts_params[:shifts].each { |shift| Shift.create(start: shift[1][0], end: shift[1][1], job: @job) }
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
    params.require(:job).permit(
      :title,
      :salary_per_hour,
      { spoken_languages: [] }
    )
  end

  def shifts_params
    params.require(:job).permit(
      shifts: {
        shift_one: [],
        shift_two: [],
        shift_three: [],
        shift_four: [],
        shift_five: [],
        shift_six: [],
        shift_seven: []
      }

    )
  end

  def render_error
    render json: { errors: @job.errors.full_messages },
      status: :unprocessable_entity
  end
end
