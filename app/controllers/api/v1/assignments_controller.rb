class Api::V1::AssignmentsController < Api::V1::BaseController
  before_action :set_job
  acts_as_token_authentication_handler_for User

  def create
    @user = current_user
    @assignment = Assignment.new
    @assignment.user = @user
    @assignment.job = @job
    if @assignment.save
      render json: @assignment, status: :created
    else
      render_error
    end
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end

  def render_error
    render json: { errors: @assignment.errors.full_messages },
      status: :unprocessable_entity
  end
end
