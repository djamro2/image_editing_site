class AddDefaultToStatus < ActiveRecord::Migration[5.0]
  def change
  	change_column :reversed_gifs, :status, :string, :default => "started"
  end
end
