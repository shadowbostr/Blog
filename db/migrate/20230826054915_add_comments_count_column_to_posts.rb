# frozen_string_literal: true
class AddCommentsCountColumnToPosts < ActiveRecord::Migration[6.1]
  def up
    add_column :posts, :comments_count, :integer
    update_counters
  end

  def down
    remove_column :posts,:comments_count, :integer
  end
  def update_counters
    execute <<-SQL.squish
     UPDATE posts
     SET comments_count = (
     SELECT  count(1) FROM  comments WHERE comments.post_id = posts.id )
    SQL
  end
end
