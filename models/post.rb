ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
class Post < ActiveRecord::Base
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :goods, dependent: :destroy
    has_many :users, :through => :comments
end
