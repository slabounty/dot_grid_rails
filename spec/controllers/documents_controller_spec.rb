require 'spec_helper'

describe DocumentsController do
  describe "POST generate_and_send" do
    let(:user) { FactoryGirl.create(:user) }
    let(:document) { FactoryGirl.build(:document) }
    let(:dot_grid_document) { double(file_name: "My Filename").as_null_object }

    before do
      sign_in(user, no_capybara: true)
      allow(controller).to receive(:render)
      allow(controller).to receive(:send_file)
      allow(Document).to receive(:new).and_return(document)
      allow(::DotGrid::Document).to receive(:new).and_return(dot_grid_document)
    end

    it "creates a new document" do
      expect(Document).to receive(:new).and_return(document)
      post :generate_and_send, { document: document.attributes }
    end

    it "generates a document" do
      expect(dot_grid_document).to receive(:generate)
      post :generate_and_send, { document: document.attributes }
    end

    it "downloads the document" do
      expect(controller).to receive(:send_file).with("My Filename", hash_including(filename: "My Filename"))
      post :generate_and_send, { document: document.attributes }
    end

  end
end
