class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  # @author: Datt Dongare
  # DRY method for record not found, redirects to respective controller path
  def record_not_found
    model_and_id = {
      model: params[:controller].singularize,
      id: params[:id]
    }
    flash[:notice] = t('model.not_found', model_and_id)
    redirect_to action: :index
  end
end
