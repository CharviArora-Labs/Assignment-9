class Api::V1::AppointmentsController < Api::BaseController

  def show
    raise ActiveRecord::RecordNotFound
  end

end