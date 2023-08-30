class CreateJoinTablePostsUsersReadStatus < ActiveRecord::Migration[6.1]
  def change
    create_join_table :posts, :users , table_name: :posts_users_read_status, column_options: { null: true}
  end
  end
