class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title,          null: false
      t.string :slug,           null: false
      t.text :body
      t.integer :order,         default: 0
      t.boolean :show_in_menu,  default: true
      t.boolean :draft,         default: true

      t.timestamps null: false
    end

    add_index :pages, :slug
  end
end
