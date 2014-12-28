class DocumentsController < ApplicationController
  before_action :signed_in_user

  def create
    respond_to do |format|
      format.js do
        if params[:commit] == 'Save'
          @document = current_user.documents.build(document_params)
          if @document.save
            flash[:success] = "Document created!"
            render 'edit'
          else
            flash[:error] = "Could not create document."
            render 'edit'
          end
        end
      end
    end
  end

  def update
    respond_to do |format|
      format.js do
        if params[:commit] == 'Save'
          @document = Document.find(params[:id])
          if @document.update(document_params)
            flash[:success] = "Document updated."
            render 'edit'
          else
            flash[:error] = "Document update failed."
            render 'edit'
          end
        #else
          #Rails.logger.error("\n\n\n update generate_and_send \n\n\n")
          #generate_and_send
        end
      end
    end
  end

  def edit
    @document = Document.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    Document.find(params[:id]).destroy
    flash[:success] = "Document deleted."
    redirect_to root_path
  end

  def generate_and_send
    if Document.new(document_params).valid?
      document = ::DotGrid::Document.new(
        {
          file_name: document_params[:file_name],
          orientation: document_params[:orientation],
          page_types: document_params[:page_type],
          dot_weight: document_params[:dot_weight].to_f,
          margin: document_params[:margin].to_f,
          page_size: document_params[:page_size].upcase,
          grid_color: document_params[:grid_color].gsub(/^#/, ''),
          spacing: document_params[:spacing].to_i,
          planner_color_1: document_params[:planner_color_1].gsub(/^#/, ''),
          planner_color_2: document_params[:planner_color_2].gsub(/^#/, '')
        })

      cookies['fileDownload'] = 'true'
      document.generate

      send_file document.file_name, filename: document.file_name, x_sendfile: true
    else
      respond_to do |format|
        format.js do
          flash[:error] = "Could not generate document."
          head 400, content_type: "text/html"
        end
      end
    end
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
