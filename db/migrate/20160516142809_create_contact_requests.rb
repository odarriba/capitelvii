class CreateContactRequests < ActiveRecord::Migration
  def change
    create_table :contact_requests do |t|
      t.string :name
      t.string :email
      t.integer :phone
      t.string :body

      t.timestamps null: false
    end
  end
end
