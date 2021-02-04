class AddProfileImageIdToBookComment < ActiveRecord::Migration[5.2]
  def change
    add_column :book_comments, :profile_image_id, :integer
  end
end
