class DocumentsController < ApplicationController
  before_action :signed_in_user

  def create
    Rails.logger.error "document_params = #{document_params}"
    if params[:commit] == 'Save'
      @document = current_user.documents.build(document_params)
      if @document.save
        flash[:success] = "Document created!"
        redirect_to root_url
      else
        render 'static_pages/home'
      end
    else
      Rails.logger.error "Hit Generate!!!"
      @document = Document.new(document_params)
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

  def document_params
    params.require(:document).permit(
      :name,
      :file_name,
      :orientation,
      :page_type,
      :dot_weight,
      :margin,
      :page_size,
      :grid_color,
      :spacing,
      :planner_color_1,
      :planner_color_2)
  end
end
