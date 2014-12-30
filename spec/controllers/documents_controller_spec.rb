require 'spec_helper'

describe DocumentsController, :type => :controller do
  describe "POST #update" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    #it "finds the document" do
      #expect(Document).to receive(:find)
      #post :update, format: 'js'
    #end
  end
end
