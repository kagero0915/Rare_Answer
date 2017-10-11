ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
class User < ActiveRecord::Base
    has_secure_password
    has_many :posts, dependent: :destroy
    has_many :posts, :through => :comments

    validates :user_name,
    presence: true
    validates :password,
    length: {in: 5..10}
end