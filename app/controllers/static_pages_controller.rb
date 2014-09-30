class StaticPagesController < ApplicationController
  def home
    @document = current_user.documents.build if signed_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
