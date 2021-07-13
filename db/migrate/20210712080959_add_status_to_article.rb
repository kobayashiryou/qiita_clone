class AddStatusToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :status, :boolean, default: true, null: false
  end
end
