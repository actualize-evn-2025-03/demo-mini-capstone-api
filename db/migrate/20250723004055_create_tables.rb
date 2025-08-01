class CreateTables < ActiveRecord::Migration[8.0]
  def change
    create_table :tables do |t|
      t.integer :height
      t.integer :width
      t.string :description

      t.timestamps
    end
  end
end
