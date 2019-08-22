class AddSlugToCommunities < ActiveRecord::Migration[6.0]
  def change
    add_column :communities, :slug, :string
    add_index :communities, :slug, unique: true
  end
end
