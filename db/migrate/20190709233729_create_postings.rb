class CreatePostings < ActiveRecord::Migration[5.2]
  def change
    create_table :postings do |t|
      t.string :category
      t.integer :owner_id
      t.string :name
      t.string :location
      t.string :phone_number
      t.float :price
      t.text :description
    end
  end
end
