class RemoveColumn < ActiveRecord::Migration[5.0]
  def change
  	remove_column :reversed_gifs, :views, :string, {}
  end
end
