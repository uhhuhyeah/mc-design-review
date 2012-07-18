class AddSlidesToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :slides_url, :string
  end
end
