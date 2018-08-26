class CreateJoinTablePostTag < ActiveRecord::Migration[5.1]
  def change
    create_join_table :posts, :tags do |t|
      t.index [:post_id, :tag_id]
      # t.index [:listing_id, :feature_id]
    end
  end
end
