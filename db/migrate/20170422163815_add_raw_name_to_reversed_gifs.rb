class AddRawNameToReversedGifs < ActiveRecord::Migration[5.0]
  def change
    add_column :reversed_gifs, :raw_name, :string
  end
end
