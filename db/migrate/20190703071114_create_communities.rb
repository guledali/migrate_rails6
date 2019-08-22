class CreateCommunities < ActiveRecord::Migration[6.0]
  def change
    create_table :communities do |t|
      t.string :name
      t.string :title
      t.text :description
      t.string :sidebar

      t.timestamps
    end
    add_index :communities, :name, unique: true
  end
end
