require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models/user.rb'
require './models/comment.rb'
require './models/post.rb'
require './models/good.rb'

enable :sessions

before %r[/(?!(signin|signup|login)).+] do
    if session[:user].nil?
        redirect '/'
    end
end

helpers do
  def good_find(post_id, user_id)
    Good.where(post_id: post_id, user_id: user_id).first   
  end
end

get '/' do
    erb :login
end

get '/index' do
    @posts = Post.all
    erb :index
end

# 投稿機能-------
get '/post' do
    
    erb :post
end

# 投稿
post '/post' do
    path = "/img/#{params[:photo][:filename]}"
    save_path = "#{Dir.pwd}/public/img/#{params[:photo][:filename]}"
    
    post = Post.new(
        user_id: session[:user],
        photo: path
        )
        
    if post.valid?
        File.open(save_path, 'w+b') do |fp|
            fp.write  params[:photo][:tempfile].read
        end
        
        post.save
        
        # 投稿に対する全ユーザーのgoodカラム追加
        User.all.each do |user|
            Good.create(post_id: post.id, user_id: user.id)
        end
    end
    
    redirect '/index' 
end

# 投稿削除
get '/delete/post/:id' do
   post = Post.find(params[:id])
   save_path = "#{Dir.pwd}/public#{post.photo}"
   File.delete save_path
   post.destroy
   
   redirect '/index'
end
#投稿機能おわり-------

# コメント機能-------
# コメント投稿
get '/comment/:p_id/:u_id' do
    comment = Comment.new(post_id: params[:p_id], user_id: params[:u_id], comment: params[:comment])

    if comment.valid?
        comment.save
    end
    
    redirect '/index'
end

# コメント削除
get '/delete/comment/:id' do
   comment = Comment.find(params[:id])
   comment.destroy

   redirect '/index'
end
    
# コメント機能終わり-------

# いいね機能-------
post '/good+1/:g_id/:p_id' do
    post = Post.find(params[:p_id])
    post.fovo = post.fovo + 1
    post.save
    
    good = Good.find(params[:g_id])
    good.good = true
    good.save
    
    post.fovo.to_s
end

post '/good-1/:g_id/:p_id' do
    post = Post.find(params[:p_id])
    post.fovo = post.fovo - 1
    post.save

    good = Good.find(params[:g_id])
    good.good = false
    good.save
    
    post.fovo.to_s
end

get '/good_list/:u_id' do
    @posts = Post.all
    erb :good
end

# いいね機能終わり-------

#ログイン部分-------
get '/signin' do
    erb :sign_in
end

get '/signup' do
    erb :sign_up
end

post '/signin' do
    user = User.find_by(user_name: params[:user_name])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
    end
    redirect '/index'
end

post '/signup' do
    @user = User.create(user_name:params[:user_name], password:params[:password], password_confirmation:params[:password_confirmation])
    if @user.valid?
        @user.save
        session[:user] = @user.id
        Post.all.each do |post|
            Good.create(post_id: post.id, user_id: session[:user])
        end
    end
    redirect '/index'
end

get '/signout' do
    session[:user] = nil
    redirect '/'
end

# ログイン部分おわり-------