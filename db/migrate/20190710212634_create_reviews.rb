class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :owner_id
      t.text :comments
      t.float :score
    end
  end
end
