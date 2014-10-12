class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :user_id
      t.string :name
      t.string :file_name
      t.string :orientation
      t.string :page_type
      t.float :dot_weight
      t.float :margin
      t.string :page_size
      t.string :grid_color
      t.integer :spacing
      t.string :planner_color_1
      t.string :planner_color_2

      t.timestamps
    end
    add_index :documents, [:user_id, :created_at]
  end
end
