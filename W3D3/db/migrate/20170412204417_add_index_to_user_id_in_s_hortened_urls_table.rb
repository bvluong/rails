class AddIndexToUserIdInSHortenedUrlsTable < ActiveRecord::Migration[5.0]
  def change
    add_index :shortened_urls, :user_id
  end
end
