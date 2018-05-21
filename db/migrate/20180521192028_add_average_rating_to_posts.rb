class AddAverageRatingToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :average_rating, :integer
    add_index :posts, :average_rating
  end
end
