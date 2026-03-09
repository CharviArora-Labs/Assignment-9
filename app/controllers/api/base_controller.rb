class Api::BaseController < ActionController::API
  before_action :attach_request_id

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from StandardError, with: :handle_internal_error

  private

  def attach_request_id
    response.set_header("X-Request-ID", request.request_id)
  end

  def handle_not_found(exception)
    render_error(
      code: "not_found",
      message: exception.message,
      status: :not_found
    )
  end

  def handle_internal_error(exception)
    Rails.logger.error(
      "[#{request.request_id}] #{exception.class} #{exception.message}"
    )

    render_error(
      code: "internal_error",
      message: "Something went wrong",
      status: :internal_server_error
    )
  end

  def render_error(code:, message:, status:)
    render json: {
      error: {
        code: code,
        message: message,
        request_id: request.request_id
      }
    }, status: status
  end
end
