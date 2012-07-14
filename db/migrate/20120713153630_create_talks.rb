class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :title
      t.references :user
      t.references :co_presenter
      t.date :date
      t.text :description
      t.text :attend
      t.text :prepare
      t.text :expect
      t.integer :length

      t.timestamps
    end
    add_index :talks, :user_id
    add_index :talks, :co_presenter_id
    add_index :talks, :date
  end
end
