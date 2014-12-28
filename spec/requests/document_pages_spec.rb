require 'spec_helper'

describe "Document pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "document creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not create a document" do
        expect { click_button "Save" }.not_to change(Document, :count)
      end

      describe "error messages" do
        before { click_button "Save" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in 'document_name', with: "Lorem ipsum"
        fill_in 'document_file_name', with: "test.pdf"
        select  'Portrait', from: 'document_orientation'
        select  'planner', from: 'document_page_type'
        select  'Letter', from: 'document_page_size'
        fill_in 'document_dot_weight', with: "0.5"
        fill_in 'document_margin', with: "0"
        fill_in 'document_grid_color', with: "00ff00"
        fill_in 'document_spacing', with: "5"
        fill_in 'document_planner_color_1', with: "00ff00"
        fill_in 'document_planner_color_2', with: "00ff00"
      end

      it "should create a document" do
        expect { click_button "Save" }.to change(Document, :count).by(1)
      end
    end
  end

  describe "document edit" do
    let!(:document) { FactoryGirl.create(:document, user: user, name: "My Name", page_size: "A5") }

    describe "as correct user" do
      before { visit root_path }

      it "should show the document" do
        find("#document_#{document.id}", :text => 'My Name').click
        expect(page).to have_content('A5')
      end
    end
  end

  describe "document deletion" do
    let!(:document) { FactoryGirl.create(:document, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a document" do
        expect { click_link "trash_#{document.id}" }.to change(Document, :count).by(-1)
      end
    end
  end
end
