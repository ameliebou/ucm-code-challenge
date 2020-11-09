class Api::V1::JobsController < Api::V1::BaseController
  def index
    @jobs = Job.limit(limit).offset(params[:offset])
  end

  private

  def limit
    [
      params.fetch(:limit, 20).to_i,
      20
    ].min
  end
end
