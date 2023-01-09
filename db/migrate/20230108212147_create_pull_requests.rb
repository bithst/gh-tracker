class CreatePullRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :pull_requests do |t|
      t.string :title
      t.string :state
      t.references :repo, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :merged_at

      t.timestamps
    end
  end
end
