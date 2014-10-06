class DocumentsController < ApplicationController
  before_action :signed_in_user

  def create
    if params[:commit] == 'Save'
      @document = current_user.documents.build(document_params)
      if @document.save
        flash[:success] = "Document created!"
        redirect_to root_url
      else
        render 'static_pages/home'
      end
    else
      document = ::DotGrid::Document.new(
        {
          file_name: document_params[:file_name],
          orientation: document_params[:orientation],
          page_type: document_params[:page_type],
          dot_weight: document_params[:dot_weight].to_f,
          margin: document_params[:margin].to_f,
          page_size: document_params[:page_size].upcase,
          grid_color: document_params[:grid_color],
          spacing: document_params[:spacing].to_i,
          planner_color_1: document_params[:planner_color_1],
          planner_color_2: document_params[:planner_color_2]
        })
      document.generate

      send_file document.file_name, filename: document.file_name
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
