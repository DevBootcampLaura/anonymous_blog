class Posts < ActiveRecord::Migration
  def change
  	create_table :posts do |t|
  		t.string :title
  		t.string :author
  		t.belongs_to :user
  		t.text :body

  		t.timestamps
  	end

  	add_index :posts, :user_id
  end
end
