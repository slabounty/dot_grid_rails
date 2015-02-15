class Document < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }

  validates :name, presence: true
  validates :file_name, presence: true
  validates :orientation, presence: true
  validates :page_type, presence: true
  validates :dot_weight, presence: true, numericality: { greater_than: 0.0 }
  validates :margin, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :page_size, presence: true
  validates :spacing, presence: true, numericality: { only_integer: true, greater_than: 0 }

  PAGE_ORIENTATION = %w[Portrait Landscape]
  PAGE_SIZE = %w[Letter Legal
    A0 A1 A2 A4 A5 A6 A7
    B0 B1 B2 B4 B5 B6 B7
  ]

  PAGE_TYPE = %w[
    planner checkerboard grid dot_grid 
    horizontal_rule grid_plus_lines dot_dash
  ]

  def planner_page?
    page_type == 'planner'
  end
end
