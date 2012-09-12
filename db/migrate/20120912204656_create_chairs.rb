class CreateChairs < ActiveRecord::Migration
  def change
    create_table :chairs do |t|
      t.references :user
      t.timestamps
    end
  end
end
