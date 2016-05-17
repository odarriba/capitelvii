class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :description
      t.string :file

      t.belongs_to :gallery

      t.timestamps null: false
    end

    add_index :pictures, :gallery_id
  end
end
