class RemoveNotNullConstraintFromPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :topic_id, true
  end
end
