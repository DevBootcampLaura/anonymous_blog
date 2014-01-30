get "/create_post" do
	erb :create_post
end

post "/create_post" do
  p = Post.create(title: params[:title], author: "anonymous", 
               body: params[:body])

  params[:category].split(",").each do |c|
    c = c.strip
    if Tag.find_by_category(c) == nil
      t = Tag.create(category: c)
      p.tags << t
    else
      p.tags << Tag.find_by_category(c)
    end
  end

  redirect to "/"
end





get "/edit_post" do
  erb :edit_post
end

get "/post" do
  erb :post
end

get "/view_all" do
  erb :view_all
end