require 'pry'

get "/create_post" do
	erb :create_post
end

post "/create_post" do
  p = Post.create(title: params[:title], author: "anonymous", 
               body: params[:body])

  params[:category].split(",").each do |c|
    p.tags << Tag.find_or_create_by_category(c.strip)
  end

  redirect to "/"
end

post "/get_post" do
  redirect to "/edit_post/#{params[:id]}"
end

post "/post" do
  redirect to "/post/#{params[:id]}"
end

get "/edit_post/:post_id" do
  @p = Post.find_by_id(params[:post_id])
  erb :edit_post
end

post "/edit_post" do
  @p = Post.find_by_id(params[:id])
  @p.update_attributes(title: params[:title], body: params[:body])
  @p.save
  redirect to "/"
end

get "/post/:post_id" do
  @p = Post.find_by_id(params[:post_id])
  erb :post
end

get "/view_all" do
  erb :view_all
end