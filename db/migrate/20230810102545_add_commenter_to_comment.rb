class AddCommenterToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :commenter, :string
  end
end
