class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :title
      t.text :description
      t.string :link_name
      t.string :link_uri
      t.integer :sort
      t.string :image

      t.timestamps null: false
    end
  end
end
