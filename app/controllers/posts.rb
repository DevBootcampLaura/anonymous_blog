require 'pry'



# get routes ====================================

get "/create_post" do
	erb :create_post
end

get "/create_post/error" do
  @error = "The post you have created is invalid. Title and post fields may not be empty."
  erb :create_post
end 

get "/edit_post/:post_id" do
  @post = Post.find_by_id(params[:post_id])
  erb :edit_post
end

get "/edit_post/:post_id/error" do
  @post = Post.find_by_id(params[:post_id])
  @error = "The post you have created is invalid. Title and post fields may not be empty."
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
  post = Post.create(params[:post])

  if post.valid?
    params[:tag].values.join.split(" ").each do |c|
      post.tags << Tag.find_or_create_by_category(c.strip)
    end
    redirect to "/post/#{post.id}"
  else
    redirect to "/create_post/error"
  end
end

post "/get_post" do
  redirect to "/edit_post/#{params[:id]}"
end

post "/post" do
  @error = "The post you have made is invalid."
  redirect to "/post/#{params[:id]}"
end

post "/edit_post" do
  @post = Post.find_by_id(params[:id])
  @post.update_attributes(params[:post])

  if @post.valid?
    params[:tag].values.join.split(" ").each do |c|
      if @post.tags.find_by_category(c.strip) == nil
        @post.tags << Tag.find_or_create_by_category(c.strip)
      end
    end
    @post.save
    redirect to "/post/#{@post.id}"
  else
    redirect to "/edit_post/#{@post.id}/error"
  end
end


post "/tag" do
  redirect to "/tag/#{params[:category]}"
end







