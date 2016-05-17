class AddSeoFieldsToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :seo_title, :string
    add_column :galleries, :seo_description, :string
    add_column :galleries, :seo_tags, :string
  end
end
