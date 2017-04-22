class CreateReversedGifs < ActiveRecord::Migration[5.0]
  def change
    create_table :reversed_gifs do |t|
      t.string :source_url
      t.string :reversed_url
      t.integer :views
      t.string :status
      t.timestamps
    end
  end
end
