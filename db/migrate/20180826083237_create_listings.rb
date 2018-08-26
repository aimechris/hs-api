class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :address
      t.integer :zip_code, :limit => 8
      t.string :city
      t.string :state
      t.integer :bed, :limit => 8
      t.integer :bath, :limit => 8
      t.decimal :sqft, :precision => 30, :scale => 20
      t.string :property_type
      t.integer :built_year, :limit => 8
      t.string :sale_type
      t.decimal :price, :precision => 15, :scale => 2
      t.string :title
      t.text :description
      t.string :virtual_tour
      t.string :display_img
      t.string :status, default: "available", null: false
      t.string :created_by
      t.timestamps
    end
  end
end
