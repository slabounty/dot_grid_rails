class StaticPagesController < ApplicationController
  def home
    @documents = current_user.documents if signed_in?
    @document = Document.new if signed_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
