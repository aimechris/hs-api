class CreateInquiries < ActiveRecord::Migration[5.1]
  def change
    create_table :inquiries do |t|
      t.text :querry
      t.references :listing, foreign_key: true
      t.datetime :created_at
      
      t.timestamps
    end
  end
end
