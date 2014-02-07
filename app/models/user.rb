class User < ActiveRecord::Base
  include BCrypt
  has_many :posts

  def password
      @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.create(params)
    @user = User.new(email: params[:email])
    @user.password = params[:password]
    @user.save
    @user
  end

  def self.authenticate(params)
    @user = User.find_by(email: params[:email])
    if @user.password == params[:password]
      @user
    else
      nil
    end
  end
end
