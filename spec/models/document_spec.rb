require 'spec_helper'

describe Document do
  let(:user) { FactoryGirl.create(:user) }
  let(:document) { user.documents.build(
    name:  "My Cool Document",
    file_name:  "document.pdf",
    orientation: "LANDSCAPE",
    page_type:  "A4",
    dot_weight:  "0.5",
    margin:  0.0,
    page_size:  "LEGAL",
    grid_color:  "B3B3B3",
    spacing: 5,
    planner_color_1: "CCCCCC",
    planner_color_2: "0099ff"
  )
  }

  subject { document }

  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:name) }
  it { should respond_to(:file_name) }
  it { should respond_to(:orientation) }
  it { should respond_to(:page_type) }
  it { should respond_to(:dot_weight) }
  it { should respond_to(:margin) }
  it { should respond_to(:page_size) }
  it { should respond_to(:grid_color) }
  it { should respond_to(:spacing) }
  it { should respond_to(:planner_color_1) }
  it { should respond_to(:planner_color_2) }

  it { should be_valid }

  describe "with blank name" do
    before { document.name = " " }
    it { should_not be_valid }
  end

  describe "with blank file_name" do
    before { document.file_name = " " }
    it { should_not be_valid }
  end

  describe "with blank orientation" do
    before { document.orientation = " " }
    it { should_not be_valid }
  end

  describe "with blank page_type" do
    before { document.page_type = " " }
    it { should_not be_valid }
  end

  describe "with blank dot_weight" do
    before { document.dot_weight = nil }
    it { should_not be_valid }
  end

  describe "with negative dot_weight" do
    before { document.dot_weight = -1.2 }
    it { should_not be_valid }
  end

  describe "with blank margin" do
    before { document.margin = nil }
    it { should_not be_valid }
  end

  describe "with negative margin" do
    before { document.margin = -1.2 }
    it { should_not be_valid }
  end

  describe "with blank page_size" do
    before { document.page_size = " " }
    it { should_not be_valid }
  end

  describe "with blank grid_color" do
    before { document.grid_color = " " }
    it { should_not be_valid }
  end

  describe "with blank spacing" do
    before { document.spacing = nil }
    it { should_not be_valid }
  end

  describe "with zero spacing" do
    before { document.spacing = 0 }
    it { should_not be_valid }
  end

  describe "with negative spacing" do
    before { document.spacing = -1 }
    it { should_not be_valid }
  end

  describe "with blank planner_color_1" do
    before { document.planner_color_1 = " " }
    it { should_not be_valid }
  end

  describe "with blank planner_color_2" do
    before { document.planner_color_2 = " " }
    it { should_not be_valid }
  end
end
