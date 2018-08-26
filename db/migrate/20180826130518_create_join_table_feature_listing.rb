class CreateJoinTableFeatureListing < ActiveRecord::Migration[5.1]
  def change
    create_join_table :features, :listings do |t|
      t.index [:feature_id, :listing_id]
      # t.index [:listing_id, :feature_id]
    end
  end
end
