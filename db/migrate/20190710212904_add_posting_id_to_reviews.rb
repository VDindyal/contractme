class AddPostingIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :posting_id, :integer
  end
end
