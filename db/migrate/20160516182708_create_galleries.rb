class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :title
      t.string :description
      t.string :slug
      t.integer :position
      t.boolean :draft

      t.timestamps null: false
    end
  end
end
