require 'pry'



# get routes ====================================

get "/create_post" do
	erb :create_post
end

get "/edit_post/:post_id" do
  @post = Post.find_by_id(params[:post_id])
  erb :edit_post
end

get "/post/:post_id" do
  @p = Post.find_by_id(params[:post_id])
  erb :post
end

get "/view_all" do  
  erb :view_all
end

get "/tag/:category" do
  tag = Tag.find_by_category(params[:category])
  @posts = []
  Post.all.each do |post|
    @posts << post if post.tags.include?(tag)
  end

  erb :tag
end



# post routes =====================================

post "/create_post" do
  p = Post.create(params[:post])

  params[:tag].values.join.split(" ").each do |c|
    p.tags << Tag.find_or_create_by_category(c.strip)
  end

  redirect to "/post/#{p.id}"
end

post "/get_post" do
  redirect to "/edit_post/#{params[:id]}"
end

post "/post" do
  redirect to "/post/#{params[:id]}"
end

post "/edit_post" do
  @post = Post.find_by_id(params[:id])
  @post.update_attributes(params[:post])

  params[:tag].values.join.split(" ").each do |c|
    if @post.tags.find_by_category(c.strip) == nil
      @post.tags << Tag.find_or_create_by_category(c.strip)
    end
  end

  @post.save
  redirect to "/post/#{@post.id}"
end


post "/tag" do
  redirect to "/tag/#{params[:category]}"
end







