Post.all.each do |post|
    User.all.each do |user|
        Good.where(post_id: post.id, user_id: user.id).first_or_create
    end
end