class AddBlogPostUrlToTalks < ActiveRecord::Migration
  def change
    add_column :talks, :blog_post_url, :string
  end
end
