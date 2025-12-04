class CreateItems < ActiveRecord::Migration[8.1]
  def change
    create_table :items do |t|
      t.string :title
      t.references :category, null: false, foreign_key: true
      t.integer :year
      t.string :creator_name
      t.string :image_url

      t.timestamps
    end
  end
end
