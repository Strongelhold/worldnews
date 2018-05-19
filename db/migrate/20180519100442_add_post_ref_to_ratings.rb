class AddPostRefToRatings < ActiveRecord::Migration[5.1]
  def change
    add_reference :ratings, :post, foreign_key: true
  end
end
