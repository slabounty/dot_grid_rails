require 'spec_helper'

describe DocumentsController do
  describe "POST update" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:document) { FactoryGirl.create(:document) }

    before do
      sign_in(user, no_capybara: true)
      allow(Document).to receive(:find).and_return(document)
    end

    context "when the document can be updated" do
      it "updates the document" do
        expect(document).to receive(:update)
        post :update, {format: :js, commit: 'Save', document: document.attributes }
      end

      it "sets the flash error message" do
        post :update, {format: :js, commit: 'Save', document: document.attributes }
        expect(flash[:success]).to eq('Document updated.')
      end
    end

    context "when the document can not be updated" do
      before do
        allow(document).to receive(:update).and_return(false)
      end

      it "sets the flash error message" do
        post :update, {format: :js, commit: 'Save', document: document.attributes }
        expect(flash[:error]).to eq('Document update failed.')
      end
    end
  end

  describe "POST edit" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:document) { FactoryGirl.create(:document) }

    before do
      sign_in(user, no_capybara: true)
      allow(Document).to receive(:find).and_return(document)
    end

    it "finds the document" do
      expect(Document).to receive(:find).and_return(document)
      post :edit, {format: :js, id: document.id }
    end
  end

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

    context "when there are valid parameters" do
      it "creates a new document" do
        expect(Document).to receive(:new).and_return(document)
        post :generate_and_send, { format: :js, document: document.attributes }
      end

      it "generates a document" do
        expect(dot_grid_document).to receive(:generate)
        post :generate_and_send, { format: :js, document: document.attributes }
      end

      it "downloads the document" do
        expect(controller).to receive(:send_file).with("My Filename", hash_including(filename: "My Filename"))
        post :generate_and_send, { format: :js, document: document.attributes }
      end
    end

    context "when the parameters are invalid" do
      before do
        allow(Document).to receive(:new).and_return(double(valid?: false).as_null_object)
      end

      it "sets the flash error message" do
        post :generate_and_send, {format: :js, document: document.attributes }
        expect(flash[:error]).to eq('Could not generate document.')
      end

      it "returns a 400" do
        post :generate_and_send, {format: :js, document: document.attributes }
        expect(response.status).to eq(400)
      end
    end
  end
end
