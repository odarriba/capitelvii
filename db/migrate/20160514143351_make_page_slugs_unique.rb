class MakePageSlugsUnique < ActiveRecord::Migration
  def change
    remove_index :pages, :slug
    add_index :pages, :slug, :unique => true
  end
end
