class PostTags < ActiveRecord::Migration
  def change
  	create_table :post_tags do |t|
  		t.belongs_to :post
  		t.belongs_to :tag

  		t.timestamps
  	end

  	add_index :post_tags, :post
  	add_index :post_tags, :tag
  end

end
