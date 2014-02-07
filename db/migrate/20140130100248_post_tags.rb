class PostTags < ActiveRecord::Migration
  def change
  	create_table :post_tags do |t|
  		t.belongs_to :post
  		t.belongs_to :tag

  		t.timestamps
  	end

  	add_index :post_tags, :post_id
  	add_index :post_tags, :tag_id
  end

end
