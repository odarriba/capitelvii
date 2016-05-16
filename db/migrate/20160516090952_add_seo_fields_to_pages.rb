class AddSeoFieldsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :seo_title, :string
    add_column :pages, :seo_description, :string
    add_column :pages, :seo_tags, :string
  end
end
