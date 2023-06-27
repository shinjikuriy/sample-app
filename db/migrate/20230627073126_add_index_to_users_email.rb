class AddIndexToUsersEmail < ActiveRecord::Migration[7.0]
  def change
    #usersテーブルのemailカラムにindexを追加し、uniqueオプションを有効にする
    add_index :users, :email, unique: true
  end
end
